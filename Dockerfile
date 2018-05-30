FROM bitnami/minideb:stretch
MAINTAINER Berkant Ipek <berkant@promex.io>

WORKDIR /data

ENV LD_LIBRARY_PATH=".:"
ARG DL_URL="http://dl.4players.de/ts/releases/3.2.0/teamspeak3-server_linux_amd64-3.2.0.tar.bz2"

RUN apt-get update -y
RUN apt-get install -y bzip2 ca-certificates uuid-runtime sqlite3

ADD $DL_URL /teamspeak3.tar.bz2
COPY Entrypoint.sh /
COPY GetDefaultToken.sh /

# Voice Server
EXPOSE 9987/udp
# File Server
EXPOSE 30033/tcp
# Server Query
EXPOSE 10011/tcp

CMD ["/Entrypoint.sh"]
