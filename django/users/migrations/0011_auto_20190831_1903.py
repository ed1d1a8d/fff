# Generated by Django 2.2.4 on 2019-08-31 19:03

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0010_auto_20190831_1829'),
    ]

    operations = [
        migrations.AlterField(
            model_name='request',
            name='status',
            field=models.CharField(max_length=255),
        ),
        migrations.AlterField(
            model_name='user',
            name='lobby_expiration',
            field=models.DateTimeField(default=datetime.datetime(2019, 8, 31, 19, 3, 51, 699708)),
        ),
    ]
