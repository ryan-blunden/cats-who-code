from django.http import JsonResponse


def heath_check(request):
    return JsonResponse({'status': 'ok'})

