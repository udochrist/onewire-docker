FROM alpine

RUN apk add --no-cache owfs bash

COPY owfs.conf /etc/owfs.conf

COPY --chmod=0755 owfs-app.sh /app.sh
COPY --chmod=0755 owfs-healthcheck.sh /healthcheck.sh

# FTP
EXPOSE 2120/tcp
# HTTP
EXPOSE 2121/tcp
# SERVER
EXPOSE 4304/tcp

HEALTHCHECK --interval=2m --timeout=3s \
  CMD /bin/bash /healthcheck.sh || exit 1

ENTRYPOINT [ "/bin/bash", "/app.sh" ]