from django.contrib import admin

from myhpom.models.state import State
from myhpom.models.state_requirement import StateRequirement
from myhpom.models.state_requirement_link import StateRequirementLink
from myhpom.models.document import DocumentUrl
from scribbler.models import Scribble


class StateRequirementLinkAdmin(admin.TabularInline):
    model = StateRequirementLink


class StateRequirementAdmin(admin.ModelAdmin):
    model = StateRequirement
    inlines = [StateRequirementLinkAdmin]


class StateRequirementInlineAdmin(admin.TabularInline):
    model = StateRequirement
    fields = ('text', 'admin_link')
    readonly_fields = ('admin_link',)


class StateAdmin(admin.ModelAdmin):
    model = State
    inlines = [StateRequirementInlineAdmin]


class ScribbleAdmin(admin.ModelAdmin):
    model = Scribble
    readonly_fields = ['slug', 'url']
    list_display = ['slug', 'name', 'url']


class DocumentUrlAdmin(admin.ModelAdmin):
    model = DocumentUrl
    readonly_fields = ['key', 'url']
    list_display = ['url', 'ip', 'expiration']
    raw_id_fields = ['advancedirective']


admin.site.register(State, StateAdmin)
admin.site.register(StateRequirement, StateRequirementAdmin)
admin.site.register(Scribble, ScribbleAdmin)
admin.site.register(DocumentUrl, DocumentUrlAdmin)
