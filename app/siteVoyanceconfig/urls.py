from django.contrib import admin
from django.urls import path, include
from clairvoyance.views import IndexView, contacts
from django.conf import settings
from django.conf.urls.static import static
from django.views.decorators.csrf import csrf_exempt

urlpatterns = [
    path("", IndexView.as_view(), name="home"),
    path(csrf_exempt("admin", admin.site.urls, name="admin")),
    path("accounts/", include("accounts.urls")),
    path("clairvoyance/", include("clairvoyance.urls")),
    path("responses/", include("responses.urls")),
    path("ball8/", include("ball8.urls")),
    path("contacts", contacts, name="contacts"),
    path("healthz", include("health_check.urls")),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
