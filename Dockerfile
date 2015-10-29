# -*- Dockerfile -*-

FROM chadxz/pjsip-docker:latest 
MAINTAINER David M. Lee, II <dlee@respoke.io>

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --system asterisk

RUN apt-get update -qq && \
    apt-get install -y \
            build-essential \
            curl \
            doxygen \
            freetds-dev \
            libbluetooth-dev \
            libcurl4-openssl-dev \
            libedit-dev \
            libgsm1-dev \
            libgtk2.0-dev \
            libiksemel-dev \
            libjansson-dev \
            liblua5.1-0-dev \
            libneon27-dev \
            libnewt-dev \
            libogg-dev \
            libpq-dev \
            libfreeradius-client-dev \
            libsnmp-dev \
            libspeex-dev \
            libspeexdsp-dev \
            libsqlite0-dev \
            libsqlite3-dev \
            libsrtp0-dev \
            libssl-dev \
            libusb-dev \
            libvpb-dev \
            libxml2-dev \
            libxslt1-dev \
            lua5.1 \
            uuid \
            uuid-dev \
            binutils-dev \
            libcorosync-dev \
            libical-dev \
            libmysqlclient-dev \
            libpopt-dev \
            libspandsp-dev \
            libvorbis-dev \
            portaudio19-dev \
            unixodbc-dev \
            && \
    apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*

ENV ASTERISK_VERSION=13.5.0
COPY build-asterisk.sh /build-asterisk
RUN /build-asterisk && rm -f /build-asterisk

CMD ["/usr/local/sbin/asterisk", "-f"]
