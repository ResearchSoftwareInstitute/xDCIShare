# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.core.validators


class Migration(migrations.Migration):

    dependencies = [
        ('theme', '0008_auto_20170613_1925'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='address_1',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='address_2',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='city',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='date_of_birth',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='emergency_email',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='emergency_name',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='emergency_phone_1',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='emergency_phone_2',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='emergency_relationship',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='gender',
            field=models.CharField(default=None, max_length=100, null=True, blank=True, choices=[(b'ND', b'Prefer not to disclose'), (b'M', b'Male'), (b'F', b'Female'), (b'O', b'Other')]),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='last_four_ss',
            field=models.PositiveSmallIntegerField(blank=True, null=True, validators=[django.core.validators.MaxValueValidator(9999)]),
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
