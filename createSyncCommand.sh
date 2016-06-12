#!/bin/sh

# CreateConfFiles & ConfVars
mkdir -p /ownCloudVolume/.ownCloudConf/
mkdir -p /ownCloudVolume/ownCloudData/
mkdir -p /ownCloudVolume/.ownCloudLog/

# ServerAddress
if [ ! -f /ownCloudVolume/.ownCloudConf/ServerURL ] ; then
 echo "https://owncloud." > /ownCloudVolume/.ownCloudConf/ServerURL
fi
ServerURL=`cat /ownCloudVolume/.ownCloudConf/ServerURL`
export ServerURL

# SyncPeriod
if [ ! -f /ownCloudVolume/.ownCloudConf/SyncCronPeriod ] ; then
	# Standard is one check every 5 minutes
 	echo "*/5 * * * *" > /ownCloudVolume/.ownCloudConf/SyncCronPeriod
fi
SyncCronPeriod=`cat /ownCloudVolume/.ownCloudConf/SyncCronPeriod`
export SyncCronPeriod

# Credentials
if [ ! -f /ownCloudVolume/.ownCloudConf/netrcStyleConf ] ; then
 echo "default login [yourOwncloudUserName] password [yourOwncloudUserPassword]" > /ownCloudVolume/.ownCloudConf/netrcStyleConf
fi
if [ ! -f ~/.netrc ] ; then
	ln -s /ownCloudVolume/.ownCloudConf/netrcStyleConf ~/.netrc
fi

# /sync-exclude.lst 
if [ ! -f /ownCloudVolume/.ownCloudConf/sync-exclude.lst  ] ; then
 cp /sync-exclude.lst /ownCloudVolume/.ownCloudConf/sync-exclude.lst
fi

echo -en "SyncCronPeriod: ${SyncCronPeriod} "
echo -en "ServerURL: ${ServerURL} "
echo "netrcStyleConf: $(cat ~/.netrc) "

owncloudcmd --silent --non-interactive -n --exclude /ownCloudVolume/.ownCloudConf/sync-exclude.lst /ownCloudVolume/ownCloudData ${ServerURL} \
	> ownCloudVolume/.ownCloudLog/csync.log.\`date -Iseconds\` 2>&1

# Install SyncCommand in CronTab
echo "${SyncCronPeriod} /createSyncCommand.sh" | crontab -

# Run crond once
if ps ax | grep cro | grep nd 2>&1 >/dev/null ; then 
	let x++	
else
	x=1 
	crond -f -d 8
fi