From ubuntu:trusty
MAINTAINER "Robin Roeper <rr@linux.com>"

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

RUN apt-get -y install supervisor software-properties-common logrotate curl

# Install Node.js Latest
RUN curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash - \
 && sudo apt-get install -y nodejs
 
# Install Nginx Stable
RUN add-apt-repository ppa:nginx/stable && apt-get update \
 && apt-get -y install nginx-full \
 && echo "daemon off;" >> /etc/nginx/nginx.conf

# Create Supervisord Log
RUN mkdir -p /var/log/supervisord
RUN touch /tmp/supervisord.log

# Supply Config file
RUN echo '[supervisord]\n\
nodaemon=true\n\
childlogdir=/var/log/supervisord/\n\
logfile=/tmp/supervisord.log\n\
[program:nginx]\n\
command=/usr/sbin/nginx -c /etc/nginx/nginx.conf\n\
[program:rsyslog]\n\
command=/usr/sbin/rsyslogd -n -c3\n\
[program:cronjob]\n\
command=/usr/sbin/cron -f\n'\
>> /etc/supervisor/conf.d/nginx-nodejs.conf

# Start Supervisord
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
