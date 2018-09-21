
import json
import datetime
from django.db import models
from django.db import transaction


class CloudFactoryRun(models.Model):
    """Store information about current and past CloudFactory runs."""

    line_id = models.CharField(
        max_length=64, help_text="the id of the production line at CloudFactory."
    )
    run_id = models.CharField(
        max_length=64,
        blank=True,
        default="",
        help_text="The id of this production run at CloudFactory.",
    )
    callback_url = models.CharField(
        max_length=1024,
        blank=True,
        default="",
        help_text="The URL to which CloudFactory will submit the results of the production run.",
    )
    status = models.CharField(
        max_length=32, blank=True, default="", help_text="The status of the run at CloudFactory."
    )
    message = models.TextField(blank=True, help_text="Any message returned by CloudFactory.")
    created_at = models.DateTimeField(
        blank=True, null=True, help_text="When the run was created at CloudFactory."
    )
    processed_at = models.DateTimeField(
        blank=True, null=True, help_text="When run processing was finished at CloudFactory."
    )

    def __repr__(self):
        keys = [key for key in ['id', 'line_id'] if key in self.__dict__.keys()]
        return u"%s(%s)" % (
            self.__class__.__name__,
            u", ".join([u"%s=%r" % (key, self.__dict__[key]) for key in keys]),
        )

    @property
    def post_data(self):
        """create a data to POST the run to CloudFactory"""
        return dict(
            units=[unit.post_data for unit in self.cloudfactoryunit_set.all()],
            **{key: self.data[key] for key in ['line_id', 'callback_url']}
        )

    @property
    def data(self):
        """working with celery and email requires being able to provide json for the instance"""
        return dict(
            units=[unit.data for unit in self.cloudfactoryunit_set.all()],
            **{
                key: (
                    str(val)  # datetime.datetime and datetime.date as str
                    if isinstance(val, datetime.datetime) or isinstance(val, datetime.date)
                    else val
                )
                for key, val in self.__dict__.items()
                if key[0] != '_'  # exclude utility vals like _state
            }
        )

    @transaction.atomic
    def save_cloudfactory_response(self, data):
        """Save the data from a CloudFactory response on the run's url at CloudFactory.
        """
        for key in ['status', 'created_at', 'processed_at']:
            if key in data:
                self.__dict__[key] = data[key]

        # we're just rewriting the unit_set to match the CloudFactory response. 
        self.cloudfactoryunit_set.all().delete()
        for index, unit_data in enumerate(data['units']):
            cf_unit = CloudFactoryUnit(run=self)
            cf_unit.save_cloudfactory_response(unit_data)

        self.save()


class CloudFactoryUnit(models.Model):
    """Each CloudFactory run contains zero or more units."""

    run = models.ForeignKey(
        CloudFactoryRun,
        on_delete=models.CASCADE,
        help_text="The CloudFactory production run in which this unit is processed.",
    )
    status = models.CharField(
        max_length=32, blank=True, default="", help_text="The status of the unit at CloudFactory."
    )
    created_at = models.DateTimeField(
        blank=True, null=True, help_text="When the unit was created at CloudFactory."
    )
    processed_at = models.DateTimeField(
        blank=True, null=True, help_text="When unit processing was finished at CloudFactory."
    )
    input = models.TextField(
        blank=True,
        default="",
        help_text="JSON input to CloudFactory; use to validate the response.",
    )
    output = models.TextField(blank=True, default="", help_text="JSON output from CloudFactory")

    def __repr__(self):
        keys = [key for key in ['id', 'run_id'] if key in self.__dict__.keys()]
        return u"%s(%s)" % (
            self.__class__.__name__,
            u", ".join([u"%s=%r" % (key, self.__dict__[key]) for key in keys]),
        )

    @property
    def post_data(self):
        """create data to POST the unit to CloudFactory"""
        return self.data['input']

    @property
    def data(self):
        """working with celery and email requires being able to provide json for the instance"""
        return dict(
            **{
                key: (
                    str(val)  # datetime.datetime and datetime.date as str
                    if isinstance(val, datetime.datetime) or isinstance(val, datetime.date)
                    else val
                )
                for key, val in self.__dict__.items()
                if key[0] != '_'  # exclude utility vals like _state
            }
        )

    def save_cloudfactory_response(self, unit_data):
        # 'meta' keys are direct fields of the CloudFactoryUnit
        for key in unit_data['meta']:
            self.__dict__[key] = unit_data['meta'][key]
        # rewrite 'input' and 'output' to match unit_data
        for key in ['input', 'output']:
            if key in unit_data:
                self.__dict__[key] = unit_data[key]
        self.save()



# The following is an unfortunate hack to overcome the lack of JSONField in Django 1.8:
# convert the CloudFactoryUnit.input and .output fields to/from string for the database/python.
# -- When we upgrade to Django 1.11 we can instead use django.contrib.postgres.fields.JSONField
#   (but we'll need to be careful about migrating the database at that point!)


def cloudfactory_unit_post_init_post_save(sender, instance, **kwargs):
    """in python the input field is an object, not a string"""
    if instance.input and (isinstance(instance.input, str) or isinstance(instance.input, unicode)):
        instance.input = json.loads(instance.input)
    if instance.output and (
        isinstance(instance.output, str) or isinstance(instance.output, unicode)
    ):
        instance.output = json.loads(instance.output)


def cloudfactory_unit_pre_save(sender, instance, **kwargs):
    """in the database the input field is a string (TextField)"""
    if not isinstance(instance.input, str) and not isinstance(instance.input, unicode):
        instance.input = json.dumps(instance.input)
    if not isinstance(instance.output, str) and not isinstance(instance.output, unicode):
        instance.output = json.dumps(instance.output)


models.signals.post_init.connect(cloudfactory_unit_post_init_post_save, sender=CloudFactoryUnit)
models.signals.post_save.connect(cloudfactory_unit_post_init_post_save, sender=CloudFactoryUnit)
models.signals.pre_save.connect(cloudfactory_unit_pre_save, sender=CloudFactoryUnit)
