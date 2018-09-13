
from django.db import models
from django.conf import settings


def cloudfactory_api_url():
    return settings.CLOUDFACTORY['API_URL'] % settings.CLOUDFACTORY


class CloudFactoryRun(models.Model):
    """Store information about current and past CloudFactory runs."""

    line_id = models.CharField(
        max_length=64, help_text="the id of the production line at CloudFactory."
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
    created_at = models.DateTimeField(
        blank=True, null=True, help_text="When the run was created at CloudFactory."
    )
    processed_at = models.DateTimeField(
        blank=True, null=True, help_text="When run processing was finished at CloudFactory."
    )


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
        help_text="A json-string containing the input to CloudFactory; use to validate the response."
    )
    output = models.TextField(help_text="A json-string containing the output from CloudFactory")
