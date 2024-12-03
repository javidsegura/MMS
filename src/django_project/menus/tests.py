from django.test import TestCase
from django.test import TestCase
from .models import Restaurant
from .serializers import RestaurantSerializer
# Create your tests here.

# Testing views
# class MenuTestCase(TestCase):
#     def test_get_restaurants(self):
#         post = self.client.post("http://localhost:8000/api/restaurants/", 
#                                json={"name": "TestRestaurant"})
#         response = self.client.get("http://localhost:8000/api/restaurants/")
#         self.assertEqual(response.status_code, 200)
#         self.assertIn('TestRestaurant', response.json())
#         self.assertEqual(len(response.json()), 1)
#         print(f"Restaurants: {response.json()}")    


# # Testing models
class RestaurantTest(TestCase):
    def test_create_restaurant(self):
        prior_length = Restaurant.objects.count()
        # Create an instance of MyModel
        restaurant = Restaurant.objects.create(name="Test Restaurant")
        
        # Check if the instance is saved correctly
        self.assertEqual(restaurant.name, "Test Restaurant")
        self.assertEqual(Restaurant.objects.count(), prior_length + 1)

# # Testing serializers
class RestaurantSerializerTest(TestCase):
      def test_restaurant_serializer(self):
        data = {'name': 'Test Restaurant'}
        serializer = RestaurantSerializer(data=data)
        self.assertTrue(serializer.is_valid())
        self.assertEqual(serializer.validated_data['name'], 'Test Restaurant')
 
