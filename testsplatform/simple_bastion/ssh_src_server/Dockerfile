ARG VERSION
ARG REGISTRY
FROM ${REGISTRY}ssh_ubuntu_16:${VERSION}

RUN adduser --home /home/usr1 --force-badname --disabled-password usr1 \
    && mkdir /ftp/ \
    && chown usr1: /ftp/

RUN mkdir -m 0700 /home/usr1/.ssh/ \
    && mv /var/tmp/id_rsa.pub /home/usr1/.ssh/ \
    && cp /home/usr1/.ssh/id_rsa.pub /home/usr1/.ssh/authorized_keys \
    && chown -R usr1: /home/usr1/.ssh/

USER usr1
WORKDIR /home/usr1

ARG TO_DATE
ARG FROM_DATE
ARG SCRIPT

COPY --chown=usr1 ${SCRIPT} /tmp/datafilesGenerator.sh
RUN chmod +x /tmp/datafilesGenerator.sh \
    && /tmp/datafilesGenerator.sh ${FROM_DATE} ${TO_DATE}

USER root
EXPOSE 2222
CMD [ "/usr/sbin/sshd", "-D", "-p", "2222" ]
