# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0021_document_url'),
    ]

    operations = [
        migrations.CreateModel(
            name='CloudFactoryRun',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('line_id', models.CharField(help_text=b'the id of the production line at CloudFactory.', max_length=64)),
                ('run_id', models.CharField(default=b'', help_text=b'The id of this production run at CloudFactory.', max_length=64, blank=True)),
                ('callback_url', models.CharField(default=b'', help_text=b'The URL to which CloudFactory will submit the results of the production run.', max_length=1024, blank=True)),
                ('status', models.CharField(default=b'', help_text=b'The status of the run at CloudFactory.', max_length=32, blank=True)),
                ('message', models.TextField(help_text=b'Any message returned by CloudFactory.', blank=True)),
                ('created_at', models.DateTimeField(help_text=b'When the run was created at CloudFactory.', null=True, blank=True)),
                ('processed_at', models.DateTimeField(help_text=b'When run processing was finished at CloudFactory.', null=True, blank=True)),
            ],
        ),
        migrations.CreateModel(
            name='CloudFactoryUnit',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('status', models.CharField(default=b'', help_text=b'The status of the unit at CloudFactory.', max_length=32, blank=True)),
                ('created_at', models.DateTimeField(help_text=b'When the unit was created at CloudFactory.', null=True, blank=True)),
                ('processed_at', models.DateTimeField(help_text=b'When unit processing was finished at CloudFactory.', null=True, blank=True)),
                ('input', models.TextField(default=b'', help_text=b'JSON input to CloudFactory; use to validate the response.', blank=True)),
                ('output', models.TextField(default=b'', help_text=b'JSON output from CloudFactory', blank=True)),
                ('run', models.ForeignKey(help_text=b'The CloudFactory production run in which this unit is processed.', to='myhpom.CloudFactoryRun')),
            ],
        ),
    ]
