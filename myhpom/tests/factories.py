from django.contrib.auth.models import User
import factory
import factory.fuzzy
from myhpom.models import State, UserDetails


class UserDetailsFactory(factory.django.DjangoModelFactory):

    class Meta(object):
        model = UserDetails

    state = factory.fuzzy.FuzzyChoice(State.objects.all())
    middle_name = factory.fuzzy.FuzzyText(length=8)
    accept_tos = True
    user = factory.SubFactory('myhpom.tests.factories.UserFactory')


class UserFactory(factory.django.DjangoModelFactory):

    class Meta(object):
        model = User

    username = factory.fuzzy.FuzzyText(length=8)
    email = factory.Sequence(lambda n: 'user%d@example.com' % n)
    first_name = factory.fuzzy.FuzzyText(length=8)
    last_name = factory.fuzzy.FuzzyText(length=8)
    user_details = factory.RelatedFactory(UserDetailsFactory, 'user')
