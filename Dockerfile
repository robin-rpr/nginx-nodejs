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

# Add files
#supervisor
ADD nginx-nodejs.conf /etc/supervisor/conf.d/nginx-nodejs.conf

# Run
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"
