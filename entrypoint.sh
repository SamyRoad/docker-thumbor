#!/bin/sh
if [ "$1" = 'thumbor' ]; then
    exec thumbor --port=8080 --conf=/home/thumbor/conf/thumbor.conf -k /home/thumbor/conf/thumbor.key >> /home/thumbor/app/thumbor.log
fi

exec "$@"
