
# UP CHECKER

Docker image providing a simple monitoring for checking if a distant service is still responding.
An email is sent if an service does not respond or if it's taking too long for responding.

A compose file looks like:

    version: '2'
    
    services:
    
      upchecker:
        image: btheu/upchecker
        environment:
        - "UPCHECKER_IMAP_HOST=imap.gmail.com"
        - "UPCHECKER_IMAP_PORT=993"
        - "UPCHECKER_IMAP_USER=example@gmail.com"
        - "UPCHECKER_IMAP_PASS=mysecret"
        
        - "UPCHECKER_SMTP_HOST=smtp.gmail.com"
        - "UPCHECKER_SMTP_PORT=387"
        - "UPCHECKER_SMTP_USER=example@gmail.com"
        - "UPCHECKER_SMTP_PASS=mysecret"
        
        - "UPCHECKER_MAIL_FROM=no-reply.example@gmail.com"
        - "UPCHECKER_MAIL_TO=supervisor.aware@gmail.com"
        - "UPCHECKER_APPLICATION_NAME=My Unstable APP"
        - "UPCHECKER_APPLICATION_URL=http://192.168.0.1:8080/app1/" # the URL to test
        - "UPCHECKER_ALERT_THRESHOLD=3"
        - "UPCHECKER_TIMEOUT_SEC=5" # 5 secondes
        - "UPCHECKER_CRON=*/2 * * * *" # checks every 2 minutes
        - "UPCHECKER_DEBUG=yes"
      volumes:
       - /etc/localtime:/etc/localtime:ro

