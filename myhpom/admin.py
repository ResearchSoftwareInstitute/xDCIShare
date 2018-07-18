from django.contrib import admin

from myhpom.models.state import State
from myhpom.models.state_requirement import StateRequirement
from myhpom.models.state_requirement_link import StateRequirementLink


class StateRequirementLinkAdmin(admin.TabularInline):
    model = StateRequirementLink


class StateRequirementAdmin(admin.ModelAdmin):
    model = StateRequirement
    inlines = [StateRequirementLinkAdmin]


class StateRequirementInlineAdmin(admin.TabularInline):
    model = StateRequirement
    fields = ('position', 'text', 'admin_link')
    readonly_fields = ('admin_link',)


class StateAdmin(admin.ModelAdmin):
    model = State
    inlines = [StateRequirementInlineAdmin]


admin.site.register(State, StateAdmin)
admin.site.register(StateRequirement, StateRequirementAdmin)
