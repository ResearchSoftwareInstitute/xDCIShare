# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0023_cloudfactorydocumentrun'),
    ]

    operations = [
        migrations.AddField(
            model_name='cloudfactorydocumentrun',
            name='updated_at',
            field=models.DateTimeField(default=datetime.datetime(2018, 9, 25, 20, 4, 2, 726135, tzinfo=utc), help_text=b'When the run instance was last updated in our system.', auto_now=True),
            preserve_default=False,
        ),
    ]
