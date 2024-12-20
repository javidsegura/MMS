"""
A model is an entity in database. Here you provide the template for that entity that will be used 
through the Django interface
"""

from django.db import models
from django.contrib.auth.models import AbstractUser
from storages.backends.s3boto3 import S3Boto3Storage

class User(AbstractUser):
     # These fields are already included:
    # username
    # password
    # first_name
    # last_name
    # email
    # is_staff
    # is_active
    # date_joined
    country = models.CharField(max_length=50, null=True, blank=True) 
    city = models.CharField(max_length=50, null=True, blank=True)
    state = models.CharField(max_length=3, null=True, blank=True)
    zip = models.SmallIntegerField(null=True, blank=True)
    street = models.CharField(max_length=50, null=True, blank=True)

    def __str__(self): 
        return self.username
    class Meta:
        indexes = [
            models.Index(fields=['email']),  # Index for frequent email lookups
            models.Index(fields=['username', 'email']),  # Composite Index
            models.Index(fields=['country', 'city', 'state', 'zip', 'street'])  # Composite Index
        ]
class Restaurant(models.Model):
    name = models.CharField(max_length=99, null=True, unique=True)
    phone = models.CharField(max_length=99, null=True, blank=True)
    website = models.URLField(max_length=99, null=True, blank=True)
    email = models.EmailField(max_length=99, null=True, blank=True)
    country = models.CharField(max_length=99, null=True, blank=True)
    city = models.CharField(max_length=99, null=True, blank=True)
    state = models.CharField(max_length=99, null=True, blank=True)
    zip = models.SmallIntegerField(null=True, blank=True)
    street = models.CharField(max_length=99, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return self.name
    class Meta:
        verbose_name = "Restaurant"
        verbose_name_plural = "Restaurants"
        indexes = [
            models.Index(fields=['name']),  # Index for restaurant name search
            models.Index(fields=['country', 'city', 'state', 'zip', 'street']),  # Composite Index for location
            models.Index(fields=['name', 'phone', 'email', 'website'])  # Composite Index for contact details
        ]

class MenuVersion(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, null=True, blank=True)
    version_number = models.IntegerField(editable=False)
    composite_id = models.CharField(max_length=255, unique=True, editable=False)

    def save(self, *args, **kwargs):
        if not self.pk:  # Only for new instances
            # Get the latest version number for this specific restaurant
            latest_version = MenuVersion.objects.filter(
                restaurant=self.restaurant
            ).order_by('-version_number').first()
            
            self.version_number = (latest_version.version_number + 1) if latest_version else 1
            self.composite_id = f"{self.restaurant.name}-v{self.version_number}:{self.restaurant.id}"
        
        super().save(*args, **kwargs)
    
    def __str__(self):
        return self.composite_id
    class Meta:
        verbose_name = verbose_name_plural = "Menu Versions"
        indexes = [
            models.Index(fields=['restaurant', 'version_number']),  # Index for frequent lookups on restaurant versions
        ]

class Menu(models.Model):
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, null=True, blank=True)
    version = models.ForeignKey(MenuVersion, on_delete=models.CASCADE, null=True, blank=True)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    menu_file = models.FileField(
                        null=True,
                        blank=True, 
                        storage=S3Boto3Storage()) 
    available_until = models.DateField(null=True, blank=True)
    available_from = models.DateField(null=True, blank=True)
    active_status = models.BooleanField(default=True, null=True, blank=True)
    timeUpload = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return f"{self.version}" if self.version else f"No version: {self.id}"
    class Meta:
        verbose_name = "Menu"
        verbose_name_plural = "Menus"
        indexes = [
            models.Index(fields=['available_from', 'available_until']),  # Composite Index for availability
        ]

class MenuSection(models.Model):
    menu = models.ForeignKey(Menu, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=99, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)
    def __str__(self):
        return f"{self.menu.restaurant.name}:{self.menu.version}:{self.name}"
    class Meta:
        verbose_name = "Menu Section"
        verbose_name_plural = "Menu Sections"

class MenuItem(models.Model):
    menu_section = models.ForeignKey(MenuSection, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=99, null=True, blank=True)
    description = models.CharField(max_length=199, null=True, blank=True)
    price = models.IntegerField(null=True, blank=True)
    currency = models.CharField(max_length=99, default='dollar', null=True, blank=True)
    available = models.BooleanField(null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return self.name
    class Meta:
        verbose_name = "Menu Item"
        verbose_name_plural = "Menu Items"
        indexes = [
            models.Index(fields=['name']),  # Index for menu item name lookups
        ]

class DietaryRestriction(models.Model):
    menu_items = models.ManyToManyField(MenuItem, related_name='dietary_restrictions') # relanted_name specified how to access the reverse relationship
    name = models.CharField(max_length=99, null=True, blank=True, unique=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return self.name
    class Meta:
        verbose_name = "Dietary Restriction"
        verbose_name_plural = "Dietary Restrictions"

class AuditLog(models.Model):
    menu_version = models.ForeignKey(MenuVersion, on_delete=models.CASCADE, null=True, blank=True)
    phase = models.CharField(max_length=99, null=True, blank=True)
    status = models.CharField(max_length=99, null=True, blank=True)
    time_registered = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    other = models.CharField(max_length=99, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)
    def __str__(self):
        return f"{self.menu_version}:{self.phase}"
    
    class Meta:
        verbose_name = "Audit Log"
        verbose_name_plural = "Audit Logs"
        indexes = [
            models.Index(fields=['menu_version']),  # Index for menu_version to speed up lookups
        ]
    