#!/bin/sh

ocVOLUME="/ownCloudVolume"
ocCONFIGFILE="$VOLUME/ownCloudConf.ini"
ocDATADIR="$VOLUME/ownCloudData/"
ocLOGDIR="$VOLUME/.ownCloudLog/"
ocEXCLUDE="$VOLUME/.sync-exclude.lst"

function import_config()
{
	cat $ocCONFIGFILE | sed 's/ *= */=/g' > $ocCONFIGFILE
	source $ocCONFIGFILE
}

export ocVOLUME ocCONFIGFILE ocDATADIR ocLOGDIR ocEXCLUDE