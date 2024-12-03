from .utils.extraction import ai_call
from .utils.insertion import populate_menu_data
from django.shortcuts import render
from rest_framework import viewsets, status
from rest_framework.decorators import api_view, parser_classes
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from .models import (
    Restaurant, 
    Menu, 
    MenuSection, 
    MenuItem, 
    DietaryRestriction, 
    User, 
    MenuVersion
)
from .serializers import (
    UserSerializer,
    RestaurantSerializer, 
    MenuSerializer,
    MenuSectionSerializer,
    MenuItemSerializer,
    DietaryRestrictionSerializer,
    MenuVersionSerializer
)

# Class-Based Views
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
class RestaurantViewSet(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer

class MenuVersionViewSet(viewsets.ModelViewSet):
    queryset = MenuVersion.objects.all()
    serializer_class = MenuVersionSerializer
class MenuItemViewSet(viewsets.ModelViewSet):
    queryset = MenuItem.objects.all()
    serializer_class = MenuItemSerializer

class MenuViewSet(viewsets.ModelViewSet):
    queryset = Menu.objects.all()
    serializer_class = MenuSerializer

class MenuSectionViewSet(viewsets.ModelViewSet):
    queryset = MenuSection.objects.all()
    serializer_class = MenuSectionSerializer

class DietaryRestrictionViewSet(viewsets.ModelViewSet):
    queryset = DietaryRestriction.objects.all()
    serializer_class = DietaryRestrictionSerializer


@api_view(['POST'])
@parser_classes([MultiPartParser, FormParser])
def upload_menu(request):
    """
    Upload and process a menu file, similar to Django admin functionality.
    Expects a multipart form with:
    - menu_file: The menu file (PDF, PNG, JPG, or HTML)
    - restaurant_id: ID of the restaurant this menu belongs to
    """
    try:
        # Get the uploaded file
        menu_file = request.FILES.get('menu_file')
        user_id = request.data.get('user_id')
        
        if not menu_file:
            return Response({'error': 'No file provided'}, status=status.HTTP_400_BAD_REQUEST)
        
        # User_id object
        user_id = User.objects.get(id=user_id)
        # Create menu instance
        menu = Menu.objects.create(
            menu_file=menu_file,
            user_id=user_id
        )

        # Process the menu file (similar to admin.py)
        extension = menu_file.name.split(".")[-1].lower()
        menu_json, ai_call_log = ai_call(menu, extension=extension)
        
        if menu_json is None:
            menu.delete()
            return Response(
                {'error': f'AI processing failed: {ai_call_log.other}'}, 
                status=status.HTTP_422_UNPROCESSABLE_ENTITY
            )

        # Populate menu data
        try:
            populate_menu_data(menu, menu_json)
            if menu.restaurant.name:
                menu_version = MenuVersion.objects.create(restaurant=menu.restaurant) # For each restaurant there is a menu version
                menu.version = menu_version
                menu.save()
            return Response({
                'message': 'Menu processed successfully',
                'menu_id': menu.id
            }, status=status.HTTP_201_CREATED)
            
        except Exception as e:
            menu.delete()
            return Response(
                {'error': f'Error processing menu data: {str(e)}'}, 
                status=status.HTTP_422_UNPROCESSABLE_ENTITY
            )

    except Exception as e:
        return Response(
            {'error': f'Server error: {str(e)}'}, 
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

