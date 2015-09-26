#!/bin/bash

STEAM_COMMON=~/.steam/steam/steamapps/common/
SBDF9_BACKUP=~/.local/share/doublefine/spacebasedf9/Saves/

if [ "$1" = "restore" ]; then
    if [ ! -d ${STEAM_COMMON}/SpacebaseDF9.v1 ]; then
	echo "Missing original version of game to be restored"
	echo "Try manually re-installing through Steam"
    else
	rm -rf ${STEAM_COMMON}/SpacebaseDF9
	mv ${STEAM_COMMON}/SpacebaseDF9.v1 ${STEAM_COMMON}/SpacebaseDF9
    fi
    exit
fi

## Backup if needed
if [ ! -e ${STEAM_COMMON}/SpacebaseDF9.v1 ]; then
    echo "Backing up original SpacebaseDF9 code and game save"
    rsync -avz ${STEAM_COMMON}/SpacebaseDF9/ ${STEAM_COMMON}/SpacebaseDF9.v1
fi
if [ ! -e ${SBDF9_BACKUP}/Archives/SpacebaseDF9AutoSave-v1.sav ]; then
    mkdir -p ${SBDF9_BACKUP}/Archives
    rsync -avz ${SBDF9_BACKUP}/SpacebaseDF9AutoSave.sav ${SBDF9_BACKUP}/Archives/SpacebaseDF9AutoSave-v1.sav 
fi

rsync -avz build.string ${STEAM_COMMON}/SpacebaseDF9/Data/
rsync -avz Dialog ${STEAM_COMMON}/SpacebaseDF9/Data/
rsync -avz Scripts ${STEAM_COMMON}/SpacebaseDF9/Data/
rsync -avz UILayouts ${STEAM_COMMON}/SpacebaseDF9/Data/


