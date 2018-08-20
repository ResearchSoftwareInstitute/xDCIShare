# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myhpom', '0009_advancedirective'),
    ]

    operations = [
        migrations.CreateModel(
            name='StateRequirement',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, 
                    primary_key=True)),
                ('position', models.PositiveSmallIntegerField(
                    help_text='The sorting position of this requirement.')),
                ('text', models.CharField(
                    help_text='The displayed text of the requirement.', max_length=1024)),
                ('state', models.ForeignKey(blank=True, to='myhpom.State', 
                    help_text='The state in which this requirement applies. If null, global to all states.', 
                    null=True)),
            ],
            options={
                'ordering': ['-state', 'position'],
            },
        ),
        migrations.CreateModel(
            name='StateRequirementLink',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, 
                    primary_key=True)),
                ('text', models.CharField(max_length=64)),
                ('href', models.CharField(max_length=1024)),
                ('requirement', models.ForeignKey(to='myhpom.StateRequirement')),
            ],
        ),
        migrations.AlterUniqueTogether(
            name='staterequirement',
            unique_together=set([('state', 'text'), ('state', 'position')]),
        ),
    ]
