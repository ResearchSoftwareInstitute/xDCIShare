from django.core.urlresolvers import reverse
from django.test import (
    Client,
    TestCase,
)

class SignupTestCase(TestCase):
    """
    * 
    """
    def setUp(self):
        self.client = Client()
        self.url = reverse('myhpom:signup')

 