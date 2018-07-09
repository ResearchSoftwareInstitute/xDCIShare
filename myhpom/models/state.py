from django.db import models
from django.db.models import Case, IntegerField, Value, When
from django.db.models.functions import Length


class StateQuerySet(models.QuerySet):
    def order_by_ad(self):
        """ Order so that states with advance_directive_template values are
        before those without. """
        return (self
            .annotate(ad_length=Length('advance_directive_template'))
            .annotate(has_ad=Case(
                When(ad_length__gt=0, then=Value(1)),
                default=Value(0),
                output_field=IntegerField()))
            .order_by('-has_ad', 'is_territory', 'name'))


class State(models.Model):
    """ States in the country, and their support for Advance Directives. """

    name = models.CharField(
        max_length=2, unique=True, help_text='Two-letter state abbreviation')
    title = models.CharField(
        max_length=1024, help_text='The full (common) name of the state (e.g. Rhode Island)')
    is_territory = models.BooleanField(default=False)
    advance_directive_template = models.FileField(
        upload_to='myhpom',
        blank=True,
        help_text=('AD instructions associated with this State'),
    )

    objects = StateQuerySet.as_manager()

    def __unicode__(self):
        return unicode(self.name)
