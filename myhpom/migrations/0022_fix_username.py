# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
from myhpom.models.user import User, get_username

def fix_usernames(apps, schema_editor):
    for user in User.objects.filter(username__contains='='):
        user.save()


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0021_document_url'),
    ]

    operations = [
        migrations.RunPython(
            fix_usernames, reverse_code=fix_usernames
        )
    ]
