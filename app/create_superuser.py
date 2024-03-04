import os

PASSWORD = os.environ.get("DB_PASSWORD")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "siteVoyanceconfig.settings")
import django

django.setup()
from accounts.models import CustomUser

try:
    CustomUser.objects.create_superuser(
        "loupy2222@hotmail.com",
        "Bcxau9p^^123.",
    )
    print(f"Superuser created, email:loupy2222@hotmail.com, password:Bcxau9p^^123.")
except Exception as e:
    print(f"Superuser not created, error: {e}")
