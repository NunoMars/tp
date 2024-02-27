from .views import HealthCheckView
from django.urls import path

urlpatterns = [
    path("", HealthCheckView.as_view(), name="healthz"),
]
