#!/bin/sh

ocVOLUME="/ownCloudVolume"
ocCONFIGFILE="$ocVOLUME/ownCloudConf.ini"
ocDATADIR="$ocVOLUME/ownCloudData/"
ocLOGDIR="$ocVOLUME/.ownCloudLog/"
ocEXCLUDE="$ocVOLUME/.sync-exclude.lst"

function import_config ()
{
	cat $ocCONFIGFILE | sed 's/ *= */=/g' > ${ocCONFIGFILE}.new
	mv ${ocCONFIGFILE}.new $ocCONFIGFILE 
	source $ocCONFIGFILE
}

export ocVOLUME ocCONFIGFILE ocDATADIR ocLOGDIR ocEXCLUDE