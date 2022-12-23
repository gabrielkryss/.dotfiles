## NOTE: paste the following line into $PROFILE.CurrentUserCurrentHost (use nvim to open that file)
## $env:USERPROFILE\.config\powershell\user_profile.ps1

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module posh-git
Import-Module oh-my-posh
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
SetPoshPrompt star
# $omp_config = Join-Path $PSScriptRoot "" # oh-my-posh (omp) config file e.g. ".\takuya.omp.json"
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

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
