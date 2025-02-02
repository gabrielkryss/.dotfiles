## NOTE: paste the following line into $PROFILE.CurrentUserCurrentHost (use nvim to open that file), including the dot.
## . $env:USERPROFILE\.config\powershell\user_profile.ps1

## Install Commands
## Install-Module -Name Terminal-Icons -Repository PSGallery
## Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
## Install-Module -Name z -Force
## scoop install fzf
## scoop install fzf OR Install-Module -Name PSFzf -scope currentUser
## Install-Module -Name ZLocation -scope currentUser
## scoop install fd
## scoop install starship
## scoop install ripgrep
## Install-Module posh-git -Scope CurrentUser
## Install-Module oh-my-posh -Scope CurrentUser

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Import-Module posh-git
# themes link ref: https://ohmyposh.dev/docs/themes
# - star
# - spaceship
# - gruvbox
# - hotstick.minimal
# - zash
# - tonybaloney
# - the-unnamed
# - neko
# - multiverse-neon
# - lambdageneration
# - velvet
# - xtoys
# $omp_config = Join-Path $PSScriptRoot ".\themes\xtoys.omp.json" #  local oh-my-posh (omp) config file e.g. ".\takuya.omp.json"
# $omp_config = "https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/star.omp.json" # remote omp config
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"

Import-Module -Name Terminal-Icons

# # PSReadLine
# Set Some Option for PSReadLine to show the history of our typed commands
# Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History 
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -EditMode Emacs 

# Installation lines:

# # Fzf
Import-Module PSFzf
# Enable-PsFzfAliases
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadLineKeyHandler -Chord ctrl+f -ScriptBlock { fd | Invoke-fzf | Set-Location }

# ZLocation
Import-Module ZLocation

# Aliases
Set-Alias grep findstr
Set-Alias vim nvim 
Set-Alias ll ls 

# Checked if eza is installed
if (Get-Command eza -ErrorAction SilentlyContinue) {
  function myEzaList { param([string]$Path = ".")
    eza -1albBghiS --icons=auto --color=auto --color-scale=all --color-scale-mode=gradient --group-directories-first --hyperlink --total-size $Path
  }
  Set-Alias ls myEzaList
} 

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

## This doesnt work
# Get the SystemParametersInfo API function
$SystemParametersInfo = Add-Type -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true)]
public static extern bool SystemParametersInfo(
  uint uiAction,
  uint uiParam,
  string pvParam,
  uint fWinIni
);
"@ -Name "NativeMethods" -Namespace Win32 -PassThru
# function to change wallapaper
function cw ($PathToImg) {
  $SystemParametersInfo::SystemParametersInfo(20, 0, $PathToImg, 0x01)
}

Invoke-Expression (&starship init powershell)
