from django.contrib import admin

from myhpom import models


class StateAdvanceDirectiveAdmin(admin.ModelAdmin):
    model = models.StateAdvanceDirective


admin.site.register(models.StateAdvanceDirective, StateAdvanceDirectiveAdmin)
