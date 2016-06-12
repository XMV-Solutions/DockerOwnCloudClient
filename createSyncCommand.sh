#!/bin/sh

# CreateConfFiles & ConfVars
mkdir -p /ownCloudVolume/.owncloudConf/
mkdir -p /ownCloudVolume/ownCloudData/
mkdir -p /ownCloudVolume/.ownCloudLog/

# ServerAddress
if [ ! -f /ownCloudVolume/.owncloudConf/ServerURL ] ; then
 echo "https://owncloud." > /ownCloudVolume/.owncloudConf/ServerURL
fi
ServerURL=`cat /ownCloudVolume/.owncloudConf/ServerURL`

# SyncPeriod
if [ ! -f /ownCloudVolume/.owncloudConf/SyncCronPeriod ] ; then
 echo "*/5 * * * *" > touch /ownCloudVolume/.owncloudConf/SyncCronPeriod
fi
SyncCronPeriod=`cat /ownCloudVolume/.owncloudConf/SyncCronPeriod`

# Credentials
if [ ! -f /ownCloudVolume/.owncloudConf/netrcStyleConf ] ; then
 echo "default login [yourOwncloudUserName] password [yourOwncloudUserPassword]" > touch /ownCloudVolume/.owncloudConf/netrcStyleConf
fi
if [ ! -f ~/.netrc ] ; then
	ln -s /ownCloudVolume/.owncloudConf/netrcStyleConf ~/.netrc
fi

# /sync-exclude.lst 
if [ ! -f /ownCloudVolume/.owncloudConf/sync-exclude.lst  ] ; then
 cp /sync-exclude.lst /ownCloudVolume/.owncloudConf/sync-exclude.lst
fi


echo "ServerURL: ${ServerURL}"
echo "SyncCronPeriod: ${SyncCronPeriod}"
echo "netrcStyleConf: $(cat ~/.netrc)"

# Install SyncCommand in CronTab
echo "${SyncCronPeriod} owncloudcmd --silent --non-interactive -n --exclude /ownCloudVolume/.owncloudConf/sync-exclude.lst /ownCloudVolume/ownCloudData ${ServerURL} \
	> ownCloudVolume/.ownCloudLog/csync.log.\`date -Iseconds\` 2>&1" \
	| crontab -

crond -f -d 8