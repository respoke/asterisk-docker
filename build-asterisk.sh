#!/bin/bash

PROGNAME=$(basename $0)

if test -z ${ASTERISK_VERSION}; then
    echo "${PROGNAME}: ASTERISK_VERSION requires" >&2
    exit 1
fi

# 1.5 jobs per core works out okay
: ${JOBS:=$(( $(nproc) + $(nproc) / 2 ))}

set -ex

mkdir -p /usr/src/asterisk
cd /usr/src/asterisk

curl -vsL http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz |
    tar --strip-components 1 -xz

./configure 
make menuselect/menuselect menuselect-tree menuselect.makeopts

# MOAR SOUNDS
for i in CORE-SOUNDS-EN MOH-OPSOUND EXTRA-SOUNDS-EN; do
    for j in ULAW ALAW G722 GSM SLN16; do
        menuselect/menuselect --enable $i-$j menuselect.makeopts
    done
done

make -j ${JOBS} all
make install
chown -R asterisk:asterisk /var/*/asterisk
chmod -R 750 /var/spool/asterisk
mkdir -p /etc/asterisk/
cp /usr/src/asterisk/configs/basic-pbx/*.conf /etc/asterisk/

# Set runuser and rungroup
sed -i -E 's/^;(run)(user|group)/\1\2/' /etc/asterisk/asterisk.conf

cd /
exec rm -rf /usr/src/asterisk
