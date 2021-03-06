# Microsoft Profile Config's
[![GitHub (pre-)release](https://img.shields.io/badge/release-0.5-green.svg)](https://github.com/mjoyce6500/profile/releases/tag/0.5) 

Stable 0.5

This repo contains some simple profile configurations which customize shell experiences on my Windows cmdline usage.  Expanded this repo to include Microsoft Terminal as well as Powershell.  WSL distro's coming...


## Table of Contents

=============
<!--ts-->
 1. [Microsoft Terminal](#Microsoft-Terminal)
 2. [PowerShell](#Microsoft-PowerShell-Profile)
 <!--te-->
=============
# Microsoft Terminal
Welcome to the Windows Terminal, Console and Command-Line
## Summary
  Microsoft released a pretty clever Terminal environment.  Details can be found here:  https://github.com/Microsoft/Terminal   I added some simple customizations which are all contained in the [my terminal repo](./terminal).  Simply install the software, clone repo and overwrite profiles.json with this one.  You'll have to install WSL distributions as desired for some of these menu items to work.



## Summary
Simple Microsoft PowerShell profile to help with a couple of things:
 + choco anti-Virus config
 + test connectivity to Google Drive
 + customize display and title bar
 + setup couple of $shortcuts
 
## Environment
 This was written with the following version of PowerShell
 ```powershell
PS C:\> $PSVersionTable
 Name                           Value
----                           -----
PSVersion                      5.1.17763.134
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.17763.134
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
## Versions:
 + [0.4](https://github.com/mjoyce6500/profile/tree/0.4)  Added choco anti-Virus config Windows Defender.
 + [0.3](https://github.com/mjoyce6500/profile/tree/0.3)  Revised the internet check to Google Drive, checking privilege of user and noting in Title bar with date.
 + [0.2](https://github.com/mjoyce6500/profile/tree/0.2)  Revised the internet check to GitHub, also Import-Module of Chocolatey if exists
 + [0.1](https://github.com/mjoyce6500/profile/tree/0.1)  Getting started

## Good References
https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ise/how-to-use-profiles-in-windows-powershell-ise?view=powershell-6

https://github.com/crazy54/work-related/blob/master/Profile.ps1


<a href="http://www.youtube.com/watch?feature=player_embedded&v=jQzgSxetr5I" target="_blank"><img src="https://github.com/mjoyce6500/profile/blob/master/images/youtube.jpg" alt="PowerShell Profiles" width="240" height="180" border="5" /></a>
