import factory
import factory.fuzzy

from myhpom import models


class StateAdvanceDirectiveFactory(factory.DjangoModelFactory):
    state = factory.fuzzy.FuzzyText(length=2)
    advance_directive_template = factory.django.FileField()

    class Meta:
        model = models.StateAdvanceDirective
