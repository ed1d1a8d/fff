# Generated by Django 2.2.4 on 2019-11-01 05:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='fb_id',
            field=models.CharField(blank=True, max_length=255, unique=True),
        ),
    ]
