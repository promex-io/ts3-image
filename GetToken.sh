#!/bin/bash

if [ -z "$SID" ]; then
	SID=`hostname`
fi

TSDIR="$TS_VOLUME/$SID"

if [ ! -f "$TSDIR/.installed" ]; then
	echo "The server is not installed yet. Install it first!" 1>&2
	exit 1
fi

TOKEN=`sqlite3 $TSDIR/ts3server.sqlitedb "SELECT token_key FROM tokens LIMIT 1"`

echo $TOKEN
