from django.conf import settings
from rest_framework.routers import DefaultRouter
from rest_framework.routers import SimpleRouter

from biocounter.users.api.views import UserViewSet
from biocounter.processing.api.views import (
    
    BatchImageViewSet,
    
)

router = DefaultRouter() if settings.DEBUG else SimpleRouter()

router.register("users", UserViewSet)
# processing
router.register("images", BatchImageViewSet)


app_name = "api"
urlpatterns = router.urls
