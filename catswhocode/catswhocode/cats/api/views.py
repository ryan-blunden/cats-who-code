from rest_framework.generics import ListAPIView

from stores.api.serializers import ClosestStoreSerializer
from stores.models import Store, ClosestStore

from utils.maps import GoogleDistanceMatrix


class ClosestStoresList(ListAPIView):
    latitude = None
    longitude = None

    serializer_class = ClosestStoreSerializer

    def get(self, request, *args, **kwargs):
        self.latitude = request.GET.get('latitude')
        self.longitude = request.GET.get('longitude')
        return super().get(request, *args, **kwargs)

    def get_queryset(self):
        stores = []

        for store in Store.objects.all()[0:5]:
            distance_response = GoogleDistanceMatrix(
                origins='{},{}'.format(self.latitude, self.longitude),
                destinations='{},{}'.format(store.latitude, store.longitude),
            ).compute()

            store = ClosestStore(
                id=store.id,
                name=store.name,
                latitude=store.latitude,
                longitude=store.longitude,
                distance=distance_response['distance'],
                time=distance_response['time'],
            )

            stores.append(store)

        return stores
