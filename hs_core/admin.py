from mezzanine.pages.admin import PageAdmin
from mezzanine.pages.models import Page
from django.contrib.gis import admin
from django.contrib.contenttypes.admin import GenericTabularInline
from .models import *


class InlineResourceFiles(GenericTabularInline):
    model = ResourceFile

class CorePageAdmin(admin.ModelAdmin):
    model = Page
    list_display = ('title', 'status')

    def get_queryset(self, request):
        ''' excludes resources pages from Pagesadmin'''
        qs = super(CorePageAdmin, self).get_queryset(request)
        return qs.exclude(slug__startswith='resource/')


class BaseResourceAdmin(admin.ModelAdmin):
    model = BaseResource
    inlines = [InlineResourceFiles]
    list_per_page = 20
    list_display = ('title', 'author', 'short_id', 'resource_type')
    search_fields = ('title', 'short_id', 'resource_type')


admin.site.unregister(Page)
admin.site.register(Page, CorePageAdmin)
admin.site.register(BaseResource, BaseResourceAdmin)
