while true; do git fetch; git reset --hard origin/production; python manage.py createstatic --no-input; python manage.py makemigrations; python manage.py migrate; sleep 30; done
