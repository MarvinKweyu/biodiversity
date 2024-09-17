import logging
import os
from PIL import Image
from django.db import transaction

from config import celery_app

import torch
from PIL import Image


from transformers import pipeline

from biocounter.processing.models import BatchImage


logger = logging.getLogger(__name__)

from django.conf import settings

file_path = os.path.join(settings.BASE_DIR, "testdata")


@celery_app.task()
def process_test_data() -> None:
    """
    Process pre-trained data
    """
    pipe = pipeline("object-detection", model="smutuvi/flower_count_model")
    image_files = [
        f for f in os.listdir(file_path) if f.endswith((".png", ".jpg", ".jpeg"))
    ]

    saved_results = []

    for image_file in image_files:
        image_path = os.path.join(file_path, image_file)
        image = Image.open(image_path)
        try:
            results = pipe(image)
            # check if this image already exists, if so skip it
            if BatchImage.objects.filter(name=image_file).exists():
                continue

            saved_results.append(
                BatchImage(
                    name=image_file,
                    flower_count=len(results),
                    status="completed",
                )
            )
        except Exception as e:
            # we have this in case the model cannot, for some reason, process the image
            logger.error(f"Error processing image {image_file}: {e}")
            continue

    BatchImage.objects.bulk_create(saved_results)
    logger.info("Upload processed successfully")


@celery_app.task()
def process_batch_upload() -> None:
    """
    Process a batch upload
    This can be used if processing from an upload made by the user
    """
    image_uploads = BatchImage.objects.filter(status="pending")
    pipe = pipeline("object-detection", model="smutuvi/flower_count_model")

    # Process each image
    with transaction.atomic():
        for image in image_uploads:
            image.status = "processing"
            image.save()
            img = Image.open(image.image_file.path)
            result = pipe(img)
            image.flower_count = len(result)
            image.status = "completed"
            image.save()

    logger.info("Upload processed successfully")
