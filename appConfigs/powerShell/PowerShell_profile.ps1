Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# Powerline
#Import-Module posh-git
#Import-Module oh-my-posh
#Set-Theme Paradox
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\pixelrobots.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config D:\personal\gh-ebbypeter\dotfiles\appConfigs\oh-my-posh\ebby-01.omp.json | Invoke-Expression

# Proxy settings 
#(New-Object System.Net.WebClient).Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

# PSReadline Intellisense
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
