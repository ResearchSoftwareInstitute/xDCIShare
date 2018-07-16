from django import forms
from myhpom.models import (
    HealthNetwork,
    UserDetails,
)


class ChooseNetworkNoADTemplateForm(forms.ModelForm):
    custom_provider = forms.CharField(max_length=1024)

    class Meta:
        model = UserDetails
        fields = [
            'custom_provider',
        ]


class ChooseNetworkForm(forms.ModelForm):
    custom_provider = forms.CharField(max_length=1024, required=False)
    health_network = forms.IntegerField(required=False)

    def clean(self):
        cleaned_data = super(ChooseNetworkForm, self).clean()
        custom_provider = cleaned_data.get('custom_provider')
        health_network = cleaned_data.get('health_network')

        if ((not custom_provider) and (not health_network)) or (custom_provider and health_network):
            raise forms.ValidationError(
                'Please either choose a network or enter a custom network.'
            )

        return cleaned_data

    def clean_health_network(self):
        data = self.cleaned_data['health_network']
        if data:
            try:
                return HealthNetwork.objects.get(id=data)
            except HealthNetwork.DoesNotExist:
                raise forms.ValidationError(
                    'Selected health network does not exist.'
                )
        return None

    def save(self, *args, **kwargs):
        unsaved = super(ChooseNetworkForm, self).save(commit=False, *args, **kwargs)

        if not self.cleaned_data['health_network']:
            unsaved.health_network = None
        if not self.cleaned_data['custom_provider']:
            unsaved.cleaned_data = None

        return unsaved.save()

    class Meta:
        model = UserDetails
        fields = [
            'health_network',
            'custom_provider',
        ]
