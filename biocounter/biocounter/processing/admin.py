from django.contrib import admin
from biocounter.processing.models import BatchImage

@admin.register(BatchImage)
class BatchImageAdmin(admin.ModelAdmin):
    """
    Admin for BatchImage
    """
    list_display = ["_id", "image_file", "metadata", "status"]
    list_filter = ["status"]
    search_fields = ["_id", "metadata"]
