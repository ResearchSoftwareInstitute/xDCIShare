from mock import MagicMock

from django.http import HttpResponseForbidden
from django.test import SimpleTestCase
from myhpom.decorators import require_ajax


class RequireAjaxTestCase(SimpleTestCase):

    def test_not_ajax(self):
        request = MagicMock()
        request.is_ajax.return_value = False

        @require_ajax
        def some_view(request):
            return 'not called'

        self.assertIsInstance(some_view(request), HttpResponseForbidden)

    def test_ajax(self):
        request = MagicMock()
        request.is_ajax.return_value = True

        @require_ajax
        def some_view(request):
            return 'called'

        self.assertEqual('called', some_view(request))
