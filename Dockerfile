FROM alpine

RUN apk update && apk add --no-cache owfs bash
RUN mkdir -p /mnt/1wire

VOLUME /config
COPY owfs.conf.template /etc/owfs.conf.template

COPY /rootfs/ /
RUN chmod +x /entrypoint.sh /healthcheck.sh


# FTP
EXPOSE 2120/tcp
# HTTP
EXPOSE 2121/tcp
# SERVER
EXPOSE 4304/tcp

HEALTHCHECK --interval=2m --timeout=3s \
  CMD /bin/bash /healthcheck.sh || exit 1

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]