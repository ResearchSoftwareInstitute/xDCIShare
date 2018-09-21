from __future__ import unicode_literals
from django.contrib import admin

from myhpom.models.state import State
from myhpom.models.state_requirement import StateRequirement
from myhpom.models.state_requirement_link import StateRequirementLink
from myhpom.models.document import AdvanceDirective, DocumentUrl
from myhpom.models.cloudfactory import CloudFactoryUnit, CloudFactoryRun
from myhpom.tasks import (
    CloudFactoryCancelAdvanceDirectiveRun,
    CloudFactoryUpdateAdvanceDirectiveRun,
)

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
    fields = ('url_as_link', 'expiration', 'cloud_factory_runs')
    readonly_fields = ('url_as_link', 'cloud_factory_runs')
    extra = 0

    def url_as_link(self, obj):
        return mark_safe(
            '<a href="%s" target="_blank" rel="noopener noreferrer">%s</a>' % (obj.url, obj.url)
        )

    def cloud_factory_runs(self, obj):
        return mark_safe(
            '<ul>'
            + ''.join(
                # Is there a better way to get a URL in the mmh-admin? I don't find a resolver.
                '<li><a href="/mmh-admin/myhpom/cloudfactoryrun/%d">%s</a></li>'
                % (cf_run.id, cf_run)
                for cf_run in obj.cloudfactory_runs
            )
            + '</ul>'
        )


class AdvanceDirectiveAdmin(admin.ModelAdmin):
    model = AdvanceDirective
    inlines = [DocumentUrlInlineAdmin]


class CloudFactoryUnitInlineAdmin(admin.StackedInline):
    model = CloudFactoryUnit
    fields = (('status', 'created_at', 'processed_at'), ('input_data', 'output_data'))
    readonly_fields = ['status', 'created_at', 'processed_at', 'input_data', 'output_data']
    extra = 0

    def input_data(self, obj):
        return self.field_data(obj.input)

    def output_data(self, obj):
        return self.field_data(obj.output)

    def field_data(self, data):
        if isinstance(data, list):
            return mark_safe(
                '<ul>' + ''.join(['<li>' + self.field_data(li) + '</li>' for li in data]) + '</ul>'
            )
        elif isinstance(data, dict):
            return mark_safe(
                '<table>'
                + ''.join(
                    '<tr><td><b>%s</b></td><td>%s</td></tr>' % (key, self.field_data(data[key]))
                    for key in data
                )
                + '</table>'
            )
        else:
            return str(data)


class CloudFactoryRunAdmin(admin.ModelAdmin):
    model = CloudFactoryRun
    fields = (('run_id', 'status'), ('line_id', 'callback_url'), ('created_at', 'processed_at'))
    readonly_fields = ['run_id', 'status', 'line_id', 'callback_url', 'created_at', 'processed_at']
    list_display = ['run_id', 'status', 'line_id', 'created_at', 'processed_at']
    inlines = [CloudFactoryUnitInlineAdmin]
    actions = ['cancel_cf_runs', 'update_cf_runs']

    def get_actions(self, request):
        actions = super(CloudFactoryRunAdmin, self).get_actions(request)
        # don't allow 'delete_selected' here
        if 'delete_selected' in actions:
            del actions['delete_selected']
        return actions

    def cancel_cf_runs(self, request, queryset):
        for cf_run in queryset:
            CloudFactoryCancelAdvanceDirectiveRun(cf_run.id)  # no celery / delay in admin

    cancel_cf_runs.short_description = "Cancel selected runs at CloudFactory."

    def update_cf_runs(self, request, queryset):
        for cf_run in queryset:
            CloudFactoryCancelAdvanceDirectiveRun(cf_run.id)  # no celery / delay in admin

    update_cf_runs.short_description = "Update selected runs by querying CloudFactory API."


admin.site.register(State, StateAdmin)
admin.site.register(StateRequirement, StateRequirementAdmin)
admin.site.register(AdvanceDirective, AdvanceDirectiveAdmin)
admin.site.register(CloudFactoryRun, CloudFactoryRunAdmin)
