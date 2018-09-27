from __future__ import unicode_literals

from django.contrib import admin
from django.core.urlresolvers import reverse
from myhpom.tasks import CloudFactoryAbortDocumentRun, CloudFactoryUpdateDocumentRun
from django.utils.safestring import mark_safe

from myhpom.models import (
    AdvanceDirective, CloudFactoryDocumentRun, DocumentUrl, State, StateRequirement,
    StateRequirementLink)


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
                '<li><a href="%s">%s</a></li>'
                % (reverse("admin:myhpom_cloudfactorydocumentrun_change", args=[cf_run.id]), cf_run)
                for cf_run in obj.cloudfactorydocumentrun_set.all()
            )
            + '</ul>'
        )


class AdvanceDirectiveAdmin(admin.ModelAdmin):
    model = AdvanceDirective
    inlines = [DocumentUrlInlineAdmin]


class CloudFactoryDocumentRunAdmin(admin.ModelAdmin):
    model = CloudFactoryDocumentRun
    fields = (
        ('status', 'run_id'),
        ('document_url', 'document_host', 'advance_directive'),
        ('inserted_at', 'updated_at'),
        ('created_at', 'processed_at'),
        'post_data',
        'response_content',
    )
    readonly_fields = [
        'document_url',
        'inserted_at',
        'updated_at',
        'document_host',
        'advance_directive',
        'status',
        'run_id',
        'created_at',
        'processed_at',
        'post_data',
        'response_content',
    ]
    list_display = [
        'document_url',
        'document_host',
        'run_id',
        'status',
        'latest_timestamp',
        'advance_directive',
    ]
    actions = ['abort_runs', 'update_runs']

    def latest_timestamp(self, obj):
        return obj.processed_at or obj.created_at or obj.updated_at

    def advance_directive(self, obj):
        if obj.document_url and obj.document_url.advancedirective:
            return mark_safe(
                '<a href="%s">%s</a>'
                % (
                    reverse(
                        "admin:myhpom_advancedirective_change",
                        args=[obj.document_url.advancedirective.id],
                    ),
                    obj.document_url.advancedirective,
                )
            )

    def delete_selected(self, request, queryset):
        self.abort_runs(request, queryset)
        super(CloudFactoryDocumentRunAdmin, self).delete_selected(request, queryset)

    def abort_runs(self, request, queryset):
        for cf_run in queryset:
            CloudFactoryAbortDocumentRun(cf_run.id)

    abort_runs.short_description = "Abort the selected document runs at CloudFactory."

    def update_runs(self, request, queryset):
        for cf_run in queryset:
            CloudFactoryUpdateDocumentRun(cf_run.id)

    update_runs.short_description = "Update the selected document runs by querying CloudFactory."


admin.site.register(State, StateAdmin)
admin.site.register(StateRequirement, StateRequirementAdmin)
admin.site.register(AdvanceDirective, AdvanceDirectiveAdmin)
admin.site.register(CloudFactoryDocumentRun, CloudFactoryDocumentRunAdmin)
