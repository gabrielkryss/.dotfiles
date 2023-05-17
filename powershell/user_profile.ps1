## NOTE: paste the following line into $PROFILE.CurrentUserCurrentHost (use nvim to open that file), including the dot.
## . $env:USERPROFILE\.config\powershell\user_profile.ps1

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

Import-Module -Name Terminal-Icons

# # PSReadLine
# Set-PSReadLineOption -EditMode Emacs
# Set-PSReadLineOption -BellStyle None
# Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
# Set-PSReadLineOption -PredictionSource History

# # Fzf
# Import-Module PSFzf
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Aliases
Set-Alias grep findstr

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
