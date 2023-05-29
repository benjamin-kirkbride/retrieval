#!/bin/sh

echo starting
tailwindcss -i social/static/css/style.css -o social/static/css/output.css --minify
python manage.py collectstatic --noinput
python manage.py migrate
python manage.py createsuperuser --no-input
gunicorn social.wsgi --config="docker/gunicorn.conf.py"