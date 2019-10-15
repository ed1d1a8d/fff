#!/bin/bash
./manage.py reset_db --noinput
./manage.py makemigrations
./manage.py migrate
./manage.py add_mock_data
