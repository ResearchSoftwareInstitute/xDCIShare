# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0008_territories'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userdetails',
            name='custom_provider',
            field=models.CharField(default='', max_length=1024, blank=True),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='middle_name',
            field=models.CharField(default='', max_length=30, blank=True),
            preserve_default=False,
        ),
    ]
