#!/bin/sh

delimiter=","
with_prefix=" --with "
arguments=""

if [ ! -z $XCADDY_ARGUMENTS ]; then
    arguments=$(echo "$XCADDY_ARGUMENTS" | sed "s/$delimiter/$with_prefix/g")
    arguments="$with_prefix$arguments"
fi

eval "xcaddy build $arguments"

chmod +x caddy
