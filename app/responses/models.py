from django.db import models
from django_prometheus.models import ExportModelOperationsMixin


class ResponsesBookEn(models.Model, ExportModelOperationsMixin("ResponsesBookEn")):
    """Class to define the response sentences."""

    sentence_title = models.TextField()
    sentence = models.TextField()

    def __str__(self):
        return f"{self.sentence_title}"


class ResponsesBookFr(models.Model, ExportModelOperationsMixin("ResponsesBookFr")):
    """Class to define the response sentences."""

    sentence_title = models.TextField()
    sentence = models.TextField()

    def __str__(self):
        return f"{self.sentence_title}"


class ResponsesBookPt(models.Model, ExportModelOperationsMixin("ResponsesBookPt")):
    """Class to define the response sentences."""

    sentence_title = models.TextField()
    sentence = models.TextField()

    def __str__(self):
        return f"{self.sentence_title}"


class ResponsesBookEs(models.Model, ExportModelOperationsMixin("ResponsesBookEs")):
    """Class to define the response sentences."""

    sentence_title = models.TextField()
    sentence = models.TextField()

    def __str__(self):
        return f"{self.sentence_title}"
