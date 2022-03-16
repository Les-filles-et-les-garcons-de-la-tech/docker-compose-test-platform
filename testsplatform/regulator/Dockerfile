ARG VERSION
FROM testplatform/ssh_ubuntu_18:${VERSION}

RUN adduser --force-badname --disabled-password arpt
RUN mkdir /ORANGE /TYPE3 /TYPE1 \
    && chown arpt: /ORANGE /TYPE3 /TYPE1

USER arpt
WORKDIR /home/arpt
RUN mkdir -p -m 0700 .ssh
RUN cat /var/tmp/id_rsa.pub > .ssh/authorized_keys

USER root
RUN service ssh start
EXPOSE 22
CMD /usr/sbin/sshd -D
