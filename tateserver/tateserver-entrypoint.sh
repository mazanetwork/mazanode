#!/bin/sh -x
set -e
APP=tate-server
USER=${USER:-maza}
echo "Starting ${APP}"
cd /app

if [ -d /home/${USER} ] ; then
   chown -R ${USER} /home/${USER}
fi
chmod +x /app/start.sh
chown -R ${USER} /app
touch /var/log/tate.log
chown ${USER} /var/log/tate.log
chown -R ${USER} /var/tate-server
chown ${USER} /etc/tate.conf
chown ${USER} /app/tateserver.env
exec /app/start.sh
