#!/usr/bin/env bash

write_red_bold () {
    printf "\\033[00;31m\\033[1m%s\\033[0m\\n" "$1"
}

write_bold () {
    printf "\\033[1m%b\\033[0m\\n" "$1"
}

print_step () {
    printf "\\n\\033[31m\\033[1m##### OVERALL INSTALLATION STEP %s #####\\033[0m\\n" "$1"
}

write_bold "Unofficial Pokémon Uranium Wine Installation Tool"
write_bold "For instructions for this tool please go to https://github.com/microbug/pokemon-uranium-on-macos"

if [ -d "$HOME/pokemon_uranium" ]; then
    write_red_bold "Error: ~/pokemon_uranium already exists, please move or delete it before continuing"
    exit 1
fi

print_step 1
if [ -x "$(command -v brew)" ]; then
    write_bold "Homebrew is already installed! Good for you, Homebrew is awesome."
else
    write_bold "Homebrew not installed, installing now"
    write_red_bold "Accept all prompts and provide your password when it's asked for"
    HOMEBREW_INSTALL_SCRIPT=$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install) || exit 1
    /usr/bin/ruby -e "$HOMEBREW_INSTALL_SCRIPT"
    brew analytics off
fi

print_step 2
write_bold "Updating Homebrew"
brew update

print_step 3
write_bold "Tapping caskroom"
brew tap caskroom/cask

print_step 4
write_bold "Tapping caskroom/versions"
brew tap caskroom/versions

print_step 5
write_bold "Installing XQuartz"
brew cask install caskroom/cask/xquartz

print_step 6
write_bold "Installing Wine Staging"
brew cask install caskroom/versions/wine-staging

print_step 7
write_bold "Installing Winetricks"
brew install winetricks

print_step 8
write_bold "Creating virtual Windows installation at ~/pokemon_uranium"
write_red_bold "Remember to accept all prompts to install Mono and/or Gecko, you may be asked several times"
write_bold "Lots of Wine logs (may look like nonsense) coming up..."
export PATH=$PATH:"/Applications/Wine Staging.app/Contents/Resources/wine/bin/"
mkdir ~/pokemon_uranium
export WINEPREFIX=~/pokemon_uranium
cd $WINEPREFIX || exit
wineboot
winetricks directplay directmusic dsound d3dx9_43 ddr=opengl macdriver=x11 win10 devenum dmsynth quartz
sleep 5  # Let Wine finish spewing logs

print_step 9
write_bold "Adding game start script"
curl -s -o "$HOME/pokemon_uranium/Run Pokémon Uranium.command" "https://raw.githubusercontent.com/microbug/pokemon-uranium-on-macos/master/run.sh"

print_step 10
write_bold "Clearing caches"
rm -rf ~/.cache/wine ~/.cache/winetricks
rm -rf $(brew --cache)

write_red_bold "Done!"
write_red_bold "Wait for all Wine configuration to finish (wait for any remaining windows to close), then REBOOT and check the guide on GitHub for next steps"

