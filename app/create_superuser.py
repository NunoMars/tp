import os

PASSWORD = os.environ.get("DB_PASSWORD")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "siteVoyanceconfig.settings")
import django

django.setup()
from django.contrib.auth.models import User

User.objects.create_superuser("loupy222", "nuno.ricardo.mars@gmail.com.com", PASSWORD)
