from django.test import TestCase
from django.core.urlresolvers import reverse
from django.core.files.base import ContentFile
from django.db.models.fields.files import FieldFile

from myhpom.models import State
from myhpom.tests.factories import UserFactory


class DashboardTestCase(TestCase):
    def setUp(self):
        self.url = reverse('myhpom:dashboard')

    def test_not_logged_in(self):
        # A user must be logged in to see their dashboard:
        response = self.client.get(self.url)
        self.assertEqual(302, response.status_code)

    def test_basic_get(self):
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.username, password='password'))
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertTemplateUsed('myhpom/dashboard.html')

    def test_advance_directive_template(self):
        """
        GET: context should have advance_directive_template
            - FileField object for user from state that has an advance_directive_template file
            - None for user from state that does not have an advance_directive_template file
        """
        user = UserFactory()
        user.set_password('password')
        user.save()
        self.assertTrue(self.client.login(username=user.username, password='password'))

        # state has no AD template
        user.userdetails.state = State.objects.order_by_ad().last()
        user.userdetails.save()
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertIsNone(response.context['advance_directive_template'])

        # state has AD template
        state = user.userdetails.state = State.objects.order_by_ad().first()  # includes template
        user.userdetails.save()
        state.advance_directive_template.save(
            'not.pdf', ContentFile("not your grandfather's template")
        )
        response = self.client.get(self.url)
        self.assertEqual(200, response.status_code)
        self.assertIsInstance(response.context['advance_directive_template'], FieldFile)
