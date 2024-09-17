from rest_framework import serializers

from biocounter.processing.models import BatchImage



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