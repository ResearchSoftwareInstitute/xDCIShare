# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('myhpom', '0008_territories'),
    ]

    operations = [
        migrations.CreateModel(
            name='AdvanceDirective',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('document', models.FileField(help_text=b"The document representing this user's Advance Directive.", upload_to=b'myhpom/advance_directives')),
                ('valid_date', models.DateField(help_text=b'Date that this document is legally valid.')),
                ('share_with_ehs', models.BooleanField(help_text=b"True when user this document can be shared with the user's healthcare system.")),
                ('user', models.OneToOneField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
