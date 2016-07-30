#!/bin/sh
export ORIGPASSWD=$(cat /etc/passwd | grep thumbor)
export ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
export ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)

export DOCKER_UID=${DOCKER_UID:=$ORIG_UID}
export DOCKER_GID=${DOCKER_GID:=$ORIG_GID}

ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)

sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$DOCKER_UID:$DOCKER_GID:/" /etc/passwd
sed -i -e "s/thumbor:x:$ORIG_GID:/thumbor:x:$DOCKER_GID:/" /etc/group

chown -R ${DOCKER_UID}:${DOCKER_GID} ${ORIG_HOME}

if [ "$1" = 'thumbor' ]; then
  sudo -u thumbor -H sh -c "cd /home/thumbor/app; \
    thumbor --port=8080 --conf=/home/thumbor/conf/thumbor.conf -k /home/thumbor/conf/thumbor.key 2>&1"
fi

sudo -u thumbor -H sh -c "cd /home/thumbor/app; $@"
