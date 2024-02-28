from django.core.management.base import BaseCommand
from clairvoyance.models import MajorArcana  # Remplacez MyModel par votre modèle


class Command(BaseCommand):
    help = "Fix characters in the database."

    def handle(self, *args, **options):
        # Récupérer tous les objets de votre modèle
        arcana_cards = MajorArcana.objects.all()

        # Parcourir chaque objet et mettre à jour les champs concernés
        for card in arcana_cards:
            # Mise à jour des champs texte
            card.card_name = (
                card.card_name.replace("Ã©", "é")
                .replace("Ã¨", "è")
                .replace("Ãª", "ê")
                .replace("Ã", "à")
                .replace("Ã§", "ç")
                .replace("à®", "â")
                .replace("à‰", "É")
            )
            card.card_signification_gen = (
                card.card_signification_gen.replace("Ã©", "é")
                .replace("Ã¨", "è")
                .replace("Ãª", "ê")
                .replace("Ã", "à")
                .replace("Ã§", "ç")
                .replace("à®", "â")
                .replace("à‰", "É")
            )
            card.card_signification_warnings = (
                card.card_signification_warnings.replace("Ã©", "é")
                .replace("Ã¨", "è")
                .replace("Ãª", "ê")
                .replace("Ã", "à")
                .replace("Ã§", "ç")
                .replace("à®", "â")
                .replace("à‰", "É")
            )
            card.card_signification_love = (
                card.card_signification_love.replace("Ã©", "é")
                .replace("Ã¨", "è")
                .replace("Ãª", "ê")
                .replace("Ã", "à")
                .replace("Ã§", "ç")
                .replace("à®", "â")
                .replace("à‰", "É")
            )
            card.card_signification_work = (
                card.card_signification_work.replace("Ã©", "é")
                .replace("Ã¨", "è")
                .replace("Ãª", "ê")
                .replace("Ã", "à")
                .replace("Ã§", "ç")
                .replace("à®", "â")
                .replace("à‰", "É")
            )

            # Sauvegarde de l'objet mis à jour
            card.save()

        self.stdout.write(
            self.style.SUCCESS("Successfully fixed characters in the database.")
        )
