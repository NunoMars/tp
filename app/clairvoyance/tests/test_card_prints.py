from django.test import TestCase

from clairvoyance.models import MajorArcana
from clairvoyance.card_prints import response_card
from clairvoyance.prepare_decks_cards import prepare_decks


class CardsPrintTest(TestCase):
    def setUp(self):
        i = 1
        for i in range(1, 38):
            card = MajorArcana.objects.create(
                card_name="carte1" + str(i),
                card_signification_gen="Signification_gen" + str(i),
                card_signification_warnings="Signification_warnings" + str(i),
                card_signification_love="Signification_love" + str(i),
                card_signification_work="Signification_work" + str(i),
                card_image=str(i) + ".jpg",
            )

        self.name = "Nuno"

        self.right_deck = prepare_decks()[1]
        self.left_deck = prepare_decks()[0]

    def test_response_card(self):
        self.card_to_test = MajorArcana.objects.get(card_name="carte13")

        self.assertTrue(str(self.card_to_test) == "carte13")
