export APP_ROOT_DIR=/home/root/cytovale-sw
export PYTHONPATH=${APP_ROOT_DIR}/cytovale_app/:${APP_ROOT_DIR}/cytovale_app/cytovale_django
export PYTHONUNBUFFERED=1

cd ${APP_ROOT_DIR}/cytovale_app

echo "Running"

while true; do
  systemd-notify READY=1
  sleep 60
done
