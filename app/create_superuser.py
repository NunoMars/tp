import os

PASSWORD = os.environ.get("DB_PASSWORD")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "siteVoyanceconfig.settings")
import django

django.setup()
from accounts.models import CustomUser

CustomUser.objects.create_superuser(
    "nuno.ricardo.mars@gmail.com.com",
    PASSWORD,
)
