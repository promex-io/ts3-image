#!/bin/bash

export TS3SERVER_LICENSE=accept

FN="/teamspeak3.tar.bz2"
VOLUME="/data"

if [ -z "$SID" ]; then
	echo "No SID set at runtime. Switching to use hostname..."
	export SID=`hostname`
fi

TSDIR="$VOLUME/$SID"

if [ ! -f "$TSDIR/.installed" ]; then
	echo "The server is not installed yet. Starting installation..."

	mkdir -p $TSDIR

	tar -xf $FN -C $TSDIR --strip-components=1

	touch $TSDIR/.installed
	touch $TSDIR/.ts3server_license_accepted

	echo "Installation has been completed. Starting the server."

	ARGS="serveradmin_password=$SID"
fi

cd $TSDIR && ./ts3server $ARGS


