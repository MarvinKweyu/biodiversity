from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.filters import SearchFilter
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet

from biocounter.processing.api.serializers import BatchImageSerializer, ImageUploadSerializer, BulkImageUploadSerializer

from biocounter.users.models import User
from biocounter.processing.models import BatchImage

from biocounter.processing.tasks import process_batch_upload


class BatchImageViewSet(ModelViewSet):
    """
    Viewset for BatchImage model
    """

    queryset = BatchImage.objects.all()
    serializer_class = BatchImageSerializer
    lookup_field = "pk"
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ["status", "flower_count"]

    @action(detail=False, methods=["post"], serializer_class=BulkImageUploadSerializer)
    def bulk_upload(self, request: Request):
        """
        Create a bulk upload
        WIP
        """
        serializer = BulkImageUploadSerializer(data=request.data)
        if serializer.is_valid():
            print("\n\n\n\n All images validated")
            print(serializer.validated_data)
            images = serializer.validated_data.get("images")
        
            new_images = [
                BatchImage(
                    image_file=image["image"],
                    metadata=image["metadata"],
                )
                for image in images
            ]
            
            # Bulk create the images
            # thought: upload as background task?
            BatchImage.objects.bulk_create(new_images)
            
            return Response(
                {"pending_processing": True}, status=status.HTTP_200_OK
            )
        print("\n\n\n\n Images not validated")
        print(serializer.errors)
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    @action(detail=False, methods=["post"])
    def process(self, request: Request, pk=None):
        """
        Process a batch upload
        """
        
        process_batch_upload.delay() 
        return Response(status=status.HTTP_200_OK)


