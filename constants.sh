#!/bin/sh

ocVOLUME="/ownCloudVolume"
ocCONFIGFILE="$VOLUME/ownCloudConf.ini"
ocDATADIR="$VOLUME/ownCloudData/"
ocLOGDIR="$VOLUME/.ownCloudLog/"
ocEXCLUDE="$VOLUME/.sync-exclude.lst"

function import_config()
{
	source <(grep = $ocCONFIGFILE | sed 's/ *= */=/g')
}

export ocVOLUME ocCONFIGFILE ocDATADIR ocLOGDIR ocEXCLUDE