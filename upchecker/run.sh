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

send_mail(){

  local subject="$1"
  local body="$2"

  echo "$2" | mutt -s "$1" ${UPCHECKER_MAIL_TO} >> /var/log/cron.log 2>&1

}


send_mail_start(){

  local subject="UpChecker: UpChecker is listening to ${UPCHECKER_APPLICATION_NAME}"
  local body="
    Hi,
    
    UpChecker is listening to ${UPCHECKER_APPLICATION_NAME} at ${UPCHECKER_APPLICATION_URL}.
    
    Regards,
  "

  send_mail "$subject" "$body"

}

send_mail_start

cron && tail -f /var/log/cron.log
