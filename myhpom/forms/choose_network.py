
from django import forms
from myhpom import models, validators


class ChooseNetworkForm(forms.Form):
    custom_provider = forms.CharField(max_length=1024, required=False)
    health_network = forms.IntegerField(required=False)
