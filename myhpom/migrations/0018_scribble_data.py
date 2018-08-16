# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os, json
from django.db import migrations, models
from scribbler.models import Scribble


def load_scribbles_data(apps, schema_editor):
    with open(os.path.splitext(__file__)[0] + '.json', 'r') as f:
        scribbles_data = json.load(f)
    for data in scribbles_data['delete']:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if scribble:
            scribble.delete()
    for data in scribbles_data['create']:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if not scribble:
            Scribble.objects.create(**data)


def unload_scribbles_data(apps, schema_editor):
    with open(os.path.splitext(__file__)[0] + '.json', 'r') as f:
        scribbles_data = json.load(f)
    # reverse the above
    for data in scribbles_data['create']:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if scribble:
            scribble.delete()
    for data in scribbles_data['delete']:
        scribble = Scribble.objects.filter(slug=data['slug'], url=data['url']).first()
        if not scribble:
            Scribble.objects.create(**data)


class Migration(migrations.Migration):
    dependencies = [('myhpom', '0017_ad_thumbnail')]
    operations = [migrations.RunPython(load_scribbles_data, reverse_code=unload_scribbles_data)]
