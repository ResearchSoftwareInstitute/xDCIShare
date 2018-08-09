# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
from django.core.urlresolvers import reverse
from scribbler.models import Scribble


SCRIBBLES = [
    {'slug': 'signup-tos-short', 'url': reverse('myhpom:signup'), 'content': '{% lorem 32 w %}'},
    {'slug': 'next-steps-header', 'url': 'shared', 'content': '{% lorem 24 w %}'},
    {'slug': 'next-steps-download', 'url': 'shared', 'content': '<p>\n{% lorem 36 w %}\n</p>'},
    {'slug': 'next-steps-upload', 'url': 'shared', 'content': '<p>\n{% lorem 36 w %}\n</p>'},
]


def load_scribbles_data(apps, schema_editor):
    for data in SCRIBBLES:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if not scribble:
            Scribble.objects.create(**data)


def unload_scribbles_data(apps, schema_editor):
    for data in SCRIBBLES:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if scribble:
            scribble.delete()


class Migration(migrations.Migration):
    dependencies = [('myhpom', '0015_userdetails_updated'), ('scribbler', '0001_initial')]
    operations = [migrations.RunPython(load_scribbles_data, reverse_code=unload_scribbles_data)]
