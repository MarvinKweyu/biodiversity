import logging
from django.db import transaction

from config import celery_app

import torch
from PIL import Image


from transformers import AutoImageProcessor, AutoModelForObjectDetection


from biocounter.users.models import User
from biocounter.processing.models import BatchImage


logger = logging.getLogger(__name__)


@celery_app.task()
def process_batch_upload() -> None:
    """
    Process a batch upload
    """
    image_uploads = BatchImage.objects.filter(status="pending")
    model = AutoModelForObjectDetection.from_pretrained("smutuvi/flower_count_model")
    processor = AutoImageProcessor.from_pretrained("smutuvi/flower_count_model")

    # Process each image
    with transaction.atomic():
        for image in image_uploads:
            image.status = "processing"
            image.save()
            img = Image.open(image.image_file.path)

            inputs = processor(images=img, return_tensors="pt")

            # infer
            with torch.no_grad():
                outputs = model(**inputs)

            # Get the flower count from the model output (adjust as per your model's output)
            flower_count = torch.argmax(outputs.logits, dim=-1).item()
            # update the flower count for this image
            image.flower_count = flower_count
            image.status = "completed"
            image.save()

         
    logger.info("Upload processed successfully")
