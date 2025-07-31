## NOTE: paste the following line into $PROFILE.CurrentUserCurrentHost (use nvim to open that file), including the dot.
## . $env:USERPROFILE\.config\powershell\user_profile.ps1

## Install Commands
## Install-Module -Name Terminal-Icons -Repository PSGallery
## Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
## Install-Module -Name z -Force
## Install-Module -Name ZLocation -scope currentUser
## winget install fzf OR Install-Module -Name PSFzf -scope currentUser
## winget install fzf
## winget install fd
## winget install starship
## winget install ripgrep
## winget install GlazeWM
## winget install carapace
## winget install bat
## winget install bottom
## winget install fastfetch
## winget install lazygit
## winget install zoxide
## winget install eza
## winget install starship
## winget install Neovim
## winget install Git
## winget install Obsidian
## winget install Powertoys
## winget install Everything
## winget install vivid
## winget install chezmoi

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
# Set-PSReadLineOption -PredictionSource History 
# Set-PSReadLineOption -PredictionViewStyle ListView 
# Set-PSReadLineOption -EditMode Emacs 

# Installation lines:

# # Fzf
# Import-Module PSFzf
# Enable-PsFzfAliases
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# Set-PSReadLineKeyHandler -Chord ctrl+f -ScriptBlock { fd | Invoke-fzf | Set-Location }

# ZLocation
# Import-Module ZLocation

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

# Carapace CLI completion engine
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace powershell | Out-String | Invoke-Expression
chezmoi completion powershell | Out-String | Invoke-Expression
# vincent, CLI for selecting terminal color themes, not available on winget yet but maybe in the future?
# vincent _carapace | Out-String | Invoke-Expression 

# optional
# (all options)link: https://gogh-co.github.io/Gogh/
# - catppuccin-mocha
# - catppuccin-macchiato
# - catppuccin-frappé
# - gruvbox-dark
# - gruvbox-material-dark
# - rosé-pine
# - rosé-pine-moon
# - everforest-dark-hard
# - everforest-dark-medium
# - everforest-dark-soft
$env:LS_COLORS = (vivid generate catppuccin-mocha)
# set carapace display style (doesn't work?)
# Set style for values
carapace --style "carapace.Value=bg-bright,black,bold"
# Set style for descriptions (leave empty to disable styling)
carapace --style "carapace.Description="

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function Init-VS-Vars {
    param (
        [string]$Arch = "x64"
    )

    if ($Arch -in @("--help", "-h", "/?")) {
        Write-Host @"
Init-VS-Vars [-Arch <architecture>]

Sets up the Visual Studio 2022 development environment in the current PowerShell session.

Available architectures:
  x86           - 32-bit native tools
  x64           - 64-bit native tools (default)
  x86_amd64     - Cross-compile x64 from x86 host
  amd64_x86     - Cross-compile x86 from x64 host
  arm           - ARM native tools
  arm64         - ARM64 native tools

Example:
  Init-VS-Vars -Arch x86_amd64
"@
        return
    }

    $vsPaths = @(
        "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat",
        "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat",
        "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
    )

    $vcvarsPath = $vsPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $vcvarsPath) {
        Write-Error "❌ Visual Studio 2022 not found. Please ensure it is installed."
        return
    }

    Write-Host "✅ Found vcvarsall.bat at: $vcvarsPath"
    Write-Host "📦 Setting up environment for architecture: $Arch"

    cmd /c "`"$vcvarsPath`" $Arch && set" | ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
        }
    }

    Write-Host "✅ Environment variables set for Visual Studio 2022 ($Arch)."
}


## This doesnt work?
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
Invoke-Expression (& { (zoxide init powershell | Out-String) })
