# Generated by Django 5.1.3 on 2024-11-16 09:22

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('menus', '0022_alter_restaurant_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='auditlog',
            name='time_till_change',
            field=models.TimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='auditlog',
            name='menu_version',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='menus.menuversion'),
        ),
    ]
