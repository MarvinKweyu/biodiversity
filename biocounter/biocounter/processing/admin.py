from django.contrib import admin
from biocounter.processing.models import BatchImage, ZipFile

@admin.register(BatchImage)
class BatchImageAdmin(admin.ModelAdmin):
    """
    Admin for BatchImage
    """
    list_display = ["zip_file", "_id", "image_file", "metadata", "status"]
    list_filter = ["status"]
    search_fields = ["_id", "metadata"]


@admin.register(ZipFile)
class ZipFileAdmin(admin.ModelAdmin):
    """
    Admin for ZipFile
    """
    list_display = ["_id", "name", "user","status", "created"]
    list_filter = ["status"]
    search_fields = ["_id", "name"]
