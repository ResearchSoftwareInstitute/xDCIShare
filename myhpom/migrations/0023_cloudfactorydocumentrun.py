# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0022_fix_username'),
    ]

    operations = [
        migrations.CreateModel(
            name='CloudFactoryDocumentRun',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('document_host', models.CharField(default=b'', help_text=b'The document host to which this run is connected.', max_length=64, blank=True)),
                ('inserted_at', models.DateTimeField(help_text=b'When the run instance was inserted into our system.', auto_now_add=True)),
                ('run_id', models.CharField(null=True, default=None, max_length=32, blank=True, help_text=b'The id of this production run at CloudFactory.', unique=True)),
                ('status', models.CharField(default=b'NEW', help_text=b'The status of the run.', max_length=16, choices=[(b'NEW', b'NEW'), (b'DELETED', b'DELETED'), (b'TIMEOUT', b'TIMEOUT'), (b'NOTFOUND', b'NOTFOUND'), (b'UNPROCESSABLE', b'UNPROCESSABLE'), (b'Processing', b'Processing'), (b'Processed', b'Processed'), (b'Aborted', b'Aborted')])),
                ('created_at', models.DateTimeField(help_text=b'When the run was created at CloudFactory.', null=True, blank=True)),
                ('processed_at', models.DateTimeField(help_text=b'When run processing was finished at CloudFactory.', null=True, blank=True)),
                ('post_data', models.TextField(default=b'', help_text=b'The raw data that was submitted to CloudFactory when this run was created', blank=True)),
                ('response_content', models.TextField(default=b'', help_text=b'The raw content of the most recent response from CloudFactory', blank=True)),
                ('document_url', models.ForeignKey(on_delete=django.db.models.deletion.SET_NULL, to='myhpom.DocumentUrl', help_text=b'the DocumentUrl object with which this run is associated.', null=True)),
            ],
        ),
    ]
