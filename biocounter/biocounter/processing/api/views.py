from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import status
from rest_framework.decorators import action
from rest_framework.filters import SearchFilter
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet
from django.db.models import Count, Sum

from biocounter.processing.api.serializers import BatchImageSerializer
from biocounter.processing.models import BatchImage
from biocounter.processing.tasks import process_test_data


class BatchImageViewSet(ModelViewSet):
    """
    Viewset for BatchImage model
    """

    queryset = BatchImage.objects.all()
    serializer_class = BatchImageSerializer
    lookup_field = "pk"
    filter_backends = [DjangoFilterBackend, SearchFilter]
    filterset_fields = ["status", "flower_count"]
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

        return Response(
            {
                "total_images": total_images,
                "total_flowers": total_flowers,
                "average_flowers": total_flowers / total_images,
            },
            status=status.HTTP_200_OK,
        )
