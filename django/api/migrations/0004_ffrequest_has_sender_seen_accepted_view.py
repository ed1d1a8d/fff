# Generated by Django 2.2.4 on 2019-11-04 02:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20191101_0544'),
    ]

    operations = [
        migrations.AddField(
            model_name='ffrequest',
            name='has_sender_seen_accepted_view',
            field=models.BooleanField(default=True),
        ),
    ]
