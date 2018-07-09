from django.contrib import admin

from myhpom.models.state import State


class StateAdmin(admin.ModelAdmin):
    model = State


admin.site.register(State, StateAdmin)
