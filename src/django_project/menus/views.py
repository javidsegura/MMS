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
    MenuVersion, 
    AuditLog
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
from django.http import JsonResponse
from django.db import connection
import json

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

        print(f"Menu file: {menu_file}")
        print(f"User ID: {user_id}")
        
        if not menu_file:
            return Response({'error': 'No file provided'}, status=status.HTTP_400_BAD_REQUEST)
        
        # User_id object
        user_id = User.objects.get(id=user_id)
        uploaded_log = AuditLog.objects.create(
            phase="Uploaded file",
            status="Received"
        )
        # Create menu instance
        menu = Menu.objects.create(
            menu_file=menu_file,
            user_id=user_id
        )
        uploaded_log.status = "Stored successfully"

        # Process the menu file (similar to admin.py)
        extension = menu_file.name.split(".")[-1].lower()
        menu_json, extraction_log = ai_call(menu, extension=extension)
        if menu_json is None:
            menu.delete()
        if menu_json is None:
            extraction_log.status = "Failed"
            extraction_log.save()
            menu.delete()
            return Response(
                {'error': f'AI processing failed: {extraction_log.other}'}, 
                status=status.HTTP_422_UNPROCESSABLE_ENTITY
            )
        # Populate menu data
        try:
            insertion_log = populate_menu_data(menu, menu_json)
            if menu.restaurant.name:
                menu_version = MenuVersion.objects.create(restaurant=menu.restaurant) # For each restaurant there is a menu version
                menu.version = menu_version
                menu.save()
                insertion_log.menu_version = menu_version
                extraction_log.menu_version = menu_version
                uploaded_log.menu_version = menu.version
                insertion_log.save()
                extraction_log.save()
                uploaded_log.save()

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

from django.views.decorators.csrf import csrf_exempt
@csrf_exempt
def all_cheap_items(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        query = data.get('query')
        params = data.get('params', ())
        
        try:
            with connection.cursor() as cursor:
                cursor.execute(query, params)
                # Fetch results for all queries
                columns = [col[0] for col in cursor.description]
                results = []
                for row in cursor.fetchall():
                    results.append(dict(zip(columns, row)))
                return JsonResponse({'results': results})
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)
    
    return JsonResponse({'error': 'Only POST method is allowed'}, status=405)