# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import localflavor.us.models


class Migration(migrations.Migration):

    dependencies = [
        ('theme', '0009_auto_20171102_0508'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='zip_code',
            field=localflavor.us.models.USZipCodeField(max_length=10),
        ),
    ]
