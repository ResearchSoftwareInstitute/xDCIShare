from django.db import models
from .state import State
from .user import User
from .user_details import UserDetails
from .health_network import HealthNetwork


AD_PACKET_STATES = (
    ('NC', 'North Carolina'),
    ('SC', 'South Carolina'),
)

AD_PACKET_STATES_LOOKUP = dict(AD_PACKET_STATES)


class StateAdvanceDirective(models.Model):
    state = models.CharField(
        max_length=2,
        choices=AD_PACKET_STATES,
        unique=True,
    )
    advance_directive_template = models.FileField(
        upload_to='myhpom',
        help_text=(
            'Note that only North Carolina and South Carolina '
            'should be associated with advance directive packets.'
        ),
    )

    def __unicode__(self):
        return AD_PACKET_STATES_LOOKUP[self.state]
