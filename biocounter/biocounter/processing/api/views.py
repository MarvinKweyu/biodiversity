import zipfile
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.filters import SearchFilter
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet
from django.db.models import Count, Sum

from biocounter.processing.api.serializers import BatchImageSerializer, ZipFileSerializer
from biocounter.processing.models import BatchImage, ZipFile
from biocounter.processing.tasks import process_test_data,process_compressed_upload


class ZipFileViewSet(ModelViewSet):
    """
    Viewset for ZipFile model
    """

    queryset = ZipFile.objects.all()
    serializer_class = ZipFileSerializer
    lookup_field = "pk"
    def create(self, request, *args, **kwargs):
        """
        Unzip the file and save the images in the database after processing as a background task
        """
        user = request.user
        # update teh request data with the user
        request.data.update({"user": user.id})

        serializer = self.get_serializer(data=request.data)

        if not serializer.is_valid():
            return Response(
                serializer.errors, status=status.HTTP_400_BAD_REQUEST
            )

        # make sure it is a compressed file of any file extension
        if not zipfile.is_zipfile(request.FILES["zip_file"]):
            return Response(
                {"message": "File must be a zip file"},
                status=status.HTTP_400_BAD_REQUEST,)

        zip_file = request.FILES["zip_file"]
        # get the user
        user = request.user
        name = serializer.validated_data.get("name")

        # create the zip file object
        ZipFile.objects.create(zip_file=zip_file, user=user, name=name)
        return Response(
            {"message": "File uploaded successfully"},
            status=status.HTTP_201_CREATED,)

    @action(detail=False, methods=["get"])
    def statistics(self, request: Request, pk=None):
        """
        Get statistics for the zip files
        """
        total_files = ZipFile.objects.count()
        total_pending = ZipFile.objects.filter(status="pending").count()
        total_processing = ZipFile.objects.filter(status="processing").count()
        total_completed = ZipFile.objects.filter(status="completed").count()

        return Response(
            {
                "total_files": total_files,
                "total_pending": total_pending,
                "total_processing": total_processing,
                "total_completed": total_completed,
            },
            status=status.HTTP_200_OK,
        )

    @action(detail=True, methods=["get"])
    def process(self, request: Request, pk=None):
        """
        Process the zip file
        """
        zip_file = self.get_object()
        if zip_file.status != "pending":
            return Response(
                {"message": "File has already been processed"},
                status=status.HTTP_428_PRECONDITION_REQUIRED,
            )
        zip_file.status = "processing"
        zip_file.save()
        process_compressed_upload.delay(zip_file._id)
        # serialize the zip file
        
        return Response(
            {"message": "File processing started"},
            status=status.HTTP_200_OK,
        )

class BatchImageViewSet(ModelViewSet):
    """
    Viewset for BatchImage model
    """

    queryset = BatchImage.objects.all()
    serializer_class = BatchImageSerializer
    lookup_field = "pk"
    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_fields = ["status", "flower_count", "zip_file"]
    search_fields = ["flower_count"]

    @action(detail=False, methods=["post"])
    def process(self, request: Request, pk=None):
        """
        Process the test dataset
        """

        # processing = BatchImage.objects.filter(status="processing").exists()
        # # check if any batch uploads are processing
        # if processing:
        #     return Response(
        #         {"message": "There are uploads currently being processed"},
        #         status=status.HTTP_428_PRECONDITION_REQUIRED,
        #     )

        process_test_data.delay()
        return Response(status=status.HTTP_200_OK)

    @action(detail=False, methods=["get"])
    def statistics(self, request: Request, pk=None):
        """
        Get statistics for the batch images
        """

        total_images = BatchImage.objects.count()
        total_flowers = BatchImage.objects.aggregate(total_flowers=Sum("flower_count"))[
            "total_flowers"
        ]
        total = 0
        if not total_flowers:
            total_flowers = 0
        else:
            total = total_flowers / total_images

        return Response(
            {
                "total_images": total_images,
                "total_flowers": total_flowers,
                "average_flowers": total,
            },
            status=status.HTTP_200_OK,
        )
