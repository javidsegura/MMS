# Generated by Django 5.1.3 on 2024-11-15 10:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('menus', '0021_alter_restaurant_name'),
    ]

    operations = [
        migrations.AlterField(
            model_name='restaurant',
            name='name',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
    ]
