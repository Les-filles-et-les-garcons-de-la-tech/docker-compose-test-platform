ARG VERSION
FROM testplatform/ssh_ubuntu_18:${VERSION}

ARG USER=user
ARG PORT=22222
RUN adduser --home /home/${USER} --force-badname --disabled-password ${USER}

RUN mkdir -m 0700 /home/${USER}/.ssh \
    && cp /var/tmp/id_rsa* /home/${USER}/.ssh \
    && chown -R ${USER}: /home/${USER}/.ssh

USER ${USER}
WORKDIR /home/${USER}
RUN cat .ssh/id_rsa.pub > .ssh/authorized_keys

USER root
RUN service ssh start
EXPOSE ${PORT}
ENV PORT=${PORT}
CMD /usr/sbin/sshd -D -p ${PORT}
