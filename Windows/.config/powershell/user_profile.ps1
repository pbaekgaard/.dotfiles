# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Invoke-Expression (&starship init powershell)
#Slow Imports
#Import-Module posh-git
#$omp_config = Join-Path $PSScriptRoot ".\takuya.omp.json"
#oh-my-posh init pwsh --config "$omp_config" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\Paradox.omp.json" | Invoke-Expression
Import-Module Get-ChildItemColor
#Import-Module -Name Terminal-Icons

Set-Alias test ew
function ew
{echo "WORKS"
}

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias -Name vim -Value nvim -Force
Set-Alias ll llfiles
function llfiles
{Get-ChildItemColor -File
}

Remove-Item Alias:\ls -Force

function ls
{
  Get-ChildItemColor;
}
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias reload rel
Set-Alias gcl gclone
function gclone
{git clone
}
function rel
{
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait(". $")
  [System.Windows.Forms.SendKeys]::SendWait("PROFILE")
  [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
  [System.Windows.Forms.SendKeys]::SendWait("clear")
  [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}


# Utilities
function which ($command)
{
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

