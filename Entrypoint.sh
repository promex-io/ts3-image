#!/bin/bash

if [ -z "$SID" ]; then
	echo "No SID set at runtime. Switching to use hostname..."
	export SID=`hostname`
fi

echo "SID: $SID"

TSDIR="$TS_VOLUME/$SID"

if [ ! -f "$TSDIR/.installed" ]; then
	echo "The server is not installed yet. Starting installation..."

	mkdir -p $TSDIR

	tar -xf $TS_ARCHIVE -C $TSDIR --strip-components=1

	touch $TSDIR/.installed
	touch $TSDIR/.ts3server_license_accepted

	echo "Installation has been completed. Starting the server."

	if [ -z "$SERVERADMIN_PASS" ]; then
		echo "No Serveradmin pass set at runtime. Creating the MD5 sum of \$SID by default."

		export SERVERADMIN_PASS=`echo $SID | md5sum | cut -d ' ' -f 1`
	fi

	echo "Serveradmin Password: $SERVERADMIN_PASS"

	ARGS="serveradmin_password=$SERVERADMIN_PASS"
fi

cd $TSDIR

# Run some cleanup
rm -rf CHANGELOG LICENSE doc/ libts3db_mariadb.so redist/ serverquerydocs/ tsdns/

./ts3server $ARGS
