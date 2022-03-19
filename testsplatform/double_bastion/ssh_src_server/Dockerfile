ARG VERSION
ARG REGISTRY
FROM ${REGISTRY}ssh_ubuntu_16:${VERSION}

ARG USER=usr1
RUN adduser --home /home/${USER}/ --force-badname --disabled-password ${USER} \
    && mkdir /ftp/ \
    && chown ${USER}: /ftp/

WORKDIR /home/${USER}
RUN mkdir -m 0700 .ssh/ \
    && mv /var/tmp/id_rsa.pub .ssh/ \
    && mv .ssh/id_rsa.pub .ssh/authorized_keys \
    && chown -R ${USER}: .ssh/

USER ${USER}

ARG TO_DATE
ARG FROM_DATE
ARG SCRIPT

COPY --chown=${USER} ${SCRIPT} /tmp/datafilesGenerator.sh
RUN chmod +x /tmp/datafilesGenerator.sh \
    && /tmp/datafilesGenerator.sh ${FROM_DATE} ${TO_DATE}

USER root
EXPOSE 22
ENTRYPOINT [ "/usr/sbin/sshd", "-D", "-p", "22" ]
