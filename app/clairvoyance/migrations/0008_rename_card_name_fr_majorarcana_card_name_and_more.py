# Generated by Django 4.1.2 on 2024-02-28 16:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('clairvoyance', '0007_majorarcana_card_signification_love_en_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='majorarcana',
            old_name='card_name_fr',
            new_name='card_name',
        ),
        migrations.RenameField(
            model_name='majorarcana',
            old_name='card_signification_gen_fr',
            new_name='card_signification_gen',
        ),
        migrations.RenameField(
            model_name='majorarcana',
            old_name='card_signification_love_fr',
            new_name='card_signification_love',
        ),
        migrations.RenameField(
            model_name='majorarcana',
            old_name='card_signification_warnings_fr',
            new_name='card_signification_warnings',
        ),
        migrations.RenameField(
            model_name='majorarcana',
            old_name='card_signification_work_fr',
            new_name='card_signification_work',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_name_en',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_name_es',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_name_pt',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_gen_en',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_gen_es',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_gen_pt',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_love_en',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_love_es',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_love_pt',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_warnings_en',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_warnings_es',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_warnings_pt',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_work_en',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_work_es',
        ),
        migrations.RemoveField(
            model_name='majorarcana',
            name='card_signification_work_pt',
        ),
    ]