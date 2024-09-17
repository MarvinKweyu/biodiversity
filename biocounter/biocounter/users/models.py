from typing import ClassVar

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.urls import reverse
from django.utils.translation import gettext_lazy as _

from .managers import UserManager


class User(AbstractUser):
    """
    Default custom user model for biocounter.
    """

    name = models.CharField(_("Name of User"), blank=True, max_length=255)
    first_name = None  # type: ignore[assignment]
    last_name = None  # type: ignore[assignment]
    email = models.EmailField(_("email address"), unique=True)
    username = None  # type: ignore[assignment]

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects: ClassVar[UserManager] = UserManager()

    def get_absolute_url(self) -> str:
        """Get URL for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("users:detail", kwargs={"pk": self.id})


class ProfileBase(models.Model):
    """
    Base user profile model. Should contain fields common to all users.
    """

    profile_image = models.ImageField(upload_to="profile_images", null=True, blank=True)
    created = models.DateField(auto_now_add=True, null=True, blank=True)
    updated = models.DateField(auto_now_add=True, null=True, blank=True)


class UserProfile(ProfileBase):
    """
    A user profile
    handle errata data
    """

    user = models.OneToOneField(
        User, on_delete=models.CASCADE, related_name="user_profile"
    )

    def __str__(self) -> str:
        return self.user.email

    def get_absolute_url(self):
        """Get url for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("profile:detail", kwargs={"email": self.user.email})
