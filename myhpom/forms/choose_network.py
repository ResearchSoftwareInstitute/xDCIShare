from django import forms


class ChooseNetworkForm(forms.Form):
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
