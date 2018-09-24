from django.contrib import admin
from myhpom.models.state import State
from myhpom.models.state_requirement import StateRequirement
from myhpom.models.state_requirement_link import StateRequirementLink
from myhpom.models.document import AdvanceDirective, DocumentUrl
from django.utils.safestring import mark_safe


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


class DocumentUrlInlineAdmin(admin.StackedInline):
    model = DocumentUrl
    fields = ('url_as_link', 'expiration',)
    readonly_fields = ('url_as_link',)
    extra = 0

    def url_as_link(self, obj):
        return mark_safe(
            '<a href="%s" target="_blank" rel="noopener noreferrer">%s</a>'
            % (obj.url, obj.url))


class AdvanceDirectiveAdmin(admin.ModelAdmin):
    model = AdvanceDirective
    inlines = [DocumentUrlInlineAdmin]


admin.site.register(State, StateAdmin)
admin.site.register(StateRequirement, StateRequirementAdmin)
admin.site.register(AdvanceDirective, AdvanceDirectiveAdmin)
