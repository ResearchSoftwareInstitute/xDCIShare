# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import myhpom.validators


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0011_state_requirements_data'),
    ]

    operations = [
        migrations.AlterField(
            model_name='advancedirective',
            name='valid_date',
            field=models.DateField(help_text=b'Date that this document is legally valid.', 
                validators=[myhpom.validators.validate_date_in_past]),
        ),
    ]
