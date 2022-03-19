ARG VERSION
ARG REGISTRY
FROM ${REGISTRY}ssh_ubuntu_18:${VERSION}

RUN adduser --force-badname --disabled-password user

RUN mkdir -m 0700 /home/user/.ssh/ \
    && mv /var/tmp/id_rsa.pub /home/user/.ssh/authorized_keys \
    && chown -R user: /home/user/.ssh/

RUN mkdir -p /home/type2_provider1_techno1/flat_file \
        /home/type2_provider1_techno2/flat_file \
        /home/type2_provider1_techno2/flat_file \
        /home/type2_provider2_techno1/flat_file \
        /home/type2_provider2_techno2/flat_file \
        /home/type2_provider2_techno2/flat_file \
        /home/type1_provider1_techno1/flat_file \
        /home/type1_provider2_techno1/flat_file \
        /home/type1_provider2_techno2/flat_file \
        /home/type1_provider2_techno2/flat_file \
    && chown -R user: /home/*_*

EXPOSE 22222
CMD /usr/sbin/sshd -D -p 22222
