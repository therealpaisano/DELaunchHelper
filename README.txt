LAUNCH "Launch Helper.exe" as Administrator (right click -> Launch as Admin)

This is a super basic script to automate version switching and launching all the baggage that you need to run DE (Macro, RTSS, Autohotkey, Livesplit, and DOOM itself)

On first launch, you'll tell it where your RTSS and Livesplit installations are, and that'll be saved in options.json (you can of course change this later)

In addition, you will be prompted what version of the game you would like to launch. This script reads a file in your DE directory called "version.txt" to get the version of your current installation, and will rename your DE directories and profile.bin's accordingly (changing profile.bin per version is to avoid losing settings with 3.1). 

To configure a new installation, just make a new copy of your profile.bin named "profile<version>.bin", name your new installation directory "DOOMEternal<version>". Then next time you run the script input this version number and it'll make the "version.txt" file automatically. 

If you only use one version, just input this version on first launch, and tell it to save this as your default version so it won't prompt you for the version anymore on launch (if you need another version later, you can just edit the default_version parameter in options.json to be ""). 

This version switching is a super hacky solution but it works. If there's demand (ie if people actually start using this for version switching) then I can make a more elegant implentation and automate the file making. 

For FPS Limiting, if you don't use AHK then answer no to the corresponding prompt on first launch and you'll be good, this will save in options. If you do use AHK, put the script in this directory and name it "FPS_Limiter.ahk". The default script in this zip is the one provided in #de-resources. Edit it however you like. I've included my personal script with like 7 different values if you wanna play around with that as well. Note also that the first click corrdinates assume your DOOMEternalx64vk.exe profile in RTSS is the first profile underneath "Global". If it's the second one, make the y coordinate of the first click 200 and that should work.

For the Macro, the version provided in this zip file is the most recent version. You can replace the bindings.txt file in this directory to your own, the default one here is just what I use. If the macro has an update, simply replace DOOMEternalMacro.exe with this and you'll be good to go. 

If people like this I can make a GUI to make it easier to use. This was really just a super quick script I whipped up in like a half an hour to make launching stuff easier so it's literally as basic as possible on the UX side lol. 