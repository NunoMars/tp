from django.db import models
from django.utils.safestring import mark_safe
from django_prometheus.models import ExportModelOperationsMixin


class MajorArcana(models.Model, ExportModelOperationsMixin("MajorArcana")):
    """Class to define the mayor cards deck."""

    CHOICES = (
        ("Positif", "Positif"),
        ("Negatif", "Negatif"),
        ("Neutral", "neutral"),
    )

    card_name = models.CharField(max_length=50)
    card_signification_gen = models.TextField(default="card_signification_gen")
    card_signification_warnings = models.TextField(
        default="card_signification_warnings"
    )
    card_signification_love = models.TextField(default="card_signification_love")
    card_signification_work = models.TextField(default="card_signification_work")
    card_image = models.ImageField(upload_to="MajorArcanaCards")
    card_polarity = models.CharField(max_length=10, choices=CHOICES, default="Positif")

    def __str__(self):
        return self.card_name

    def image_tag(self):

        return mark_safe(f'<img src="{self.card_image}" width="75" height="75" />')

    image_tag.short_description = "Image"


class LeftDeck(models.Model, ExportModelOperationsMixin("LeftDeck")):
    """Class to define the left deck."""

    card_id = models.ForeignKey(MajorArcana, on_delete=models.CASCADE)

    def __str__(self):
        return self.card_id.card_name


class RightDeck(models.Model, ExportModelOperationsMixin("RightDeck")):
    """Class to define the right deck."""

    card_id = models.ForeignKey(MajorArcana, on_delete=models.CASCADE)

    def __str__(self):
        return self.card_id.card_name
