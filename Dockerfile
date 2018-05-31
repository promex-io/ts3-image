FROM bitnami/minideb:stretch
MAINTAINER Berkant Ipek <berkant@promex.io>

EXPOSE 9987/udp 30033 10011

ENV TS_VOLUME="/data" \
    TS_RELEASE="http://dl.4players.de/ts/releases/3.2.0/teamspeak3-server_linux_amd64-3.2.0.tar.bz2" \
    TS_ARCHIVE="/teamspeak3.tar.bz2" \
    TS3SERVER_LICENSE="accept" \
    LD_LIBRARY_PATH=".:"

RUN apt-get update -y
RUN apt-get install -y bzip2 ca-certificates sqlite3 wget curl htop
RUN wget "$TS_RELEASE" -O "$TS_ARCHIVE"

COPY Entrypoint.sh /
COPY GetToken.sh /

VOLUME $TS_VOLUME

CMD ["/Entrypoint.sh"]
