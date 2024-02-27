from django.http import JsonResponse


class HealthCheckView:
    def get(self, request):
        return JsonResponse({"status": "ok"})
