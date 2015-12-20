docker-pycharm-python
====

Easy to use and [Docker Compose](https://docs.docker.com/compose/) compatible Python development box to be used with [PyCharm (JetBrains)](https://www.jetbrains.com/pycharm/). 
This box is NOT meant to be used in production. It comes with SSH/SFTP for PyCharm access.

For me this was a test to see if docker could be used as a "vagrant replacement" especially when it comes down to 
running unit tests and debugging from PyCharm IDE. So far it looks promising...

Note: SSH/SFTP User and Password implementation is based on [atmoz/sftp](https://registry.hub.docker.com/u/atmoz/sftp), 
but changed to use ENV variables for Docker Compose support.

Usage
-----

Best used with [Docker Compose](https://docs.docker.com/compose/).

Example
--------

Dockerfile

```
# Pull base image.
FROM yograterol/docker-pycharm-python

# copy application to image
ADD . /data/
WORKDIR /data

# If needed:
# install any python requirements found in requirements.txt (this file must be in root path of your app)
RUN pip install -r requirements.txt
```

Configuration for Docker Compose (docker-compose.yml) 

```
web:
  build: .
  command: python app.py
  ports:
   - "8080:8080"
   - "2222:22"
  volumes:
   - .:/data
  environment:
    SFTP_USER: docker
    SFTP_PASS: docker
  links:
   - db
db:
  image: postgres
```

This samples a web server app (app.py) running on port 8080. PyCharm will be able to access the docker image with the
given user and on port 2222. If you do not want to store your password in plain text, you can use the 
Environment Variable "PASS_ENCRYPTED: true" to create the user with the already encrypted password.  
