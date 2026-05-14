FROM alpine

LABEL org.opencontainers.image.source=https://github.com/udochrist/onewire-docker
LABEL org.opencontainers.image.description="OneWire File System (OWFS) in a Docker container for Home Assistant"
LABEL org.opencontainers.image.title="OneWire File System (OWFS) Docker Image"
LABEL org.opencontainers.image.licenses=MIT


RUN apk update && apk add --no-cache owfs bash fuse
RUN mkdir -p /mnt/1wire

VOLUME /config

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
