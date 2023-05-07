. $env:USERPROFILE\.config\powershell\user_profile.ps1
Invoke-Expression (&starship init powershell)
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
$PSModuleAutoLoadingPreference = 'None'
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}
#Create file
function touch
{set-content -Path ($args[0]) -Value ($null)
}
# Reload Powershell Profile
function reloadps
{. $PROFILE
}

#Goto Repos
function repos
{
  cd ~/source/repos
}

#List All
function la
{
  Get-ChildItem -Force $args
}

#LunarVim Alias
Set-Alias lvim 'C:\Users\Peter\.local\bin\lvim.ps1'
