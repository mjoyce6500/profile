# Microsoft PowerShell Profile 
[![GitHub (pre-)release](https://img.shields.io/badge/release-0.1-green.svg)](https://github.com/mjoyce6500/profile/releases/tag/0.1) 

Stable 0.1

## Summary
Simple Microsoft PowerShell profile to help with a couple of things:
 + test connectivity to nothing
 + customize display
 + setup couple of $shortcuts
 
## Environment
 This was written with the following version of PowerShell
 ```powershell
PS C:\> $PSVersionTable
 Name                           Value
----                           -----
PSVersion                      5.1.16299.98
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.16299.98
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1

PS C:\> $PSEdition
Desktop
```
## Lets get started....
Test for your profile:
```PowerShell
PS C:\> Test-Path $Profile
```
If result is   `False` .    Then run:
```PowerShell
PS C:\> New-Item -path $profile -type file –force
```


## Good References
https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ise/how-to-use-profiles-in-windows-powershell-ise?view=powershell-6

https://github.com/crazy54/work-related/blob/master/Profile.ps1


<a href="http://www.youtube.com/watch?feature=player_embedded&v=jQzgSxetr5I" target="_blank"><img src="https://github.com/mjoyce6500/profile/blob/master/images/youtube.jpg" alt="PowerShell Profiles" width="240" height="180" border="20" /></a>
