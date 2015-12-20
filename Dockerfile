FROM python:2.7.11

ENV SFTP_USER docker
ENV SFTP_PASS changeme
ENV PASS_ENCRYPTED false

# Install setuptools, pip and OpenSSH
RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install python-pip python-setuptools openssh-server && \
    rm -rf /var/lib/apt/lists/*

# sshd needs this directory to run
RUN mkdir -p /var/run/sshd

# Copy configuration and entrypoint script
COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
