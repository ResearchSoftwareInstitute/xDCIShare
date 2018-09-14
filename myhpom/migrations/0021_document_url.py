# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0020_user_verification'),
    ]

    operations = [
        migrations.CreateModel(
            name='DocumentUrl',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('key', models.CharField(help_text=b'The non-guessable string that indentifies this DocumentUrl.', unique=True, max_length=48)),
                ('expiration', models.DateTimeField(help_text=b'The optional timestamp indicating when this DocumentUrl expires.', null=True, blank=True)),
                ('advancedirective', models.ForeignKey(help_text=b'The AdvanceDirective to which this URL points.', to='myhpom.AdvanceDirective')),
            ],
        ),
    ]
