from django.core.urlresolvers import reverse
from django.test import TestCase


class ScribblerTestCase(TestCase):
    """
    * The scribbler urls should exist: create, edit, delete, preview, edit-field.
    * Scribbler admin should be available.
    * Scribbles should exist already for signup and next-steps (not accessible from UI).
    * Scribbles in the dashboard among others should function as expected.
    """

    def test_scribbler_urls(self):
        # none of the following should throw an error
        self.assertIn('create/', reverse("create-scribble"))
        self.assertIn('edit/', reverse("edit-scribble"))
        self.assertIn('preview/', reverse("preview-scribble"))
        self.assertIn('delete/', reverse("delete-scribble"))
        self.assertIn('edit-field/', reverse("edit-scribble-field"))

