# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import os, json
from django.db import migrations


def load_state_requirements_data(apps, schema_editor):
    State = apps.get_model("myhpom", "State")
    StateRequirement = apps.get_model("myhpom", "StateRequirement")
    StateRequirementLink = apps.get_model("myhpom", "StateRequirementLink")

    with open(os.path.splitext(__file__)[0] + '.json', 'r') as f:
        requirements_data = json.load(f)

    for requirement_data in requirements_data:
        # convert the state name to a State object in the requirement_data.
        if requirement_data["state"] is not None:
            requirement_data["state"] = State.objects.get(name=requirement_data["state"])
        # save the requirement object
        requirement = StateRequirement.objects.create(
            **{k: v for k, v in requirement_data.items() if k in ["state", "position", "text"]}
        )
        # save the links
        for link in requirement_data["links"]:
            StateRequirementLink(requirement=requirement, **link).save()


def unload_state_requirements_data(apps, schema_editor):
    StateRequirement = apps.get_model("myhpom", "StateRequirement")
    StateRequirement.objects.all().delete()  # cascades also to all associated links


class Migration(migrations.Migration):

    dependencies = [('myhpom', '0009_state_requirements')]

    operations = [
        migrations.RunPython(
            load_state_requirements_data, reverse_code=unload_state_requirements_data
        )
    ]
