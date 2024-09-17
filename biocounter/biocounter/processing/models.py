import uuid

import slugify
from django.db import models

from biocounter.users.models import User


class CommonBaseModel(models.Model):
    """
    Common fields shared by all models in the app
    """

    _id = models.UUIDField(
        default=uuid.uuid4,
        unique=True,
        editable=False,
        primary_key=True,
    )
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        """
        Do not create a table for this model
        """

        abstract = True
        ordering = ["created"]


class BatchImage(CommonBaseModel):
    """
    Image model representing each image in a batch upload
    """

    image_file = models.ImageField(upload_to="uploads/images/", blank=True, null=True)
    name = models.CharField(max_length=500, blank=True, null=True)
    metadata = models.TextField(null=True, blank=True)
    flower_count = models.PositiveIntegerField(default=0)
    STATUS_OPTIONS = [
        ("pending", "Pending"),
        ("processing", "Processing"),
        ("completed", "Completed"),
    ]
    status = models.CharField(
        max_length=20,
        choices=STATUS_OPTIONS,
        default="pending",
    )

    def __str__(self):
        return f"Image {self.name} with count {self.flower_count._id}"
