# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os, json
from django.db import migrations, models
import django.db.models.deletion
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('myhpom', '0002_states'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserDetails',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, 
                    primary_key=True)),
                ('middle_name', models.CharField(max_length=30, null=True, blank=True)),
                ('accept_tos', models.NullBooleanField()),
                ('state', models.ForeignKey(on_delete=django.db.models.deletion.SET_NULL, 
                    blank=True, to='myhpom.State', null=True)),
                ('user', models.OneToOneField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
