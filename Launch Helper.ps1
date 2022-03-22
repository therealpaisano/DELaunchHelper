Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$FolderBrowser.Description = "Select your Steam installation folder"
$FolderBrowser.rootfolder = "MyComputer"


$options = Get-Content ".\options.json" | Out-String | ConvertFrom-Json
$new_ver = ""

if (!$options.Steam_path) {
    Write-Output "Select your Steam installation folder in the following pop-up:"
    Start-Sleep -Seconds 3
    $null = $FolderBrowser.ShowDialog()
    $options.Steam_path = $FolderBrowser.SelectedPath
}

if (!$options.version_switching -eq "y") {
    $options.version_switching = Read-Host -Prompt "Will you be swapping versions using this script? (y/n) (you can change this in options.json later)"
}
if ($options.version_switching -eq "y"){
    if (!$options.profile_path) {
        $ProfileFolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $ProfileFolderBrowser.Description = "Select your Steam profile directory (.../Steam/userdata/<id>/)"
        $ProfileFolderBrowser.rootfolder = "MyComputer"
        Write-Output "To switch versions dynamically, you must specify your steam profile folder (this is where DOOM's profile.bin is stored)"
        Write-Output "Select your Steam profile directory in the following pop-up (.../Steam/userdata/<id>/)"
        Start-Sleep -Seconds 6
        $null = $ProfileFolderBrowser.ShowDialog()
        $options.profile_path = $ProfileFolderBrowser.SelectedPath
    }
}





if (!$options.default_version) {
    $new_ver = Read-Host -Prompt "Input desired version (if you only have 1 installation still enter it in)"

    if (-not(Test-Path -Path ($options.Steam_path+"\steamapps\common\DOOMEternal\version.txt") -PathType Leaf)) {
        try {
            $null = New-Item -ItemType File -Path ($options.Steam_path+"\steamapps\common\DOOMEternal\version.txt") -Force -ErrorAction Stop
            $new_ver | Out-File ($options.Steam_path+"\steamapps\common\DOOMEternal\version.txt")
        }
        catch {
            throw $_.Exception.Message
        }
    }

    $save = Read-Host -Prompt "Would you like to set this as default? (y/n) (you can change this in options.json later)"
    if ($save -eq "y") {
        $options.default_version = $new_ver
    }
} else {
    $new_ver = $options.default_version
}


if (!$options.RTSS) {
    $RTSS = Read-Host -Prompt "Would you like to launch RTSS when running this script? (y/n) (you can change this in options.json later)"
    $options.RTSS = $RTSS
}
if ($options.RTSS -eq "y"){
    if (!$options.RTSS_path) {
        Write-Output "Select your RTSS.exe installation:"
        Start-Sleep -Seconds 3
        $null = $FileBrowser.ShowDialog()
        $options.RTSS_path = $FileBrowser.FileName
    }
}


if (!$options.Livesplit) {
    $options.Livesplit = Read-Host -Prompt "Would you like to launch Livesplit when running this script? (y/n) (you can change this in options.json later)"
}
if ($options.Livesplit -eq "y"){
    if (!$options.Livesplit_path) {
        Write-Output "Select your Livesplit.exe installation:"
        Start-Sleep -Seconds 3
        $null = $FileBrowser.ShowDialog()
        $options.Livesplit_path = $FileBrowser.FileName
    }
}


if (!$options.AHK) {
    $options.AHK = Read-Host -Prompt "Do you use Autohotkey to change FPS? (y/n) (you can change this in options.json later)"
}

if (!$options.Macro) {
    $options.Macro = Read-Host -Prompt "Do you want to launch the Freescroll Emulation Macro with this script? (y/n) (you can change this in options.json later)"
}

if ($options.version_switching) {
	$old_ver = Get-Content ($options.Steam_path+"\steamapps\common\DOOMEternal\version.txt")

	Rename-Item -Path ($options.Steam_path+"\steamapps\common\DOOMEternal\") -NewName ("DOOMEternal" + $old_ver)
	Rename-Item -Path ($options.Steam_path+"\steamapps\common\DOOMEternal" + $new_ver + "\") -NewName "DOOMEternal"

	Rename-Item -Path ($options.profile_path+"\782330\remote\PROFILE\profile.bin") -NewName ("profile" + $old_ver + ".bin")
	Rename-Item -Path ($options.profile_path+"\782330\remote\PROFILE\profile" + $new_ver + ".bin") -NewName "profile.bin"
}

Start-Process -FilePath ($options.Steam_path+"\steamapps\common\DOOMEternal\DOOMEternalx64vk.exe")
if ($options.Livesplit -eq "y") {
    Start-Process -FilePath $options.Livesplit_path
}
if ($options.RTSS -eq "y") {
    Start-Process -FilePath $options.RTSS_path -Verb RunAs
}
if ($options.AHK -eq "y") {
    Start-Process -FilePath ".\FPS_Limiter.ahk" -Verb RunAs
}

Start-Sleep -Seconds 8

if ($options.Macro -eq "y") {
    Start-Process -FilePath ".\DOOMEternalMacro.exe"
}

$options | ConvertTo-Json | Out-File ".\options.json"

Read-Host -Prompt "Press Enter to exit (This will close DOOM Eternal and other apps launched from this script)"

Stop-Process -Name "DOOMEternalx64vk"
if ($options.Livesplit -eq "y") {
    Stop-Process -Name "LiveSplit"
}
if ($options.Macro -eq "y") {
    Stop-Process -Name "DOOMEternalMacro" 
}
if ($options.AHK -eq "y") {
    Stop-Process -Name "AutoHotkey"
}
if ($options.RTSS -eq "y") {
    Stop-Process -Name "RTSS"
}
