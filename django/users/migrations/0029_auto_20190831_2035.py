# Generated by Django 2.2.4 on 2019-08-31 20:35

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0028_auto_20190831_2035'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='lobby_expiration',
            field=models.DateTimeField(default=datetime.datetime(2019, 8, 31, 20, 35, 22, 109064, tzinfo=utc)),
        ),
    ]
