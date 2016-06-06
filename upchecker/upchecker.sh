#!/bin/sh

if [ -z $NB_FAILS ]
then
  echo "Create NB FAILS variable"  >> /var/log/cron.log 2>&1
  export NB_FAILS=0
fi

export NB_FAILS=$(( $NB_FAILS + 1 ))

echo "NB FAILS: $NB_FAILS" >> /var/log/cron.log 2>&1
