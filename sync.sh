#!/bin/sh 

source /constants.sh
import_config

if ps ax | grep owncl | grep oudcmd -q ; then
	echo "already running sync"
else
	echo -en "starting sync at $(date -Iseconds) - "
	
	today=$(date -I)
	yesterday=$(date -I -d @"$(( $(date +%s) - 86400 ))" )
	
	# Backup yesterdays logs, make logfolder for today
	if [ ! -f $ocLOGDIR/$today ] ; then
		mkdir -p $ocLOGDIR/$today
		if [ -f $ocLOGDIR/${yesterday} ] ; then
			tar cjf  $ocLOGDIR/${yesterday}.tbz  $ocLOGDIR/${yesterday} 2>&1 > /dev/null || echo "No logs saved from yesterday"
			rm -rf  $ocLOGDIR/${yesterday} 2>&1 > /dev/null || echo "No logs removed from yesterday"
		fi
	fi
	
	owncloudcmd --silent --non-interactive -n --exclude $ocEXCLUDE $ocDATADIR $ocServerURL \
		> $ocLOGDIR/$today/csync.log.`date -Iseconds` 2>&1

	echo "sync finished $(date -Iseconds)"
fi

exit 0
