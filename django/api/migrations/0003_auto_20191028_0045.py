# Generated by Django 2.2.4 on 2019-10-28 00:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20191019_2312'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='facebook_ID',
            field=models.CharField(blank=True, max_length=255),
        ),
        migrations.AddField(
            model_name='user',
            name='first_sign_in',
            field=models.BooleanField(default=True),
        ),
    ]
