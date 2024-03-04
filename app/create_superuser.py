import os

PASSWORD = os.environ.get("DB_PASSWORD")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "siteVoyanceconfig.settings")
import django

django.setup()
from accounts.models import CustomUser

CustomUser.objects.create_superuser(
    "loupy222@hotmail.com",
    PASSWORD,
)
print(f"Superuser created, email:loupy222@hotmail.com, password:{PASSWORD}")
