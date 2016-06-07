FROM ubuntu:latest

MAINTAINER Benoit Theunissen <benoit.theunissen@gmail.com>
 
RUN apt-get update && apt-get -y install nano cron gettext mutt at curl wget

WORKDIR /opt/upchecker

RUN touch /var/log/cron.log

CMD /opt/upchecker/run.sh

ADD crontab /opt

ADD muttrc /opt

ADD setenv.sh /opt

ADD run.sh /opt/upchecker

ADD upchecker.sh /opt/upchecker



## Add crontab file in the cron directory
#ADD crontab /etc/cron.d/upcheck-cron
#
## Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/upcheck-cron
#
## Create the log file to be able to run tail
#RUN touch /var/log/cron.log
# 
## Run the command on container startup
#CMD cron && tail -f /var/log/cron.log
#
#WORKDIR /opt
#
## Add crontab file in the cron directory
#ADD upchecker.sh /opt/
#
#RUN chmod +x /opt/upchecker.sh
#
#ADD muttrc /root/.muttrc
