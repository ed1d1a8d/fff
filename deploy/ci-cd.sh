while true; do git pull; python manage.py createstatic --no-input; python manage.py makemigrations; python manage.py migrate; sleep 30; done
