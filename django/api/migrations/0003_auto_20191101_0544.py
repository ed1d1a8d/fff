# Generated by Django 2.2.4 on 2019-11-01 05:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20191101_0543'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='fb_id',
            field=models.CharField(blank=True, max_length=255),
        ),
    ]
