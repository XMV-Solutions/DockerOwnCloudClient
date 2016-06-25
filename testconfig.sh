#!/bin/sh

. constants.sh
import_config

if [ $DEBUG ] ; then
	echo -en "SyncCronPeriod: ${ocSyncCronPeriod} / "
	echo -en "ServerURL: ${ocServerURL} / "
	echo -en "NetRCStyleLogin: ${ocNetRCStyleLogin} / "
	echo "Ran $x times"
fi

if [ ! $ocServerURL ] ; then
	echo "ServerURL is missing"
	exit 1
fi

if [ ! $SyncCronPeriod ] ; then
	echo "SyncCronPeriod is missing"
	exit 2
fi

if [ ! $ocNetRCStyleLogin ] ; then
	echo "NetRCStyleLogin is missing"
	exit 3
fi

exit 0