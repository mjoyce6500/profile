# Powershell profile version 0.4  https://github.com/mjoyce6500/profile/releases
# awesome ref  https://github.com/crazy54/work-related/blob/master/Profile.ps1

# customize path and shortcuts
if (!(test-path alias:note)) {New-Alias -Name note -Value 'C:\Program Files\Notepad++\notepad++.exe'}
if (!(test-path alias:mind)) {New-Alias -Name mind -Value 'C:\Program Files (x86)\FreeMind\FreeMind.exe'}
if (!(test-path alias:pycharm)) {New-Alias -Name pycharm -Value 'C:\Program Files (x86)\JetBrains\PyCharm Community Edition 2019.3\bin\pycharm64.exe'}
if (!(test-path alias:python)) {New-Alias -Name python -Value 'C:\Python37\python.exe'}

$me = $env:USERPROFILE
$downloads = (join-path $env:USERPROFILE 'Downloads')
$pubgit = (join-path $env:USERPROFILE 'Git')
$tmp = 'c:\tmp'
$run = (join-path $downloads \code)
$env:CHEF_ORG = "engineering"
$defenderOptions = Get-MpComputerStatus
$date = (Get-Date).DateTime

# customize the powershell window
$Host.UI.RawUI.ForegroundColor = 'Yellow'
$Host.ui.rawui.BackgroundColor = ($bckgrnd = 'Black')
$Host.PrivateData.ErrorForegroundColor = 'White'
$Host.PrivateData.ErrorBackgroundColor = 'Red'
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
$OSver = [System.Environment]::OSVersion.Version.Major.ToString() + "." + [System.Environment]::OSVersion.Version.Minor.ToString() + "." + [System.Environment]::OSVersion.Version.Build.ToString()
$PSVer = $Host.Version.Major.ToString() + "." + $Host.Version.Minor.ToString()
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
[console]::Title = " $whoami  running as: ADMINISTRATOR    |    Windows $OSver    |    PowerShell  $PSVer    |    $now"
function prompt {"[ADMIN]  $(get-location)> "}
}
else
{
[console]::Title =  " $whoami    |    Windows $OSver    |    PowerShell  $PSVer    |    $now"
}

# testing connectivity to GitHub
$url = 'https://github.com/mjoyce6500/'
$HTTP_Request = [System.Net.WebRequest]::Create($url)
$HTTP_Response = $HTTP_Request.GetResponse()
$HTTP_Status = [int]$HTTP_Response.StatusCode
if ($HTTP_Status -eq 200) {
    Write-Host "-- Able to connect to GitHub.  " -ForegroundColor Green  -NoNewline
    Write-Host $url -ForegroundColor White  -NoNewline
    Write-Host "   Response code:  " -ForegroundColor Green -NoNewline
    Write-Host $HTTP_Status }
else {
    Write-Host "FAILED to connect to GitHub!  " -ForegroundColor Red 
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
if (($defenderOptions.AntivirusEnabled -eq 'True') -and ($Principal.IsInRole($AdminRole) -and -not (choco.exe config list | grep "MPCmdRun.exe")))
    {
    Write-Host "ADMINISTRATOR + Defender A/V (" -NoNewline
    Write-Host $defenderOptions.AntiVirusEnabled + ")  =  " -ForegroundColor White -NoNewline
    Write-Host "Chocolatey VirusCheck set to Defender." -ForegroundColor Cyan
    choco config set --name = 'genericVirusScannerPath' --value = "'C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.2004.6-0\MpCmdRun.exe' -Scan"
    }

$result = New-Object -TypeName PSObject
$result | Add-Member -MemberType Noteproperty -Name '$me' -Value $($me)
$result | Add-Member -MemberType Noteproperty -Name '$downloads' -Value $($downloads)
$result | Add-Member -MemberType Noteproperty -Name '$pubgit' -Value $($pubgit)
$result | Add-Member -MemberType Noteproperty -Name '$tmp' -Value $($tmp)
$result | Add-Member -MemberType Noteproperty -Name Date -Value $($date)
$result | Format-List