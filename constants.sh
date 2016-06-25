#!/bin/sh

ocVOLUME="/ownCloudVolume"
ocCONFIGFILE="$ocVOLUME/ownCloudConf.ini"
ocDATADIR="$ocVOLUME/ownCloudData/"
ocLOGDIR="$ocVOLUME/.ownCloudLog/"
ocEXCLUDE="$ocVOLUME/.sync-exclude.lst"

import_config ()
{

	if [ $DEBUG ] ; then
		echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		echo ConfigFile
		cat $ocCONFIGFILE 
	fi

	cat $ocCONFIGFILE | sed 's/ *= */=/g' > ${ocCONFIGFILE}.new

	if [ $DEBUG ] ; then
		echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		echo ConfigFile-New
		cat ${ocCONFIGFILE}.new
	fi
	

	mv ${ocCONFIGFILE}.new $ocCONFIGFILE 
	source $ocCONFIGFILE
	
}

export ocVOLUME ocCONFIGFILE ocDATADIR ocLOGDIR ocEXCLUDE
