# Generated by Django 4.1.2 on 2024-03-04 09:55

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Sentences',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sentence', models.TextField()),
                ('sentence_polarity', models.CharField(choices=[('Positif', 'Positif'), ('Negatif', 'Negatif'), ('Neutral', 'neutral')], default='Positif', max_length=10)),
            ],
        ),
    ]
