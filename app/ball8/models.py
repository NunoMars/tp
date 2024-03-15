from django.db import models
from django_prometheus.models import ExportModelOperationsMixin

# Create your models here.


class Sentences(models.Model, ExportModelOperationsMixin):
    """Class to define the response sentences."""

    CHOICES = (
        ("Positif", "Positif"),
        ("Negatif", "Negatif"),
        ("Neutral", "neutral"),
    )
    sentence = models.TextField()
    sentence_polarity = models.CharField(
        max_length=10, choices=CHOICES, default="Positif"
    )

    def __str__(self):
        return f"{self.sentence}, {self.sentence_polarity}"
