from rest_framework import serializers

from biocounter.processing.models import BatchImage, ZipFile



class ZipFileSerializer(serializers.ModelSerializer):
    """
    Serializer for ZipFile model
    """

    images = serializers.SerializerMethodField()

    class Meta:
        model = ZipFile
        fields = ["_id", "name", "zip_file", "user", "status","images", "created", "updated"]

    def get_images(self, obj):
        """
        Get the count of images associated with the zip file
        """
        return obj.batchimage_set.count()

class BatchImageSerializer(serializers.ModelSerializer):
    """
    Serializer for BatchImage model
    """

    class Meta:
        model = BatchImage
        fields = "__all__"


class ImageUploadSerializer(serializers.Serializer):
    """
    Upload image
    """
    image = serializers.ImageField()
    metadata = serializers.CharField(required=False)


class BulkImageUploadSerializer(serializers.Serializer):
    """
    Bulk upload images
    """
    # accept a list of image, metadata pairs
    images = ImageUploadSerializer(many=True)