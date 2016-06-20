#!/bin/sh 

ServerURL=`cat /ownCloudVolume/ownCloudConf/ServerURL`
export ServerURL

if ps ax | grep sync.s | grep ync.sh -q ; then
	echo "already running sync"
else
	owncloudcmd --silent --non-interactive -n --exclude /ownCloudVolume/ownCloudConf/sync-exclude.lst /ownCloudVolume/ownCloudData ${ServerURL} \
		> /ownCloudVolume/ownCloudLog/csync.log.`date -Iseconds` 2>&1
fi
