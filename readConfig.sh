#!/bin/sh

# CreateConfFiles
source /constants.sh

# Startup Config File
if [ ! -f $ocCONFIGFILE ] ; then
	# Copy Startup Config File
	cat /config.startup.ini > $ocCONFIGFILE
elif  [ ! "$(cat /config.sum 2>&1)" == "$(sha1sum $ocCONFIGFILE)" ] ; then 
	# When Configfile changed, trim " = " to "=" and save
	cat $ocCONFIGFILE | sed 's/ *= */=/g' > ${ocCONFIGFILE}.new
	mv ${ocCONFIGFILE}.new $ocCONFIGFILE 
	sha1sum $ocCONFIGFILE > /config.sum
fi 

# Test config
if /testconfig.sh ; then
	echo "config supported"
else
	echo "config failed"
	exit 1
fi

# Import Config
import_config

# Create Folders
mkdir -p $ocDATADIR
mkdir -p $ocLOGDIR

echo "$ocNetRCStyleLogin" > ~/.netrc

# sync-exclude.lst 
if [ ! -f $ocEXCLUDE  ] ; then
 cp /sync-exclude.lst $ocEXCLUDE
fi

# Install SyncCommand in CronTab
echo -e "${ocSyncCronPeriod} /sync.sh\n* * * * * /readConfig.sh" | crontab -

# Run crond once
if ps ax | grep cro | grep nd 2>&1 >/dev/null ; then 
	let x++	
else
	export x=1
	crond -f -d 8 &
fi

exit 0