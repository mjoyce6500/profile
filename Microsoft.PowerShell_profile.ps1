# awesome ref  https://github.com/mjoyce6500/profile
# customize path and shortcuts
if (!(test-path alias:note)) {New-Alias -Name note -Value 'C:\Program Files\Notepad++\notepad++.exe'}
$me = $env:USERPROFILE
$downloads = (join-path $env:USERPROFILE 'downloads')
$tmp = 'c:\tmp'

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
Clear-Host
[console]::BufferHeight=5000
[console]::BufferWidth=120
$PSVer = $Host.Version.Major
[console]::Title = " Your domain:   $env:UserDomain   |      This is PowerShell  $PSVer"
$maxWS = $host.UI.RawUI.Get_MaxWindowSize()
 $ws = $host.ui.RawUI.WindowSize
 IF($maxws.width -ge 85)
   { $ws.width = 120 }
 ELSE { $ws.height = $maxws.height }
 IF($maxws.height -ge 42)
   { $ws.height = 55 }
 ELSE { $ws.height = $maxws.height }
 $host.ui.RawUI.Set_WindowSize($ws)

# testing connectivity to GitHub
$url = 'https://github.com'
$response= try {Invoke-WebRequest  -Method Head  $url -ErrorAction Continue } catch {$_.Exception.Response}
If ($response.StatusCode -eq 200) {
    Write-Host "-- Able to connect to GitHub." -ForegroundColor Green }
Else {
    Write-Host "FAILED to connect to GitHub!  " -ForegroundColor Red 
	Write-Host "Check Internet connection `n` " -ForegroundColor Red} 

# Chocolatey profile
if (test-path $env:ChocolateyInstall) {$ChocolateyProfile = (join-path $env:ChocolateyInstall "\helpers\chocolateyProfile.psm1")}
if (Test-Path($ChocolateyProfile) -ErrorAction SilentlyContinue) {
  Import-Module "$ChocolateyProfile"
  write-host "-- Chocolatey profile found and imported. `n` " -ForegroundColor Gray
}

Write-Host 'List of quick dir''s'
Write-Host '$me' "-`t`t$me"
Write-Host '$downloads' "-`t$downloads"
Write-Host '$tmp' "-`t`t$tmp"
(get-date).DateTime