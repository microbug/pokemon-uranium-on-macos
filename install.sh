#!/usr/bin/env bash

write_red_bold () {
    printf "\\033[00;31m\\033[1m%s\\033[0m\\n" "$1"
}

write_bold () {
    printf "\\033[1m%b\\033[0m\\n" "$1"
}

write_bold "Unofficial Pokémon Uranium Wine Installation Tool"
write_bold "For instructions for this tool go to https://github.com/microbug/pokemon-uranium-on-macos"

if [ -d "$HOME/pokemon_uranium" ]; then
    write_red_bold "Error: ~/pokemon_uranium already exists, please move or delete it before continuing"
    exit 1
fi

if [ -x "$(command -v brew)" ]; then
    write_bold "\\n====> STEP 1"
    write_bold "Homebrew is already installed! Good for you, Homebrew is awesome."
else
    write_bold "\\n====> STEP 1"
    write_bold "Homebrew not installed, installing..."
    write_red_bold "Accept all prompts and provide your password when it's asked for"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

write_bold "\\n====> STEP 2"
write_bold "Updating Homebrew"
brew update

write_bold "\\n====> STEP 3"
write_bold "Tapping caskroom"
brew tap caskroom/cask

write_bold "\\n====> STEP 4"
write_bold "Tapping caskroom/versions"
brew tap caskroom/versions

write_bold "\\n====> STEP 5"
write_bold "Installing XQuartz"
brew cask install caskroom/cask/xquartz

write_bold "\\n====> STEP 6"
write_bold "Installing Wine Staging"
brew cask install caskroom/versions/wine-staging

write_bold "\\n====> STEP 7"
write_bold "Installing Winetricks"
brew install winetricks

write_bold "\\n====> STEP 8"
write_bold "\\nCreating virtual Windows installation at ~/pokemon_uranium"
write_red_bold "Remember to accept all prompts to install Mono and/or Gecko"
write_bold "Lots of Wine logs (may look like nonsense) coming up..."
export PATH=$PATH:"/Applications/Wine Staging.app/Contents/Resources/wine/bin/"
mkdir ~/pokemon_uranium
export WINEPREFIX=~/pokemon_uranium
cd $WINEPREFIX || exit
wineboot
winetricks directplay directmusic dsound d3dx9_43 ddr=opengl macdriver=x11 win10 devenum dmsynth quartz
# Remove cache files
rm -rf ~/.cache/wine ~/.cache/winetricks
sleep 5  # Let Wine finish spewing logs

write_bold "\\n====> STEP 9"
write_bold "\\nAdding game start script"
curl -s -O "$HOME/pokemon_uranium/Run Pokémon Uranium.command" "https://raw.githubusercontent.com/microbug/pokemon-uranium-on-macos/master/run.sh"

write_bold "\\nDone, now REBOOT and check the guide on GitHub for next steps"

