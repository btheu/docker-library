#!/bin/sh

WORK_DIR=/opt/upchecker
LOG_FILE=/var/log/cron.log
FILE=$WORK_DIR/state.db

mkdir -p $WORK_DIR
touch $FILE

. $WORK_DIR/setenv.sh

remove_variable() {
  sed -i.bak "/^$1=/d" $FILE
}

get_variable() {
  cat $FILE | grep -w $1 | cut -d'=' -f2
}

set_variable() {
  remove_variable $1
  echo $1=$2 >> $FILE
  echo $2
}

send_mail(){

  local subject="$1"
  local body="$2"

  echo "$2" | mutt -s "$1" ${UPCHECKER_MAIL_TO} >> $LOG_FILE 2>&1

}


send_mail_down(){

  local nb_fails="$1"

  local subject="UpChecker: ${UPCHECKER_APPLICATION_NAME} is down ($nb_fails/${UPCHECKER_ALERT_THRESHOLD})"
  local body="
    Hi,
    
    It seems that the application ${UPCHECKER_APPLICATION_NAME} is down at ${UPCHECKER_APPLICATION_URL}.
    
    Regards,
  "

  send_mail "$subject" "$body"

}


send_mail_up(){

  local nb_fails="$1"

  local subject="UpChecker: ${UPCHECKER_APPLICATION_NAME} is back to normal"
  local body="
    Hi,
    
    The application ${UPCHECKER_APPLICATION_NAME} is back at ${UPCHECKER_APPLICATION_URL}.
    
    This is after $nb_fails consecutives fails.
    
    Regards,
  "

  send_mail "$subject" "$body"

}

log(){

  echo "$(date) $@"  >> $LOG_FILE 2>&1

}


log "Checking for application: ${UPCHECKER_APPLICATION_URL}"

NB_FAILS=$(get_variable "NB_FAILS")

if [ -z $NB_FAILS ]
then
  log "Create UpChecker database entry."
  NB_FAILS=$(set_variable "NB_FAILS" 0)
fi

wget -q -t 1 --timeout=${UPCHECKER_TIMEOUT_SEC:-10} ${UPCHECKER_APPLICATION_URL}
SUCCESS_CODE=$?

if [ $SUCCESS_CODE -eq 0 ]
then

  if [ $NB_FAILS -ne 0 ]
  then
    log "Application is back to normal"
    send_mail_up $NB_FAILS
    NB_FAILS=$(set_variable "NB_FAILS" 0)
    
  else
  
    log "Application seems ok"
    
  fi

else

  NB_FAILS=$(set_variable "NB_FAILS" $(( $NB_FAILS + 1 )) )

  if [ $NB_FAILS -le ${UPCHECKER_ALERT_THRESHOLD} ]
  then
    log "Application is down ($NB_FAILS/${UPCHECKER_ALERT_THRESHOLD}). Sending mail."
    send_mail_down $NB_FAILS

  else

    log "Application is down ($NB_FAILS/${UPCHECKER_ALERT_THRESHOLD})."

  fi
fi

















