FROM robinrpr/nginx-nodejs:latest

# Create your Working directory
RUN mkdir -p /home/app
WORKDIR /home/app

# Copy all
COPY --chown=root:root . .

# Npm Install
RUN npm i

# Update NGINX Config
RUN mv default.conf /etc/nginx/conf.d/default.conf

# Append to Supervisord Config
RUN echo '[program:nodejs]\n\
directory=/home/app\n\
command=node main.js\n'\
>> /etc/supervisor/conf.d/nginx-nodejs.conf

# (optional)
EXPOSE 4000

# Start all
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
