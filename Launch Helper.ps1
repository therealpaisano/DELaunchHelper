Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$FolderBrowser.Description = "Select your Steam installation folder"
$FolderBrowser.rootfolder = "MyComputer"


$options = Get-Content ".\options.json" | Out-String | ConvertFrom-Json
$new_ver = ""

if (!$options.Steam_path) {
    Write-Output "Select your Steam installation folder:"
    $null = $FolderBrowser.ShowDialog()
    $options.Steam_path = $FolderBrowser.SelectedPath
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


if (!$options.RTSS_path) {
    Write-Output "Select your RTSS.exe installation:"
    $null = $FileBrowser.ShowDialog()
    $options.RTSS_path = $FileBrowser.FileName
}

if (!$options.Livesplit_path) {
    Write-Output "Select your Livesplit.exe installation:"
    $null = $FileBrowser.ShowDialog()
    $options.Livesplit_path = $FileBrowser.FileName
}


$ahk = ""
if (!$options.AHK) {
    $ahk = Read-Host -Prompt "Do you use Autohotkey to change FPS? (y/n)"
    if ($save -eq "y") {
        $options.AHK = $ahk
    }
}


$old_ver = Get-Content ($options.Steam_path+"\steamapps\common\DOOMEternal\version.txt")

Rename-Item -Path ($options.Steam_path+"\steamapps\common\DOOMEternal\") -NewName ("DOOMEternal" + $old_ver)
Rename-Item -Path ($options.Steam_path+"\steamapps\common\DOOMEternal" + $new_ver + "\") -NewName "DOOMEternal"

Rename-Item -Path ($options.Steam_path+"\userdata\126516426\782330\remote\PROFILE\profile.bin") -NewName ("profile" + $old_ver + ".bin")
Rename-Item -Path ($options.Steam_path+"\userdata\126516426\782330\remote\PROFILE\profile" + $new_ver + ".bin") -NewName "profile.bin"

Start-Process -FilePath ($options.Steam_path+"\steamapps\common\DOOMEternal\DOOMEternalx64vk.exe")
Start-Process -FilePath $options.Livesplit_path
Start-Process -FilePath $options.RTSS_path -Verb RunAs
if ($ahk -eq "y") {
    Start-Process -FilePath ".\FPS_Limiter.ahk" -Verb RunAs
}

Start-Sleep -Seconds 5
Start-Process -FilePath ".\DOOMEternalMacro.exe"

$options | ConvertTo-Json | Out-File ".\options.json"

Read-Host -Prompt "Press Enter to exit (This will close DOOM Eternal and other apps launched from this script)"

Stop-Process -Name "DOOMEternalx64vk"
Stop-Process -Name "LiveSplit"
Stop-Process -Name "DOOMEternalMacro" 
if ($ahk -eq "y") {
    Stop-Process -Name "AutoHotkey"
}

Stop-Process -Name "RTSS"
