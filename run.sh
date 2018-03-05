#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd "$SCRIPTPATH"
export WINEPREFIX="$SCRIPTPATH"
"/Applications/Wine Staging.app/Contents/Resources/wine/bin/wine64" "$(pwd)/drive_c/Program Files (x86)/Pokemon Uranium/Uranium.exe" &
exit

