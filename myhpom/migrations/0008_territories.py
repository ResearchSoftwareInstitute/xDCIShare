# -*- coding: utf-8 -*-
import json
import os

from django.db import migrations


def load_fixture_states(apps, schema_editor):
    State = apps.get_model("myhpom", "State")
    fixture_filename = os.path.splitext(__file__)[0] + '.json'
    with open(fixture_filename, 'r') as f:
        states_data = json.load(f)
    for state_data in states_data:
        State(**state_data).save()


def unload_fixture_states(apps, schema_editor):
    State = apps.get_model("myhpom", "State")
    State.objects.all().delete()


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0007_add_is_territory'),
    ]

    operations = [
        migrations.RunPython(load_fixture_states, reverse_code=unload_fixture_states),
    ]
