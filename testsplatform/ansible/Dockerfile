ARG VERSION
FROM alpine:${VERSION}

RUN apk update && apk add bash ansible=4.8.0-r0 openssh-client

RUN adduser --home /home/ansible --shell /bin/bash ansible -D

USER ansible
WORKDIR /home/ansible
RUN mkdir -p -m 0700 ~/.ssh/
COPY --chown=ansible id_rsa id_rsa.pub .ssh/
RUN cp .ssh/id_rsa.pub .ssh/authorized_keys

ENTRYPOINT ["ansible-playbook", "-e", "test_mode=true"]
