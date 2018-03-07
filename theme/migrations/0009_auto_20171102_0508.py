# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('theme', '0008_auto_20170613_1925'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='ssn_last_four',
            field=models.CharField(max_length=4, null=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='zip_code',
            field=models.CharField(default='27517', max_length=5),
            preserve_default=False,
        ),
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
    ]
