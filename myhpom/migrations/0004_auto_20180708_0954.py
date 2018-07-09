# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0003_user_details'),
    ]

    operations = [
        migrations.DeleteModel(
            name='StateAdvanceDirective',
        ),
        migrations.AlterModelOptions(
            name='state',
            options={},
        ),
        migrations.RemoveField(
            model_name='state',
            name='supported',
        ),
        migrations.AddField(
            model_name='state',
            name='advance_directive_template',
            field=models.FileField(help_text=b'AD instructions associated with this State', upload_to=b'myhpom', blank=True),
        ),
        migrations.AlterField(
            model_name='state',
            name='name',
            field=models.CharField(help_text=b'Two-letter state abbreviation', unique=True, max_length=2),
        ),
        migrations.AlterField(
            model_name='state',
            name='title',
            field=models.CharField(help_text=b'The full (common) name of the state (e.g. Rhode Island)', max_length=1024),
        ),
    ]
