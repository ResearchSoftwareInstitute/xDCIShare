# -*- coding: utf-8 -*-
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0006_health_networks'),
    ]

    operations = [
        migrations.AddField(
            model_name='state',
            name='is_territory',
            field=models.BooleanField(default=False),
        ),
    ]
