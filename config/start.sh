#supervisord -c /etc/supervisord.conf
apachectl start
service cron start
crontab /crontabs/root
tail -f /dev/null