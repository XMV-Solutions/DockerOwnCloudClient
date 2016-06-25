#!/bin/sh 

. /constants.sh
import_config

if ps ax | grep sync.s | grep ync.sh -q ; then
	echo "already running sync"
else
	owncloudcmd --silent --non-interactive -n --exclude $ocEXCLUDE $ocDATADIR $ocServerURL \
		> $ocLOGDIR/csync.log.`date -Iseconds` 2>&1
fi
