from django.core.urlresolvers import reverse
from django.test import TestCase
from django.template import Context, Template
from scribbler.models import Scribble
from myhpom.tests.factories import UserFactory


class ScribblerTestCase(TestCase):
    """
    * The scribbler urls should exist: create, edit, delete, preview, edit-field.
    * Scribbles should exist already for signup and next-steps (not accessible from UI).
    """

    def test_scribbler_urls(self):
        # none of the following should throw an error
        self.assertIn('create/', reverse("create-scribble"))
        self.assertIn('edit/', reverse("edit-scribble", args=['1']))
        self.assertIn('preview/', reverse("preview-scribble", args=['1']))
        self.assertIn('delete/', reverse("delete-scribble", args=['1']))

    def test_migration_scribbles(self):
        scribbles_data = [
            {k: v for k, v in s.items() if k in ['slug', 'url']}
            for s in [s.__dict__ for s in Scribble.objects.all()]
        ]
        migration_scribbles_data = [
            {'slug': 'header-text', 'url': 'next_steps'},
            {'slug': 'download-text', 'url': 'next_steps'},
            {'slug': 'upload-text', 'url': 'next_steps'},
        ]
        for data in migration_scribbles_data:
            self.assertIn(data, scribbles_data)
