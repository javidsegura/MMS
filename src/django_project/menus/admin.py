""" Specify the models you want to display in the admin interface 


Notes on some functions that control the django admin interface:
1. format_html: used to format the html of the admin interface
2. list_display: represents the columns in the admin interface
3. list_filter: filter based upon the fields
4. readonly_fields: fields that are readonly

"""

from menus.utils.extraction import ai_call
from menus.utils.insertion import populate_menu_data

from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.html import format_html  
from .models import (
    User,
    Restaurant,
    Menu,
    MenuItem,
    DietaryRestriction,
    AuditLog,
    MenuSection, 
    MenuVersion
)

@admin.register(User)
class CustomUserAdmin(UserAdmin):
    list_display = ('id', 'username', 'email', 'first_name', 'last_name', 'is_staff') 
    list_filter = ('is_staff', 'is_superuser') 
    fieldsets = UserAdmin.fieldsets + (
        ('Additional Info', {'fields': ('country', 'city', 'state', 'zip', 'street')}),
    )

@admin.register(Restaurant)
class RestaurantAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'phone', 'email', 
                    'website', 'country', 'city', 'state',
                    'zip', 'street', 'last_edited')
    search_fields = ('name', 'city')
    list_filter = ('country', 'city', 'state')

@admin.register(Menu)
class MenuAdmin(admin.ModelAdmin):
    """
    Modify the save_model function to call processing functions before.
    Menu is the whole record of the model.
        -  menu.menu_file is uploaded file. It has the following attributes:
            - url: the link to the file in the server
            - name: the name of the file
            - path: the path to the file in the server
            - size: the size of the file
            - file: the actual file object
    
    """
    list_display = ('id', 'restaurant', 'user_id', 'version', 'menu_file_link',
                    'active_status', 'available_from', 'available_until',
                    'timeUpload', 'last_edited')
    list_filter = ('active_status', 'available_from', 'available_until')
    readonly_fields = ('user_id', 'version', "restaurant") # restaurante will be readonly, with default temp
    search_fields = ('restaurant__name',)

    
    def save_model(self, request, menu, form, change):
        """First execute this body then save model as usual
        
        Note: we create an audit log and then we assing the corresponding menu version (FK)
        """
        # Log the event
    
        super().save_model(request, menu, form, change) 


        if menu.menu_file and not change:  # Only process on new uploads
            uploaded_log = AuditLog.objects.create(
                phase="Uploaded file",
                status="Received"
            )
            menu.user_id = request.user
            uploaded_log.status = "Stored successfully"
            try:
                extension = menu.menu_file.name.split(".")[-1]
                menu_json, ai_call_log = ai_call(menu, extension=extension)
                if menu_json is None:
                    raise ValueError("No menu_json returned from AI call")
                
                populate_menu_data(menu, menu_json)
                if menu.restaurant.name:
                    menu_version = MenuVersion.objects.create(restaurant=menu.restaurant) # For each restaurant there is a menu version
                    menu.version = menu_version
                    menu.save()
                    uploaded_log.menu_version = menu_version
                    ai_call_log.menu_version = menu_version
                    uploaded_log.save()
                    ai_call_log.save()

                else:
                    raise ValueError("Restaurant must be set before creating MenuVersion")
            except Exception as e:
                ai_call_log.status = "Failed"
                ai_call_log.other = str(e)
                ai_call_log.save()
                menu.delete() # consider deleting it instead 

    def menu_file_link(self, menu): # referred in list_display
        if menu.menu_file:
            return format_html('<a href="{}" target="_blank">View File</a>', menu.menu_file.url)
        return '-'

    menu_file_link.short_description = 'Menu File' # Change the column name in the admin interface

@admin.register(MenuSection)
class MenuSectionAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'menu', 'last_edited')
    list_filter = ('menu',)
    search_fields = ('menu__restaurant__name',)

@admin.register(MenuItem)
class MenuItemAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'menu_section', 'price', 
                    'currency', 'available', 'last_edited')
    list_filter = ('available', 'currency', 'menu_section')
    search_fields = ('name', 'description', 'menu_section')

@admin.register(DietaryRestriction)
class DietaryRestrictionAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'last_edited')
    list_filter = ('name',)
    search_fields = ('name',)

@admin.register(MenuVersion)
class MenuVersionAdmin(admin.ModelAdmin):
    list_display = ("restaurant", "composite_id")
    readonly_fields = ("composite_id",)
    list_filter = ("restaurant",)
    search_fields = ("restaurant__name",) # restaurant is a foreign key. syntaxis accordingly

@admin.register(AuditLog)
class AuditLogAdmin(admin.ModelAdmin):
    list_display = ('id', 'menu_version', 'status', 'phase', 
                    'time_registered', 'other', 'last_edited')
    list_filter = ('status',)
    readonly_fields = ('menu_version', 'status', 'phase', 'other', "time_registered", "other")
    search_fields = ('menu_version__restaurant__name',)

