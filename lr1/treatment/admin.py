from django.contrib import admin

from treatment.models import Client, Check, Staff, Service, Schedule, Appointment

admin.site.register(Client)
admin.site.register(Check)
admin.site.register(Staff)
admin.site.register(Service)
admin.site.register(Schedule)
admin.site.register(Appointment)