from django.conf import settings
from django.test.runner import DiscoverRunner


class LimitedTestSuiteRunner(DiscoverRunner):

    def run_tests(self, test_labels, extra_tests=None, **kwargs):
        if not test_labels:
            # No appnames specified on the command line, so we run all
            # tests in our INSTALLED_APPS (and in the tree below where
            # we are being run from).
            test_labels = [app for app in settings.INSTALLED_APPS]
        return super(LimitedTestSuiteRunner, self).run_tests(test_labels, extra_tests, **kwargs)

