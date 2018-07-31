# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0014_advancedirective_original_filename'),
    ]

    operations = [
        migrations.AddField(
            model_name='userdetails',
            name='birthdate',
            field=models.DateField(help_text="The user's date of birth.", null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='gender',
            field=models.CharField(blank=True, max_length=32, null=True, help_text="The user's gender self-identification.", choices=[(b'Male', b'Male'), (b'Female', b'Female'), (b'Non-Binary / Fluid', b'Non-Binary / Fluid'), (b'Non-Gender-Conforming', b'Non-Gender-Conforming')]),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='phone',
            field=models.CharField(help_text='Phone number at which the user can be contacted.', max_length=32, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='zip_code',
            field=models.CharField(help_text="The zip code for the user's health care address.", max_length=10, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='userdetails',
            name='is_organ_donor',
            field=models.BooleanField(default=False, help_text=b'Whether the user is registered as an organ donor.'),
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='accept_tos',
            field=models.NullBooleanField(help_text='Whether the user has accepted the Terms of Service.'),
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='custom_provider',
            field=models.CharField(help_text="The name of the user's health care provider, if not in our database.", max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='health_network',
            field=models.ForeignKey(on_delete=django.db.models.deletion.SET_NULL, to='myhpom.HealthNetwork', help_text='The health network that the user belongs to.', null=True),
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='middle_name',
            field=models.CharField(help_text="The user's middle name, if any.", max_length=30, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='userdetails',
            name='state',
            field=models.ForeignKey(on_delete=django.db.models.deletion.SET_NULL, blank=True, to='myhpom.State', help_text='The state in which the user receives health care.', null=True),
        ),
    ]
