from rest_framework.generics import ListAPIView

from cats.api.serializers import CatSerializer
from cats.models import Cat


class CatsList(ListAPIView):
    queryset = Cat.objects.all()
    serializer_class = CatSerializer
