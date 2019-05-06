export APP_ROOT_DIR=/home/root/cytovale-sw
export PYTHONPATH=${APP_ROOT_DIR}/cytovale_app/:${APP_ROOT_DIR}/cytovale_app/cytovale_django
export PYTHONUNBUFFERED=1
export CYM_HORIZONTAL_FLIP=True

cd ${APP_ROOT_DIR}/cytovale_app

python3 cytovale_django/manage.py migrate
python3 cytovale_django/manage.py runserver 0.0.0.0:8000 &

# TODO: Test if server is still running

touch /tmp/cym-webserver-running

while true; do
  systemd-notify READY=1
  sleep 60
done


