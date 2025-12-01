## Install Commands
## Install-Module -Name Terminal-Icons -Repository PSGallery
## Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
## Install-Module PSReadLinePrediction -Force
## Install-Module -Name PSFzf -Scope CurrentUser -Force -AllowClobber
## Install-Module -Name ZLocation -scope currentUser

# Set powershell session to RemoteSigned
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Starship
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"

$env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"

# Open Code
$env:OPENCODE_CONFIG_DIR = "$env:USERPROFILE\.config\opencode"

# Windows Debugger Symbols
$env:_NT_SYMBOL_PATH = "srv*C:\symbols*https://msdl.microsoft.com/download/symbols"

if (Get-Module -ListAvailable -Name Terminal-Icons) {
  Import-Module -Name Terminal-Icons
}

# PSReadLine
# Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History,Plugin
Set-PSReadLineOption -PredictionViewStyle ListView # Inline
Set-PSReadLineOption -EditMode Vi # or Emacs, Windows, Vi
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 4096

# Alt+c → fuzzy cd into a directory
Set-PSReadLineKeyHandler -Chord Ctrl+f -ScriptBlock {
    if (Get-Command z -ErrorAction SilentlyContinue) {
        # If zoxide is installed, use its 'zi' subcommand
        zi
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    } else {
        fd --type d | fzf | Set-Location
    }
}
# Ctrl+s → grep search inside files
Set-PSReadLineKeyHandler -Chord Ctrl+s -ScriptBlock {
    $pattern = Read-Host "Search pattern"
    rg --no-heading --line-number $pattern |
        fzf --delimiter : --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' |
        ForEach-Object {
            $parts = $_ -split ":"
            nvim $parts[0]
        }
}

Set-PSReadLineKeyHandler -Chord Ctrl+n -Function NextSuggestion
Set-PSReadLineKeyHandler -Chord Ctrl+p -Function PreviousSuggestion

# Fzf
if (Get-Module -ListAvailable -Name PSFzf) {
  Import-Module PSFzf
  Enable-PsFzfAliases
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                  -PSReadlineChordReverseHistory 'Ctrl+r'
}

# -------------------------------
# Gruvbox Theme
# -------------------------------
# Set-PSReadLineOption -Colors @{
#     Command   = 'DarkYellow'
#     Parameter = 'DarkCyan'
#     String    = 'DarkGreen'
#     Operator  = 'DarkRed'
#     Variable  = 'Yellow'
#     Number    = 'DarkMagenta'
#     Member    = 'Gray'
#     Type      = 'DarkGray'
#     Comment   = 'DarkBlue'
# }

# -------------------------------
# Everforest Theme
# -------------------------------
# Set-PSReadLineOption -Colors @{
#     Command   = 'Green'
#     Parameter = 'Cyan'
#     String    = 'DarkGreen'
#     Operator  = 'DarkYellow'
#     Variable  = 'White'
#     Number    = 'DarkCyan'
#     Member    = 'DarkGray'
#     Type      = 'DarkGreen'
#     Comment   = 'DarkMagenta'
# }

# -------------------------------
# Catppuccin Mocha Theme
# -------------------------------
# Set-PSReadLineOption -Colors @{
#     Command   = 'Magenta'
#     Parameter = 'Cyan'
#     String    = 'Green'
#     Operator  = 'Yellow'
#     Variable  = 'White'
#     Number    = 'DarkCyan'
#     Member    = 'DarkMagenta'
#     Type      = 'Gray'
#     Comment   = 'DarkGray'
# }

# -------------------------------
# Tokyo Night Theme
# -------------------------------
# Set-PSReadLineOption -Colors @{
#     Command   = 'Blue'
#     Parameter = 'Cyan'
#     String    = 'Green'
#     Operator  = 'Magenta'
#     Variable  = 'White'
#     Number    = 'DarkBlue'
#     Member    = 'DarkMagenta'
#     Type      = 'DarkCyan'
#     Comment   = 'DarkGray'
# }

# -------------------------------
# Rosé Pine Theme
# -------------------------------
# Set-PSReadLineOption -Colors @{
#     Command   = 'Magenta'
#     Parameter = 'DarkCyan'
#     String    = 'DarkGreen'
#     Operator  = 'DarkMagenta'
#     Variable  = 'White'
#     Number    = 'DarkYellow'
#     Member    = 'Gray'
#     Type      = 'DarkGray'
#     Comment   = 'DarkBlue'
# }

# Aliases
# Check if ripgrep (rg) is NOT installed
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "❌ ripgrep (rg) is NOT installed. Please install it via winget:" -ForegroundColor Red
    Write-Host "winget install BurntSushi.ripgrep"
}
Set-Alias grep rg
Set-Alias findstr rg
Set-Alias ll ls

# Check if eza is installed
if (-not (Get-Command eza -ErrorAction SilentlyContinue)) {
    Write-Host "❌ eza is NOT installed. Please install it via winget:" -ForegroundColor Red
    Write-Host "winget install eza"
}
function myEzaList { param([string]$Path = ".")
  eza -1albBghiS --icons=auto --color=auto --color-scale=all --color-scale-mode=gradient --group-directories-first --hyperlink --total-size $Path
}
Set-Alias ls myEzaList

# Carapace CLI completion engine
carapace _carapace powershell | Out-String | Invoke-Expression
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Optional: set Carapace display styles (cheap)
# Set style for values
carapace --style "carapace.Value=bg-bright,black,bold"
# Set style for descriptions (leave empty to disable styling)
carapace --style "carapace.Description="
# ------------------------------------------------------------
# Carapace: lazy-loaded completions (single-file integration)
# ------------------------------------------------------------
# One-time injection guard
function Initialize-CarapaceCompletion {
  if ($script:CarapaceCoreReady) { return }
  try {
    # Wire Carapace’s PowerShell integration once
    carapace _carapace powershell | Out-String | Invoke-Expression
    $script:CarapaceCoreReady = $true
  } catch {
    Write-Verbose "Carapace init failed: $_"
  }
}

# Register a lightweight stub that loads a command’s completion on first Tab
function Register-LazyCarapaceCompleter {
  param([Parameter(Mandatory)][string]$CommandName)

  if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) { return }

  $flagName = "${CommandName}CarapaceLoaded"

  Register-ArgumentCompleter -CommandName $CommandName -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    # Inject Carapace core once
    Initialize-CarapaceCompletion

    # Wire the specific command’s completion the first time Tab is pressed
    if (-not (Get-Variable -Name $flagName -Scope Script -ErrorAction SilentlyContinue)) {
      try {
        carapace $CommandName powershell | Out-String | Invoke-Expression
        Set-Variable -Name $flagName -Scope Script -Value $true
      } catch {
        Write-Verbose "Failed to load carapace completion for '$CommandName': $_"
      }
    }

    # Stub returns no items; real completer takes effect on the next Tab
    [System.Management.Automation.CompletionResult[]]@()
  }
}

# Register stubs for commands you use (adjust list as desired)
@(
  'git'
  'gh'
  'chezmoi'
  'cargo'
  'go'
  'python'
  'pip'
  'chezmoi'
  'fastfetch'
  'jq'
  'eza'
  'rg'
  'bat'
  'batman'
  'just'
  'scp'
  'typst'
  'wezterm'
  'jj'
  'ollama'
) | ForEach-Object {
  Register-LazyCarapaceCompleter -CommandName $_
}

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

Sets up the Visual Studio 2022 development environment in the current PowerShell 7 session using vsdevcmd.bat.

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
        "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\vsdevcmd.bat",
        "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\vsdevcmd.bat",
        "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\vsdevcmd.bat"
    )

    $vsdevcmd = $vsPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $vsdevcmd) {
        Write-Error "❌ vsdevcmd.bat not found. Please ensure Visual Studio 2022 is installed."
        return
    }

    Write-Host "✅ Found vsdevcmd.bat at: $vsdevcmd"
    Write-Host "📦 Setting up environment for architecture: $Arch"

    cmd /c "`"$vsdevcmd`" -arch=$Arch -no_logo && set" | ForEach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
        }
    }

    Write-Host "✅ Environment variables set for Visual Studio 2022 ($Arch)."
}

function Set-Wallpaper { param($PathToImg)
  if (-not $script:Win32SPI) {
    $script:Win32SPI = Add-Type -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, string pvParam, uint fWinIni);
"@ -Name "NativeMethods" -Namespace Win32 -PassThru
  }
  [Win32.NativeMethods]::SystemParametersInfo(20, 0, $PathToImg, 0x01) | Out-Null
}

Set-Alias clang-build "$HOME\Documents\PowerShell\Scripts\clang-build.ps1"
Set-Alias Download-Windows-Debug-Symbols "$HOME\Documents\PowerShell\Scripts\download-windows-debug-symbols.ps1"

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
