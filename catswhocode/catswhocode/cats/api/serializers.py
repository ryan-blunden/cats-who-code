from rest_framework import serializers

from customers.api.serializers import CustomerSerializer
from stores.models import Store, ClosestStore, Order


class StoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Store
        fields = ('id', 'name', 'latitude', 'longitude')


class ClosestStoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClosestStore
        fields = ('id', 'name', 'latitude', 'longitude', 'distance', 'time')


class OrderProductSerializer(serializers.ModelSerializer):
    store = StoreSerializer()
    customer = CustomerSerializer()

    class Meta:
        model = Order
        fields = ('id', 'store', 'customer', 'order',
                  'metadata', 'expires', 'in_progress',)
