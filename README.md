# nginx-nodejs

## Example
Example is located in [`examples/hello-world`](examples/hello-world)

Your Workdir:
```
package.json
main.js
default.conf # NGINX Config
Dockerfile # See below
```

This is your Dockerfile:
```
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
```
> **Note:** For all other files please see [`examples/hello-world`](examples/hello-world) as mentioned above.

## Credits
Thanks to the lovely maintainer of
- [klokantech/supervisord](https://hub.docker.com/r/klokantech/supervisord)

## Donate `(who cares anyway?)`
Feel free to help me out during moving as I have to pay two rents (for two apartments) 
at the same time, for almost one and a half months starting 15. September 2020. Gah!

Every penny is appreciated. Thank you!

[Help me out via Paypal](https://paypal.me/robinrpr)

Cheers!
