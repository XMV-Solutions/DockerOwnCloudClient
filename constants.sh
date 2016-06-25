#!/bin/sh

ocVOLUME="/ownCloudVolume"
ocCONFIGFILE="$ocVOLUME/ownCloudConf.ini"
ocDATADIR="$ocVOLUME/ownCloudData/"
ocLOGDIR="$ocVOLUME/.ownCloudLog/"
ocEXCLUDE="$ocVOLUME/.sync-exclude.lst"

import_config ()
{
	cat $ocCONFIGFILE | sed 's/ *= */=/g' > $ocCONFIGFILE
	source $ocCONFIGFILE
}

export ocVOLUME ocCONFIGFILE ocDATADIR ocLOGDIR ocEXCLUDE