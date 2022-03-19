ARG VERSION
ARG REGISTRY
FROM ${REGISTRY}ssh_ubuntu_18:${VERSION}

ARG USER=regusr
RUN adduser --force-badname --disabled-password ${USER}
RUN mkdir /TYPE2 /TYPE3 /TYPE1 \
    && chown ${USER}: /TYPE2 /TYPE3 /TYPE1

WORKDIR /home/${USER}/
RUN mkdir -p -m 0700 .ssh/ \
    && mv /var/tmp/id_rsa.pub .ssh/authorized_keys \
    && chown -R ${USER}: .

EXPOSE 22
CMD /usr/sbin/sshd -D
