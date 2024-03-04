from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model


class Command(BaseCommand):
    help = "Create a superuser"

    def handle(self, *args, **kwargs):
        # Créer un super utilisateur
        User = get_user_model()
        try:
            superuser = User.objects.create_superuser(
                "loupy2222@hotmail.com", "Bcxau9p^^123."
            )
            self.stdout.write(
                self.style.SUCCESS(
                    f"Superuser created, email: {superuser.email}, password: Bcxau9p^^123."
                )
            )
        except Exception as e:
            self.stderr.write(self.style.ERROR(f"Superuser not created, error: {e}"))
            pass
