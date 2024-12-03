"""
A model is an entity in a database. Here you provide the template for that entity, which will be used 
through the Django interface.
"""

from django.db import models
from django.contrib.auth.models import AbstractUser
from storages.backends.s3boto3 import S3Boto3Storage

class User(AbstractUser):
    """
    Extends the default Django user model by adding address-related fields.

    Attributes:
        country (str): The country of the user.
        city (str): The city of the user.
        state (str): The state of the user (abbreviation).
        zip (int): The zip code of the user.
        street (str): The street address of the user.
    """
    country = models.CharField(max_length=50, null=True, blank=True)
    city = models.CharField(max_length=50, null=True, blank=True)
    state = models.CharField(max_length=3, null=True, blank=True)
    zip = models.SmallIntegerField(null=True, blank=True)
    street = models.CharField(max_length=50, null=True, blank=True)

    def __str__(self):
        return self.username

    class Meta:
        indexes = [
            models.Index(fields=['email']),
            models.Index(fields=['username', 'email']),
            models.Index(fields=['country', 'city', 'state', 'zip', 'street']),
        ]


class Restaurant(models.Model):
    """
    Represents a restaurant entity in the database.

    Attributes:
        name (str): The name of the restaurant (unique).
        phone (str): The phone number of the restaurant.
        website (str): The website URL of the restaurant.
        email (str): The email address of the restaurant.
        country (str): The country where the restaurant is located.
        city (str): The city where the restaurant is located.
        state (str): The state where the restaurant is located.
        zip (int): The zip code of the restaurant's location.
        street (str): The street address of the restaurant.
        last_edited (datetime): The timestamp when the record was last updated.
    """
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
            models.Index(fields=['name']),
            models.Index(fields=['country', 'city', 'state', 'zip', 'street']),
            models.Index(fields=['name', 'phone', 'email', 'website']),
        ]


class MenuVersion(models.Model):
    """
    Represents a version of a restaurant's menu.

    Attributes:
        restaurant (Restaurant): The restaurant the menu version belongs to.
        version_number (int): The version number of the menu.
        composite_id (str): A unique identifier combining the restaurant name and version number.
    """
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, null=True, blank=True)
    version_number = models.IntegerField(editable=False)
    composite_id = models.CharField(max_length=255, unique=True, editable=False)

    def save(self, *args, **kwargs):
        """
        Overrides the save method to automatically assign version numbers 
        and composite IDs based on the restaurant.
        """
        if not self.pk:  # Only for new instances
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
            models.Index(fields=['restaurant', 'version_number']),
        ]


class Menu(models.Model):
    """
    Represents a menu for a restaurant.

    Attributes:
        restaurant (Restaurant): The restaurant this menu belongs to.
        version (MenuVersion): The version of the menu.
        menu_file (FileField): A file containing the menu content.
        available_until (date): The date until which the menu is available.
        available_from (date): The date from which the menu is available.
        active_status (bool): Whether the menu is currently active.
        user_id (User): The user who uploaded or edited the menu.
        timeUpload (datetime): The timestamp when the menu was uploaded.
        last_edited (datetime): The timestamp when the menu was last updated.
    """
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, null=True, blank=True)
    version = models.ForeignKey(MenuVersion, on_delete=models.CASCADE, null=True, blank=True)
    menu_file = models.FileField(null=True, blank=True)
    available_until = models.DateField(null=True, blank=True)
    available_from = models.DateField(null=True, blank=True)
    active_status = models.BooleanField(default=True, null=True, blank=True)
    user_id = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    timeUpload = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return f"{self.version}" if self.version else f"No version: {self.id}"

    class Meta:
        verbose_name = "Menu"
        verbose_name_plural = "Menus"
        indexes = [
            models.Index(fields=['available_from', 'available_until']),
        ]


class MenuSection(models.Model):
    """
    Represents a section within a menu.

    Attributes:
        menu (Menu): The menu this section belongs to.
        name (str): The name of the section.
        last_edited (datetime): The timestamp when the section was last updated.
    """
    menu = models.ForeignKey(Menu, on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=99, null=True, blank=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return f"{self.menu.restaurant.name}:{self.menu.id}:{self.name}"

    class Meta:
        verbose_name = "Menu Section"
        verbose_name_plural = "Menu Sections"


class MenuItem(models.Model):
    """
    Represents an item within a menu section.

    Attributes:
        menu_section (MenuSection): The section this item belongs to.
        name (str): The name of the menu item.
        description (str): A brief description of the menu item.
        price (int): The price of the menu item.
        currency (str): The currency used for the price.
        available (bool): Whether the item is currently available.
        last_edited (datetime): The timestamp when the item was last updated.
    """
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
            models.Index(fields=['name']),
        ]


class DietaryRestriction(models.Model):
    """
    Represents dietary restrictions associated with menu items.

    Attributes:
        menu_items (MenuItem): The menu items associated with this restriction.
        name (str): The name of the dietary restriction (e.g., Vegan, Gluten-Free).
        last_edited (datetime): The timestamp when the record was last updated.
    """
    menu_items = models.ManyToManyField(MenuItem, related_name='dietary_restrictions')
    name = models.CharField(max_length=99, null=True, blank=True, unique=True)
    last_edited = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Dietary Restriction"
        verbose_name_plural = "Dietary Restrictions"


class AuditLog(models.Model):
    """
    Represents an audit log for menu version changes.

    Attributes:
        menu_version (MenuVersion): The menu version this log belongs to.
        phase (str): The phase of the audit (e.g., Review, Publish).
        status (str): The status of the audit phase.
        time_registered (datetime): The timestamp when the log entry was created.
        other (str): Additional information about the audit.
        last_edited (datetime): The timestamp when the log entry was last updated.
    """
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
            models.Index(fields=['menu_version']),
        ]
