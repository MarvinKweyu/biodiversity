import logging
import os
from PIL import Image
from django.db import transaction

from config import celery_app

import zipfile
from PIL import Image

from transformers import pipeline

from biocounter.processing.models import BatchImage, ZipFile


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


@celery_app.task()
def process_compressed_upload(uploadId: str) -> None:
    """
    Process a compressed upload
    This can be used if processing from an upload made by the user
    """
    zip_upload = ZipFile.objects.get(_id=uploadId)
    pipe = pipeline("object-detection", model="smutuvi/flower_count_model")

    zip_upload.status = "processing"
    zip_upload.save()
    saved_results = []

    # unzip this file and get all images within it
    with zipfile.ZipFile(zip_upload.zip_file, "r") as z:
        for image in z.namelist():
            with z.open(image) as f:
                if not image.endswith((".png", ".jpg", ".jpeg")):
                    continue
                if BatchImage.objects.filter(name=image).exists():
                    continue
                img = Image.open(f)
                flower_count = pipe(img)
                saved_results.append(
                BatchImage(
                    zip_file=zip_upload,
                    image_file=image,
                    name=image,
                    flower_count=len(flower_count),
                    status="completed",
                )
            )
    BatchImage.objects.bulk_create(saved_results)
    zip_upload.status = "completed"
    zip_upload.save()

    logger.info("Upload processed successfully")
