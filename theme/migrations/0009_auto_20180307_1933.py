# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('theme', '0008_auto_20170613_1925'),
    ]

    operations = [
        migrations.AlterField(
            model_name='quotamessage',
            name='content',
            field=models.TextField(default=b'To request additional quota, please contact {email}. We will try to accommodate reasonable requests for additional quota. If you have a large quota request you may need to contribute toward the costs of providing the additional space you need. See https://pages.myhpom.org/about-myhpom/policies/quota/ for more information about the quota policy.'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='subject_areas',
            field=models.CharField(help_text=b'A comma-separated list of subject areas you are interested in researching. e.g. "Health, Healthcare, Healthcare Directives"', max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='userquota',
            name='allocated_value',
            field=models.FloatField(default=20),
        ),
        migrations.AlterField(
            model_name='userquota',
            name='used_value',
            field=models.FloatField(default=0),
        ),
    ]
