from django import forms
from django.utils import timezone
from myhpom.models import HealthNetwork, UserDetails


class ChooseNetworkForm(forms.ModelForm):
    custom_provider = forms.CharField(max_length=1024, required=False)
    health_network = forms.IntegerField(required=False)

    def clean(self):
        cleaned_data = super(ChooseNetworkForm, self).clean()
        custom_provider = cleaned_data.get('custom_provider')
        health_network = cleaned_data.get('health_network')

        # if state has health networks, one and only one health_network or custom_provider
        if self.instance and self.instance.state and self.instance.state.healthnetwork_set.exists():
            if (not custom_provider and not health_network) or (custom_provider and health_network):
                raise forms.ValidationError(
                    'Please either choose a network or enter a custom network.'
                )
        # if state has no health networks, there must be a custom_provider
        elif not custom_provider:
            raise forms.ValidationError('Please enter a custom network.')

        return cleaned_data

    def clean_health_network(self):
        health_network_id = self.cleaned_data['health_network']
        if health_network_id:
            try:
                return HealthNetwork.objects.get(id=health_network_id)
            except HealthNetwork.DoesNotExist:
                raise forms.ValidationError('Selected health network does not exist.')
        return None

    def save(self, *args, **kwargs):
        unsaved = super(ChooseNetworkForm, self).save(commit=False, *args, **kwargs)

        if not self.cleaned_data['health_network']:
            unsaved.health_network = None
        if not self.cleaned_data['custom_provider']:
            unsaved.cleaned_data = None

        saved = unsaved.save()
        self.instance.health_network_updated = timezone.now()
        self.instance.save()
        return saved

    class Meta:
        model = UserDetails
        fields = ['health_network', 'custom_provider']
