from django.test import TestCase

from myhpom.models import State
from myhpom.templatetags import mmh_tags


class OrganDonorInfoTest(TestCase):
    def test_nc_sc(self):
        """
        Supported states (as of Oct 8, 2018) return their own
        organ donor info links.
        """
        for name in mmh_tags.SUPPORTED_STATE_ORGAN_DONOR_INFO_URLS.keys():
            state = State(
                name=name,
                title='Some Irrelevant Title'
            )
            info_url = mmh_tags.organ_donor_info_url(state)
            self.assertEqual(
                info_url,
                mmh_tags.SUPPORTED_STATE_ORGAN_DONOR_INFO_URLS.get(
                    state.name,
                    'default',
                )
            )

    def test_other(self):
        """
        Unsupported states return a default URL.
        """
        other = State(
            name='EN',
            title='East New York',
        )
        other_info_url = mmh_tags.organ_donor_info_url(other)

        self.assertEqual(
            mmh_tags.DEFAULT_ORGAN_DONOR_INFO_URL,
            other_info_url,
        )
