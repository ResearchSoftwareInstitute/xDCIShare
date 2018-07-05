# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os, json
from django.db import migrations, models
import django.db.models.deletion
from django.conf import settings


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
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('myhpom', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='State',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, 
                    primary_key=True)),
                ('name', models.CharField(unique=True, max_length=2)),
                ('title', models.CharField(max_length=1024)),
                ('supported', models.NullBooleanField()),
            ],
            options={
                'ordering': ['supported', 'name'],
            },
        ),
        migrations.RunPython(load_fixture_states, reverse_code=unload_fixture_states),
    ]
