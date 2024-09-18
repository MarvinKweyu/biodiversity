# make sure the file is a compressed file
import zipfile
from django.forms import ValidationError


def validate_filetype(value):
    """
    A validator to make sure the file is a zip file
    """
    if not zipfile.is_zipfile(value):
        raise ValidationError("File must be a zip file")
    
    # if not value.name.endswith(".zip"):
    #     raise ValidationError("File must be a zip file")