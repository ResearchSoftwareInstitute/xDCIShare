# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0004_auto_20180708_0954'),
    ]

    operations = [
        migrations.CreateModel(
            name='HealthNetwork',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=1024)),
                ('priority', models.PositiveSmallIntegerField(choices=[(0, 'Primary Network'), (1, 'Additional Network'), (2, 'Independent System')])),
                ('state', models.ForeignKey(to='myhpom.State')),
            ],
            options={
                'ordering': ['priority', 'name'],
            },
        ),
        migrations.AddField(
            model_name='userdetails',
            name='custom_provider',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='health_network',
            field=models.ForeignKey(on_delete=django.db.models.deletion.SET_NULL, to='myhpom.HealthNetwork', null=True),
        ),
        migrations.AlterUniqueTogether(
            name='healthnetwork',
            unique_together=set([('state', 'name')]),
        ),
    ]
