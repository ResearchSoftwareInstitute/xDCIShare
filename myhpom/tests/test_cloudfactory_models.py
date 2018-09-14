
from django.test import TestCase


class CloudFactoryRunModelTestCase(TestCase):
    """
    * run created with minimum required data has expected defaults
    * .post_data() contains keys: ['units', 'line_id', 'callback_url']
    * .data() contains all keys defined in the model.
    """


class CloudFactoryUnitModelTestCase(TestCase):
    """
    * unit created with minimum required data has expected defaults
    * .input is an object, not a string, in all user-facing object states
    * .output is an object, not a string, in all user-facing object states
    * .post_data() contains the content of .input
    * .data() contains the all the keys defined in the model (with .input and .output as objects)
    """
