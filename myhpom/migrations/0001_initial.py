# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='StateAdvanceDirective',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('state', models.CharField(unique=True, max_length=2, choices=[(b'NC', b'North Carolina'), (b'SC', b'South Carolina')])),
                ('advance_directive_template', models.FileField(help_text=b'Note that only North Carolina and South Carolina should be associated with advance directive packets.', upload_to=b'myhpom')),
            ],
        ),
    ]
