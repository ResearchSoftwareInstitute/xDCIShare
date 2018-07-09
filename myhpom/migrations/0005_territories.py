# -*- coding: utf-8 -*-
from django.db import migrations, models

import os, json
from django.db import migrations


def load_fixture_states(apps, schema_editor):
    State = apps.get_model("myhpom", "State")
    fixture_filename = os.path.splitext(__file__)[0]+'.json'
    with open(fixture_filename, 'r') as f:
        states_data = json.load(f)
    for state_data in states_data:
        State(**state_data).save()


def unload_fixture_states(apps, schema_editor):
    State = apps.get_model("myhpom", "State")
    State.objects.all().delete()


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0004_auto_20180708_0954'),
    ]

    operations = [
        migrations.AddField(
            model_name='state',
            name='is_territory',
            field=models.BooleanField(default=False),
        ),
        migrations.RunPython(load_fixture_states, reverse_code=unload_fixture_states),
    ]
