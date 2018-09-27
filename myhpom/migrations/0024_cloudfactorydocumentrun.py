# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
from django.utils.timezone import now


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0023_cloudfactorydocumentrun'),
    ]

    operations = [
        migrations.AddField(
            model_name='cloudfactorydocumentrun',
            name='updated_at',
            field=models.DateTimeField(default=now(), help_text=b'When the run instance was last updated in our system.', auto_now=True),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='cloudfactorydocumentrun',
            name='status',
            field=models.CharField(default=b'NEW', help_text=b'The status of the run.', max_length=16, choices=[(b'NEW', b'NEW'), (b'DELETED', b'DELETED'), (b'REQ_ERROR', b'REQ_ERROR'), (b'NOTFOUND', b'NOTFOUND'), (b'UNPROCESSABLE', b'UNPROCESSABLE'), (b'ERROR', b'ERROR'), (b'Processing', b'Processing'), (b'Aborted', b'Aborted'), (b'Processed', b'Processed')]),
        ),
    ]
