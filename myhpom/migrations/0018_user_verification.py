# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0017_auto_20180817_1117'),
    ]

    operations = [
        migrations.AddField(
            model_name='userdetails',
            name='verification_code',
            field=models.CharField(help_text=b'The generated code by which the user verifies their account.', max_length=64, null=True),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='verification_completed',
            field=models.DateTimeField(help_text=b"When the user's account was verified.", null=True),
        ),
    ]
