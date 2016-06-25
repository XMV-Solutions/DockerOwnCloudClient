#!/bin/sh 

source /constants.sh
import_config

if ps ax | grep owncl | grep oudcmd -q ; then
	echo "already running sync"
else
	echo -en "starting sync at $(date -Iseconds) --> "

	owncloudcmd --silent --non-interactive -n --exclude $ocEXCLUDE $ocDATADIR $ocServerURL \
		> $ocLOGDIR/csync.log.`date -Iseconds` 2>&1

	echo "sync finished"
fi

exit 0