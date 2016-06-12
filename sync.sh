#!/bin/sh 

ServerURL=`cat /ownCloudVolume/ownCloudConf/ServerURL`
export ServerURL

owncloudcmd --silent --non-interactive -n --exclude /ownCloudVolume/ownCloudConf/sync-exclude.lst /ownCloudVolume/ownCloudData ${ServerURL} \
	> ownCloudVolume/ownCloudLog/csync.log.\`date -Iseconds\` 2>&1