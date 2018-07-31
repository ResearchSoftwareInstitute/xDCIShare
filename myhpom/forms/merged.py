from django import forms

class MergedModelForm(forms.Form):
    class Meta:
        forms = []

    def __init__(self, data=None, instances=None):
        super(forms.Form, self).__init__(data=data)
        self.forms = []
        for i in range(len(self.Meta.forms)):
            if instances is not None and len(instances) > i:
                form = self.Meta.forms[i](data=data, instance=instances[i])
            else:
                form = self.Meta.forms[i](data=data)
            self.forms.append(form)

    def is_valid(self):
        if not super(forms.Form, self).is_valid():
            return False
        for form in self.forms:
            if not form.is_valid():
                return False
        return True

    @property
    def errors(self):
        errs = super(forms.Form, self).errors
        for form in self.forms:
            errs.update(**form.errors)
        return errs

    def save(self, commit=True):
        instances = [form.save(commit=commit) for form in self.forms]
        return instances

