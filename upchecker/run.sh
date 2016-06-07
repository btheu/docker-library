#!/bin/sh

echo "Initialize context..."

cat /opt/crontab | envsubst > /etc/cron.d/upcheck-cron

if [ ${UPCHECKER_DEBUG} = "yes" ]
then
  cat /etc/cron.d/upcheck-cron
fi


cat /opt/muttrc | envsubst > /root/.muttrc

if [ ${UPCHECKER_DEBUG} = "yes" ]
then
  cat /root/.muttrc
fi

cat /opt/setenv.sh | envsubst > /opt/upchecker/setenv.sh

if [ ${UPCHECKER_DEBUG} = "yes" ]
then
  cat /opt/upchecker/setenv.sh
fi

echo "Context OK"

cron && tail -f /var/log/cron.log
