# Pokémon Uranium on macOS
*This guide is still young. If there is a problem with it, please open a GitHub issue. If you are unsure if it’s the guide or you, comment in [this Reddit thread](https://www.reddit.com/r/pokemonuranium/comments/818ysm/guide_install_and_play_pokémon_uranium_on_macos/) and I’ll try to help you.*

![](https://github.com/microbug/pokemon-uranium-on-mac/raw/master/assets/Initial%20Screenshot.png)

## Introduction
Pokémon Uranium development started around 2006 using RPG Maker XP, which as you might guess was designed for Windows XP. The game doesn’t run great on some modern computers and operating systems due to compatibility issues, and the binary is Windows-only. **But [wine](https://www.winehq.org) can run some Windows-only software, and Pokémon Uranium is supported! Wine may even run the game better than Windows installed on the same computer via Bootcamp!** Here I’ll detail the steps you need to take to install and run Pokémon Uranium on your Mac.

If this sounds too good to be true, it’s not. The reason is that Wine effectively runs the game natively but with open source libraries that can perform better than the proprietary Microsoft equivalents. The reason this Wine more widespread is due to the complexity in configuring it, and the fact that until fairly recently it was very buggy and didn’t work with many pieces of software. This has improved greatly in the last few years.

This document is based off [this Reddit post](https://www.reddit.com/r/pokemonuranium/comments/m9yvd6/download_links/), which dealt with running Pokémon Uranium in Wine under Linux. It has been significantly expanded to help less experienced users.

### What to expect
I’ve tested Pokémon Uranium in VMWare Fusion (Windows XP VM), Wine and Bootcamp (running Windows 10 natively on my MacBook Pro). This is what I found:

#### Windows XP virtual machine:
- Almost completely unplayable, messed up audio and very laggy

#### Windows 10:
- Skips frames regularly (GPU is a Radeon Pro 455, which is more than capable enough for this)
- Has significant screen tearing and no vsync option (AMD driver settings have no effect)
- Has a weird menu bug where menu navigation slows to around 1 option per second (making changing controls painful)
- Has the well known line bug on a 4k display:
	- > Some people have been having problems with weird lines appearing while in fullscreen mode. I am aware of this bug and am attempting to fix it. Until then the temporary fix is to enable "Run in 640 x 480 screen resolution" in the Uranium.exe compatibility settings (This has also been known to reduce lag slightly). (<https://www.reddit.com/r/pokemonuranium/comments/525uk9/official_unofficial_patch_and_server_thread/>, 2018)

#### macOS 10.13.3 via Wine:
- Runs fairly smoothly
	- Expect a few dropped frames, but fewer than with Windows
	- A little screen tearing is present but mainly occurs when running horizontally in the overworld
- Doesn’t have the menu slowness bug
- Doesn’t have the line bug


## Requirements
- macOS 10.13.3+ (not tested on earlier versions, may work but no guarantees)
- Administrator privileges
- A reasonably modern Mac, the faster the better
	- I’ll keep this guide up to date with user reports, if you want to help make this guide better please see the contributing section at the end
- A vague knowledge of UNIX and the Terminal (helpful for troubleshooting but not strictly necessary if you follow this exactly and everything works)
- A copy of the current Pokémon Uranium files (the folder `C:\Program Files (x86)\Pokemon\Uranium` on a Windows install)
	- Wine cannot be used to run the installer
	- You need to download the portable (ZIP) version from [this Reddit post](https://www.reddit.com/r/pokemonuranium/comments/54dodq/updated_installer_patch_installers/) later on


## ① Install
⏱ This step will take 30–60 minutes

[Microbug](https://github.com/microbug) has written an automagical installation script that will download, install and configure everything for you. All you need to do is download the game files and move them to the right place.

If you already have Homebrew installed, the install script will detect it and won’t overwrite your existing installation. It **will** update Homebrew though.

Open Terminal and copy and paste the following into it, then press enter. This will install all the tools needed to run Pokémon Uranium under Wine.


```bash
curl -s "https://raw.githubusercontent.com/microbug/pokemon-uranium-on-macos/master/install.sh" | bash
```

<details>
<summary>Explanation of the wine configuration installed by `install.sh` (for technical users)</summary>
`directplay`, `directmusic`, `dsound`: required to run the game.

`devenum`, `dmsynth`, `quartz`: these may or may not be required. The game doesn’t run slower without them so it’s probably best to include them.

`d3dx9_36`: a version of `d3dx9` is required, all versions seem to run similarly. `d3dx9_36` is usually the default for wine so it is chosen.

`ddr=opengl`: use `opengl` instead of `gdi`. Improves performance.

`macdriver=x11`: use XQuartz rather than Wine’s builtin Mac driver. Greatly improves performance.

`win10`: emulate Windows 10. Seems to run a little smoother than the default Windows 7.
</details>

## ② Add the Game
### Add the game to the virtual Windows installation
⏱ This step will take about 5 minutes

- Option A:
	- Go to [this Reddit post](https://www.reddit.com/r/pokemonuranium/comments/m9yvd6/download_links/) and click on the **ZIP** link to download the game files
		- The installer doesn’t work under Wine so it needs to be the portable (ZIP) version
	- Extract the zip file once it has downloaded by double clicking on it (this might happen automatically depending on how your Mac is set up)
- Option B:
	- Install Pokémon Uranium on a Windows computer
	- Copy the folder `C:\Program Files (x86)\Pokemon Uranium` to your Mac
- In Finder press SHIFT+CMD+G and type `~/pokemon_uranium/drive_c/Program Files (x86)` into the box, then hit enter
- Move the `Pokemon Uranium` folder from whichever option you chose to **the folder you are now in**

### Run the game once to install fonts
⏱ This step will take about 5 minutes

- Go to `~/pokemon_uranium`
- Double click `Run Pokémon Uranium` to start Pokémon Uranium
- The fonts will look strange on this first run
	- The game will automatically install the fonts it needs
- Press enter to accept when the game asks you if you want to restart it
- It will close (and won’t automatically restart)

### Move the game to your preferred location
You can leave the game in `~/pokemon_uranium`, but if you want to move it to (for example) `~/Documents/Pokémon Uranium` you can now do so through Finder.

## ③ Play Pokémon Uranium 😄👏
- Every time you want to play, double click `Run Pokémon Uranium.command` in your game directory to start it
- You can also drag `Run Pokémon Uranium.command` to the right side of your Dock (next to the Trash)
- When the game has launched you can close Terminal safely
- Your saves are in `<game directory>/drive_c/users/<username>/Saved Games/Pokemon Uranium`

### Checking for updates
The game’s built-in update checking mechanism appears to work correctly.

- In the game’s main menu, select `Check for updates`
- If prompted, allow the game to run the patcher
- The patcher should run
	- It may spit out some errors about invalid RAR archives
	- It’s unknown whether these affect the game, but it seems to run correctly afterwards and says it’s now up-to-date

### Best settings for smoothness
*The default settings seem to be best as of version 1.21*

- In the game, press F1 to access the game engine’s settings menu
- Enable `Smooth Mode (Pentium 4 1.5GHz or higher)`
- Optionally enable `Reduce screen flickering` if it helps reduce tearing for you
- Performance mode in the game’s options menu seems to have little effect on high-end systems, enabling it may help the game to run on old or low-end systems

### Playing with a controller
If you want to use a controller (I recommend the 8Bitdo SN30) follow these instructions:

- Install [Enjoyable](https://yukkurigames.com/enjoyable/)
- In Enjoyable, map each key on your controller to the letter it corresponds with, e.g., left bumper to L, right bumper to R
- **Make sure to click the `>` button in the top right of the Enjoyable window to enable keyboard mapping**
- In Pokémon Uranium go to `Options → Controls` and map each control to your controller’s buttons
- Remember that you’ll need to start Enjoyable to use your controller

### Known issues
- Fullscreen mode causes the game to slow down significantly. An alternative to fullscreen is to set the window to Large, and go to `System Preferences → Accessibility → Zoom → Use scroll gesture with modifier keys to zoom`, then zoom into the game using your chosen modifier key and a scroll wheel / pinch on the trackpad.
	- Fullscreen performance issues have also been reported on Windows so this is unlikely to improve unless a patch that fixes it is released

## Contributing
### System requirements
If you’d like to contribute to this guide, the easiest thing you can do is to send me your computer’s specs and let me know how well Pokémon Uranium runs for you. This will help create a more accurate requirements section.

If you know how, you can create a pull request that adds a line to `Experiences.csv` (check the headers of that file for what to add where).

Otherwise, please send an email to <richard@microbug.uk>. Please use the following template: 

```
Does Pokémon Uranium run at all under Wine on your Mac?
[...]

If yes, on a scale of 1 to 10, where 1 is barely and 10 is flawlessly,
how well does Pokémon Uranium run on your Mac?
[...]

Did you encounter any specific bugs? The more detail the better!
[...]

Remember to attach your screenshot or this is useless!

Thank you for contributing to this project
```

Please attach a screenshot of your ‘About this Mac’ page (you can black out the serial number and UUID with Preview if you wish, I won’t publish and don’t need that information). You can do this as follows:

- Click on the Apple menu (at the very top left of your screen).
- Select `About this Mac`
- Take a screenshot using the built in Grab app (the image is saved to the Desktop)
- Optionally remove/cover your serial number and hardware UUID
- **Attach to email**

### Other contributions
If you know what you’re doing or have a suggestion, please make a pull request or open an issue on GitHub. You can also email me at <richard@microbug.uk>. My PGP key is available at <https://keybase.io/microbug>.

