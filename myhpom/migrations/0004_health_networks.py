# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os, json
from django.db import migrations, models
import django.db.models.deletion


def load_fixture_networks(apps, schema_editor):
    HealthNetwork = apps.get_model("myhpom", "HealthNetwork")
    State = apps.get_model("myhpom", "State")
    fixture_filename = os.path.splitext(__file__)[0]+'.json'
    with open(fixture_filename, 'r') as f:
        networks_data = json.load(f)
    for network_data in networks_data:
        # convert the state name to a State object in the network_data.
        network_data["state"] = State.objects.get(name=network_data["state"])
        HealthNetwork(**network_data).save()


def unload_fixture_networks(apps, schema_editor):
    HealthNetwork = apps.get_model("myhpom", "HealthNetwork")
    HealthNetwork.objects.all().delete()


class Migration(migrations.Migration):

    dependencies = [('myhpom', '0003_user_details')]

    operations = [
        migrations.CreateModel(
            name='HealthNetwork',
            fields=[
                (
                    'id',
                    models.AutoField(
                        verbose_name='ID', serialize=False, auto_created=True, primary_key=True
                    ),
                ),
                ('name', models.CharField(max_length=1024)),
                (
                    'priority',
                    models.PositiveSmallIntegerField(
                        choices=[
                            (0, u'Primary Network'),
                            (1, u'Additional Network'),
                            (2, u'Independent System'),
                        ]
                    ),
                ),
                ('state', models.ForeignKey(to='myhpom.State')),
            ],
            options={'ordering': ['priority', 'name']},
        ),
        migrations.AddField(
            model_name='userdetails',
            name='health_network',
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.SET_NULL, to='myhpom.HealthNetwork', null=True
            ),
        ),
        migrations.RunPython(load_fixture_networks, reverse_code=unload_fixture_networks),
    ]
