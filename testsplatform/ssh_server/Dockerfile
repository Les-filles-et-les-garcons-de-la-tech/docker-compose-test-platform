ARG VERSION
FROM ubuntu:${VERSION}

RUN apt-get update \
	&& apt-get -y install bash openssh-server

COPY id_rsa* /var/tmp/

RUN service ssh start
EXPOSE 22
CMD /usr/sbin/sshd -D
