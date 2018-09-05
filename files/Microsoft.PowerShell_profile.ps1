# Powershell profile version 0.3  https://github.com/mjoyce6500/profile/releases
# awesome ref  https://github.com/crazy54/work-related/blob/master/Profile.ps1

# customize path and shortcuts
if (!(test-path alias:note)) {New-Alias -Name note -Value 'C:\Program Files\Notepad++\notepad++.exe'}
if (!(test-path alias:mind)) {New-Alias -Name mind -Value 'C:\Program Files (x86)\FreeMind\FreeMind.exe'}
if (!(test-path alias:pycharm)) {New-Alias -Name pycharm -Value 'C:\Program Files (x86)\JetBrains\PyCharm 2018.2\bin\pycharm64.exe'}
$me = $env:USERPROFILE
$downloads = (join-path $env:USERPROFILE 'downloads')
$pubgit = 'C:\publicGitHub'
$tmp = 'c:\tmp'
$run = (join-path $downloads \code)
$env:CHEF_ORG = "engineering"

# customize the powershell window
$Host.UI.RawUI.BackgroundColor = ($bckgrnd = 'Black')
$Host.UI.RawUI.ForegroundColor = 'Yellow'
$Host.PrivateData.ErrorForegroundColor = 'white'
$Host.PrivateData.ErrorBackgroundColor = 'red'
$Host.PrivateData.WarningForegroundColor = 'Magenta'
$Host.PrivateData.WarningBackgroundColor = $bckgrnd
$Host.PrivateData.DebugForegroundColor = 'White'
$Host.PrivateData.DebugBackgroundColor = $bckgrnd
$Host.PrivateData.VerboseForegroundColor = 'Green'
$Host.PrivateData.VerboseBackgroundColor = $bckgrnd
$Host.PrivateData.ProgressForegroundColor = 'Cyan'
$Host.PrivateData.ProgressBackgroundColor = $bckgrnd
[console]::BufferHeight=5000
[console]::BufferWidth=120 
Clear-Host
$PSVer = $Host.Version.Major
# Check if Elevated
$WindowsIdentity = [system.security.principal.windowsidentity]::GetCurrent()
$Principal = New-Object System.Security.Principal.WindowsPrincipal($WindowsIdentity)
$AdminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
$whoami= $WindowsIdentity.Name
$now= get-date -Format D
if ($Principal.IsInRole($AdminRole))
{
[console]::Title = " $whoami  running as: ADMINISTRATOR         |      This is PowerShell  $PSVer       |       $now"
}
else
{
[console]::Title =  " $whoami           |       This is PowerShell  $PSVer       |         $now"
}
$maxWS = $host.UI.RawUI.Get_MaxWindowSize()
 $ws = $host.ui.RawUI.WindowSize
 IF($maxws.width -ge 85)
   { $ws.width = 120 }
 ELSE { $ws.height = $maxws.height }
 IF($maxws.height -ge 55)
   { $ws.height = 50 }
 ELSE { $ws.height = $maxws.height }
 $host.ui.RawUI.Set_WindowSize($ws)

# testing VPN connectivity 
# $url = 'https://url.dev.company.com'
# $response= try {Invoke-WebRequest  -Method Head  $url -ErrorAction Continue } catch {$_.Exception.Response}
# If ($response.StatusCode -eq 200) {
#     Write-Host "-- Able to connect to VPN." -ForegroundColor Green }
# Else {
#    Write-Host "FAILED to connect to VPN!  " -ForegroundColor Red 
#    Write-Host "Check VPN connection first`n` " -ForegroundColor Red} 

# testing connectivity to Google Drive
$url = 'https://drive.google.com/drive/my-drive'
$response= try {Invoke-WebRequest  -Method Head  $url -ErrorAction Continue } catch {$_.Exception.Response}
If ($response.StatusCode -eq 200) {
    Write-Host "-- Able to connect to Google Drive." -ForegroundColor Green }
Else {
    Write-Host "FAILED to connect to Google Drive!  " -ForegroundColor Red 
	Write-Host "Check Internet connection or shell proxy config first`n` " -ForegroundColor Red} 
	
cd $pubgit
# Chocolatey profile
if (test-path $env:ChocolateyInstall) {$ChocolateyProfile = (join-path $env:ChocolateyInstall "\helpers\chocolateyProfile.psm1")}
if (Test-Path($ChocolateyProfile) -ErrorAction SilentlyContinue) {
  Import-Module "$ChocolateyProfile"
  write-host "-- Chocolatey profile found and imported. " -ForegroundColor Gray
}
# Chef org
if ($env:CHEF_ORG) {
        Write-host "-- CHEF_ORG environment var set to '$env:CHEF_ORG' `n` " -ForegroundColor Gray
} else {
        Write-host " (x) Unable to set CHEF_ORG envar correctly - please configure manually." -ForegroundColor Red
}
Write-Host 'List of quick dir''s'
Write-Host '$me' "-`t`t$me"
Write-Host '$downloads' "-`t$downloads"
Write-Host '$pubgit' "-`t$pubgit"
Write-Host '$tmp' "-`t`t$tmp"
Write-Host '$run' "-`t`t$run" `n