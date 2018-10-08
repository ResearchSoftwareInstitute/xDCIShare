from django import template


register = template.Library()


SUPPORTED_STATE_ORGAN_DONOR_INFO_URLS = {
    'NC': 'https://www.donatelifenc.org/register/',
    'SC': 'https://www.donatelifesc.org/register/',
}

DEFAULT_ORGAN_DONOR_INFO_URL = 'https://www.donatelife.net/register/'


@register.simple_tag
def organ_donor_info_url(state):
    return SUPPORTED_STATE_ORGAN_DONOR_INFO_URLS.get(
        state.name,
        DEFAULT_ORGAN_DONOR_INFO_URL,
    )
