ARG VERSION
FROM ubuntu:${VERSION}

RUN apt-get update \
	&& apt-get -y install bash openssh-server

COPY id_rsa* /var/tmp/
RUN chmod 600 /var/tmp/id_rsa

RUN mkdir -p /run/sshd/ \
	&& systemctl enable ssh

EXPOSE 22
CMD /usr/sbin/sshd -D
