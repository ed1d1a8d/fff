# Generated by Django 2.2.4 on 2019-08-31 20:13

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0016_auto_20190831_1953'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='lobby_expiration',
            field=models.DateTimeField(default=datetime.datetime(2019, 8, 31, 20, 13, 28, 861667, tzinfo=utc)),
        ),
    ]