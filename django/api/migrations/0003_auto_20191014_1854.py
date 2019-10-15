# Generated by Django 2.2.4 on 2019-10-14 18:54

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20191006_2140'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='image_url',
            field=models.URLField(blank=True, max_length=2048),
        ),
        migrations.AlterField(
            model_name='user',
            name='lobby_expiration',
            field=models.DateTimeField(default=datetime.datetime(2019, 10, 14, 18, 54, 40, 421366, tzinfo=utc)),
        ),
    ]