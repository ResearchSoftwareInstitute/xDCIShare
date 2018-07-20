# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0012_auto_20180718_1140'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='staterequirement',
            options={'ordering': ['-state', 'id']},
        ),
        migrations.AlterUniqueTogether(
            name='staterequirement',
            unique_together=set([('state', 'text')]),
        ),
        migrations.RemoveField(
            model_name='staterequirement',
            name='position',
        ),
    ]
