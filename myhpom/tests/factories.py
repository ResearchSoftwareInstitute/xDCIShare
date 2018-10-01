import os

import factory
import factory.fuzzy
from django.contrib.auth.models import User
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.timezone import now

from myhpom.models import (
    AdvanceDirective, CloudFactoryDocumentRun, DocumentUrl, State, UserDetails)

PDF_FILENAME = os.path.join(os.path.dirname(__file__), 'fixtures', 'afile.pdf')

with open(PDF_FILENAME, 'rb') as f:
    document_data = f.read()


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

    email = factory.Sequence(lambda n: 'user%d@example.com' % n)
    username = factory.LazyAttribute(lambda u: u.email)
    first_name = factory.fuzzy.FuzzyText(length=8)
    last_name = factory.fuzzy.FuzzyText(length=8)
    user_details = factory.RelatedFactory(UserDetailsFactory, 'user')


class AdvanceDirectiveFactory(factory.django.DjangoModelFactory):

    class Meta(object):
        model = AdvanceDirective

    document = factory.LazyAttribute(
        lambda a: SimpleUploadedFile(os.path.basename(PDF_FILENAME), document_data))

    user = factory.SubFactory('myhpom.tests.factories.UserFactory')
    valid_date = now()
    share_with_ehs = True

    @classmethod
    def _create(cls, model_class, *args, **kwargs):
        # In order to call render_thumbnail_data() we must have access to the
        # instance:
        obj = model_class(*args, **kwargs)
        if obj.document:
            obj.thumbnail = SimpleUploadedFile(
                os.path.splitext(os.path.basename(PDF_FILENAME))[0] + '.jpg',
                obj.render_thumbnail_data())
            obj.save()
        return obj


class DocumentUrlFactory(factory.django.DjangoModelFactory):

    class Meta(object):
        model = DocumentUrl

    advancedirective = factory.SubFactory('myhpom.tests.factories.AdvanceDirectiveFactory')


class CloudFactoryDocumentRunFactory(factory.django.DjangoModelFactory):

    class Meta(object):
        model = CloudFactoryDocumentRun

    document_url = factory.SubFactory('myhpom.tests.factories.DocumentUrlFactory')
    run_id = factory.fuzzy.FuzzyText(length=10)
