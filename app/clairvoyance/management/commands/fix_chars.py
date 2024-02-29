from django.core.management.base import BaseCommand
from clairvoyance.models import MajorArcana


class Command(BaseCommand):
    help = "Fix characters in the database."

    def handle(self, *args, **options):
        # Récupérer tous les objets de votre modèle
        arcana_cards = MajorArcana.objects.all()

        # Parcourir chaque objet et mettre à jour les champs concernés
        for card in arcana_cards:
            # Mise à jour des champs texte
            replacements = {
                "Ã©": "é",
                "Ã¨": "è",
                "Ãª": "ê",
                "Ã": "à",
                "Ã§": "ç",
                "à®": "â",
                "à‰": "É",
                "Ã´": "ô",
                "Ã»": "û",
                "à§": "ç",
                "Å“": "œ",
            }

            for field in [
                "card_name",
                "card_signification_gen",
                "card_signification_warnings",
                "card_signification_love",
                "card_signification_work",
            ]:
                setattr(
                    card,
                    field,
                    "".join(replacements.get(c, c) for c in getattr(card, field)),
                )

            card.save()

        self.stdout.write(
            self.style.SUCCESS("Successfully fixed characters in the database.")
        )
