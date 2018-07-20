# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import sys
from django.db import models, IntegrityError
from django.core.exceptions import ValidationError
from django.core.urlresolvers import reverse
from .state import State
from myhpom.validators import validate_not_blank


class StateRequirement(models.Model):
    """an advance directive requirement for a given state.
    * state => State: the state in which this requirement applies. If null, global to all states.
    * text: a textual description of the requirement (REQUIRED)
    * UNIQUE(state, order) -- protect against multiple items in the same position
    * UNIQUE(state, text) -- protect against multiple items with the same text
    """

    state = models.ForeignKey(
        State,
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        help_text="The state in which this requirement applies. If null, global to all states.",
    )
    text = models.CharField(max_length=1024, help_text="The displayed text of the requirement.")

    class Meta:
        unique_together = (('state', 'text'),)
        ordering = ['-state', 'id']  # state=None (global requirements) first

    def __unicode__(self):
        return unicode("%s %d: %s" % (str(self.state or '--'), self.text))

    @classmethod
    def for_state(Class, state):
        """
        return the ordered list of requirements for this state, includes global then specific:
        """
        return Class.objects.filter(models.Q(state=None) | models.Q(state=state))

    def admin_link(self):
        if self.id:
            # Replace "myapp" with the name of the app containing
            # your Certificate model:
            admin_url = reverse('admin:myhpom_staterequirement_change', args=(self.id,))
            return u'<a href="%s" target="_blank">Edit Links</a>' % admin_url
        return u''

    admin_link.allow_tags = True
    admin_link.short_description = 'Links'


def state_requirement_pre_save_receiver(sender, instance, **kwargs):
    """
    * Ensure that the StateRequirement fields are valid before saving:
        * text: not blank
        * null state: (state, text) not exists, or (state, text) exists with instance.id.
    """
    validate_not_blank(instance.__dict__.get('text'))

    if instance.state is None:
        # PostgreSQL doesn't raise IntegrityError on null state, so we have to.
        if instance.id is None:
            # creating a new instance
            if StateRequirement.objects.filter(state=None, text=instance.text).exists():
                raise IntegrityError('(state, text) not unique: (None, %s)' % (instance.text,))
        else:
            # saving an existing instance
            qid = ~models.Q(id=instance.id)
            if StateRequirement.objects.filter(qid).filter(state=None, text=instance.text).exists():
                raise IntegrityError('(state, text) not unique: (None, %s)' % (instance.text,))


models.signals.pre_save.connect(state_requirement_pre_save_receiver, sender=StateRequirement)
