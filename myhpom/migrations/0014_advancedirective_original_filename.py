# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0013_auto_20180720_0942'),
    ]

    operations = [
        migrations.AddField(
            model_name='advancedirective',
            name='original_filename',
            field=models.CharField(max_length=512, blank=True),
        ),
    ]
