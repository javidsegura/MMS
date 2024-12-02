# Generated by Django 5.1.3 on 2024-12-02 16:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('menus', '0030_alter_restaurant_state'),
    ]

    operations = [
        migrations.AlterField(
            model_name='menuitem',
            name='description',
            field=models.CharField(blank=True, max_length=199, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='city',
            field=models.CharField(blank=True, max_length=99, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='country',
            field=models.CharField(blank=True, max_length=99, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='email',
            field=models.EmailField(blank=True, max_length=99, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='name',
            field=models.CharField(max_length=99, null=True, unique=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='phone',
            field=models.CharField(blank=True, max_length=99, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='street',
            field=models.CharField(blank=True, max_length=99, null=True),
        ),
        migrations.AlterField(
            model_name='restaurant',
            name='website',
            field=models.URLField(blank=True, max_length=99, null=True),
        ),
    ]
