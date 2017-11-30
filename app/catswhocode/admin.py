from django.contrib import admin


def soft_delete(modeladmin, request, queryset):
    queryset.update(deleted=True)


soft_delete.short_description = 'Mark selected records as deleted'


def soft_undelete(modeladmin, request, queryset):
    queryset.update(deleted=False)


soft_undelete.short_description = 'Mark selected records as un-deleted'


class EnabledModelAdmin(admin.ModelAdmin):
    list_filter = ('deleted',)

    def get_queryset(self, request):
        qs = self.model._default_manager.all_and_deleted()
        ordering = self.get_ordering(request)
        if ordering:
            qs = qs.order_by(*ordering)
        return qs

    actions = [soft_undelete, soft_delete]
