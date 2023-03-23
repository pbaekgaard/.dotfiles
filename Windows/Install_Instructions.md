# Choco, Scoop, Cargo
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

## Choco
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Scoop
irm get.scoop.sh | iex

## Cargo
winget install --id Rustlang.Rustup


# Starship
winget install --id Starship.Starship

starship preset pure-prompt > ~/.config/starship.toml
