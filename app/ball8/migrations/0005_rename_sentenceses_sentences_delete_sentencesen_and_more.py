# Generated by Django 4.1.2 on 2024-02-28 16:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ball8', '0004_sentenceses_sentencespt'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='SentencesEs',
            new_name='Sentences',
        ),
        migrations.DeleteModel(
            name='SentencesEn',
        ),
        migrations.DeleteModel(
            name='SentencesFr',
        ),
        migrations.DeleteModel(
            name='SentencesPt',
        ),
    ]
