#!/usr/bin/env bash

cd "$(dirname "$0")"
export WINEPREFIX=$(dirname "$0")
"/Applications/Wine Staging.app/Contents/Resources/wine/bin/wine64" "$(pwd)/drive_c/Program Files (x86)/Pokemon Uranium/Uranium.exe" &
exit

