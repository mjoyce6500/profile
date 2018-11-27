# Powershell profile version 0.4  https://github.com/mjoyce6500/profile/releases
# awesome ref  https://github.com/crazy54/work-related/blob/master/Profile.ps1

# customize path and shortcuts
if (!(test-path alias:note)) {New-Alias -Name note -Value 'C:\Program Files\Notepad++\notepad++.exe'}
if (!(test-path alias:mind)) {New-Alias -Name mind -Value 'C:\Program Files (x86)\FreeMind\FreeMind.exe'}
if (!(test-path alias:pycharm)) {New-Alias -Name pycharm -Value 'C:\Program Files (x86)\JetBrains\PyCharm Community Edition 2018.2.3\bin\pycharm64.exe'}
if (!(test-path alias:python)) {New-Alias -Name python -Value 'C:\Python37\python.exe'}

$me = $env:USERPROFILE
$downloads = (join-path $env:USERPROFILE 'downloads')
$pubgit = 'C:\publicGitHub'
$tmp = 'c:\tmp'
$run = (join-path $downloads \code)
$env:CHEF_ORG = "engineering"
$defenderOptions = Get-MpComputerStatus

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
cd $pubgit
$PSVer = $Host.Version.Major
$maxWS = $host.UI.RawUI.Get_MaxWindowSize()
$ws = $host.ui.RawUI.WindowSize
if ($maxws.width -ge 85)   { $ws.width = 120 }
else { $ws.height = $maxws.height }

if ($maxws.height -ge 65)  { $ws.height = 65 }
else { $ws.height = $maxws.height }
$host.ui.RawUI.Set_WindowSize($ws)

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
if ($response.StatusCode -eq 200) {
    Write-Host "-- Able to connect to Google Drive.  " -ForegroundColor Green  -NoNewline
    Write-Host $url -ForegroundColor White  -NoNewline
    Write-Host "   Response code:  " -ForegroundColor Green -NoNewline
    Write-Host $response.StatusCode
else {
    Write-Host "FAILED to connect to Google Drive!  " -ForegroundColor Red 
	Write-Host "Check Internet connection or shell proxy config first`n` " -ForegroundColor Red} 

# Chocolatey profile
if (test-path $env:ChocolateyInstall) 
    {
    $ChocolateyProfile = (join-path $env:ChocolateyInstall "\helpers\chocolateyProfile.psm1")
    }
if (Test-Path($ChocolateyProfile) -ErrorAction SilentlyContinue)
    {
    Import-Module "$ChocolateyProfile"
    write-host "-- Chocolatey profile found and imported. " -ForegroundColor Gray
    }
if ((-not([string]::IsNullOrEmpty($defenderOptions))) -and ($Principal.IsInRole($AdminRole)))
    {
    Write-Host "Since you are running as ADMINISTRATOR we are configuring anti-Virus settings in Choco" -ForegroundColor Cyan
    Write-Host "Windows Defender found on host: " -ForegroundColor Cyan -NoNewline
    Write-Host $env:COMPUTERNAME -ForegroundColor White
    Write-Host "Windows Defender Enabled? " -ForegroundColor Cyan -NoNewline
    Write-Host $defenderOptions.AntiVirusEnabled -ForegroundColor White
    Write-Host "Setting Chocolatey to use Windows Defender." -ForegroundColor Cyan
    choco feature enable -n viruscheck
    choco config set genericVirusScannerPath "'C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.1807.18075-0\MPCmdRun.exe' -Scan"
    }
else
    {
    Write-Host "Your not running as ADMINISTRATOR or Windows Defender was not found running on host: " -ForegroundColor Cyan -NoNewline
    Write-Host $env:COMPUTERNAME -ForegroundColor White
    Write-Host " so we are not configuring anti-Virus settings in choco" -ForegroundColor Cyan
    }

# Chef org
if ($env:CHEF_ORG)
    {
    Write-host "-- CHEF_ORG environment var set to '$env:CHEF_ORG'  " -ForegroundColor Gray
    } 
else
    {
    Write-host " (x) Unable to set CHEF_ORG envar correctly - please configure manually." -ForegroundColor Red
    }
# PowerShellGet is a toolset from MSFT @ https://github.com/PowerShell/PowerShellGet
If (Test-Path $pubgit\PowerShellGet)
    { 
    $PowerShellGet = (join-path $pubgit\PowerShellGet "\PowerShellGet\PSModule.psm1")
    Write-Host "Checking if PowerShellGet module is on " -ForegroundColor Cyan -NoNewline
    Write-Host $env:COMPUTERNAME -ForegroundColor White
    Import-Module "$PowerShellGet"
    write-host "-- PowerShellGet found and imported. `n" -ForegroundColor Gray
    }
$result = New-Object -TypeName PSObject
$result | Add-Member -MemberType Noteproperty -Name '$me' -Value $($me)
$result | Add-Member -MemberType Noteproperty -Name '$downloads' -Value $($downloads)
$result | Add-Member -MemberType Noteproperty -Name '$pubgit' -Value $($pubgit)
$result | Add-Member -MemberType Noteproperty -Name '$tmp' -Value $($tmp)
$result | Add-Member -MemberType Noteproperty -Name '$run' -Value $($run)
$result | Add-Member -MemberType Noteproperty -Name Date -Value $($date)
$result | Format-List