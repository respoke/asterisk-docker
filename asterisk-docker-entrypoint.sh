#!/bin/bash
set -e

# Process templates
find /etc/asterisk -name '*.j2' | while read template; do
    # replace templated values with environment variables of the same name
    j2 ${template} > /etc/asterisk/$(basename ${template} .j2)
    # remove the template once processed
    rm -f ${template}
done

exec "$@"
