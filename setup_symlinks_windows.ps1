param (
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "SilentlyContinue"

$dotfilesRoot = "D:\dev\.dotfiles" # path to repo.

if (-not (Test-Path $dotfilesRoot)) {
    Write-Host "❌ Dotfiles repo missing at $dotfilesRoot" -ForegroundColor Red
    exit 1
}

$symlinks = @(
    # PowerShell
    @{
        Target = "$dotfilesRoot\powershell\Microsoft.PowerShell_profile.ps1"
        # Link   = "$HOME\.config\powershell\Microsoft.PowerShell_profile.ps1"
        Link   = "$PROFILE"
    },

    # Neovim
    @{
        Target = "$dotfilesRoot\nvim\.config\LazyVim"
        Link   = "$HOME\AppData\Local\nvim"
    },

    # VsVim
    @{
        Target = "$dotfilesRoot\VsVim\_vimrc"
        Link   = "$HOME\_vimrc"
    },

    # # Windows Terminal, I'm okay copy pasting this one for now
    # @{
    #     Target = "$dotfilesRoot\settings.json"
    #     Link   = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    # },

    # Glzr, GlazeWM
    @{
        Target = "$dotfilesRoot\glzr\glazewm\config.yaml"
        Link   = "$HOME\.glzr\glazewm\config.yml"
    },

    # Glzr, GlazeWM and Zebar
    @{
        Target = "$dotfilesRoot\glzr\zebar\settings.json"
        Link   = "$HOME\.glzr\zebar\settings.json"
    },

    # WezTerm
    @{
        Target = "$dotfilesRoot\wezterm"
        Link   = "$HOME\.config\wezterm"
    },

    # Starship
    @{
        Target = "$dotfilesRoot\starship\starship.toml"
        Link   = "$HOME\.config\starship\starship.toml"
    },

    # Bash
    @{
        Target = "$dotfilesRoot\bash\.bashrc"
        Link   = "$HOME\.bashrc"
    },

    # Opencode
    @{
        Target = "$dotfilesRoot\opencode"
        Link   = "$HOME\.config\opencode"
    }

    # # Fish
    # @{
    #     Target = "$dotfilesRoot\fish"
    #     Link   = "$HOME\.config\fish"
    # },

    # # Nushell
    # @{
    #     Target = "$dotfilesRoot\nu"
    #     Link   = "$HOME\.config\nushell"
    # },

    # # Git Bash
    # @{
    #     Target = "$dotfilesRoot\git-bash-profile.sh"
    #     Link   = "$HOME\.bash_profile"
    # },

    # # Zellij
    # @{
    #     Target = "$dotfilesRoot\zellij"
    #     Link   = "$HOME\.config\zellij"
    # }
)

function Describe-Operation {
    param ($Target, $LinkPath)

    if (-not (Test-Path $Target)) {
        Write-Host "⚠️ [DryRun] Target missing: $Target" -ForegroundColor DarkYellow
        return
    }

    if (Test-Path $LinkPath) {
        $item = Get-Item $LinkPath
        if (-not $item.LinkType) {
            Write-Host "📦 [DryRun] Would backup and remove: $LinkPath" -ForegroundColor Yellow
        } else {
            Write-Host "🔁 [DryRun] Would remove existing symlink: $LinkPath" -ForegroundColor Gray
        }
    } else {
        Write-Host "🆕 [DryRun] Would create symlink: $LinkPath → $Target" -ForegroundColor Cyan
    }
}

function Link-Dotfile {
    param ($Target, $LinkPath)

    if (-not (Test-Path $Target)) {
        return @{ Success = $false; Message = "Target missing: $Target" }
    }

    if (Test-Path $LinkPath) {
        $item = Get-Item $LinkPath
        if (-not $item.LinkType) {
            Copy-Item $LinkPath "$LinkPath-backup" -Recurse -Force
            Remove-Item $LinkPath -Recurse -Force
        } else {
            Remove-Item $LinkPath -Force
        }
    }

    $link = New-Item -Path $LinkPath -ItemType SymbolicLink -Value $Target
    if (-not $link) {
        return @{ Success = $false; Message = "Failed: $LinkPath → $Target" }
    }

    return @{ Success = $true; Message = "Linked: $LinkPath → $Target" }
}

# 🧪 Dry-run mode
if ($DryRun) {
    Write-Host "`n🔍 DRY RUN — Previewing symlink actions..." -ForegroundColor Blue
    foreach ($entry in $symlinks) {
        Describe-Operation -Target $entry.Target -LinkPath $entry.Link
    }
    Write-Host "`n✅ Dry run completed. No changes made." -ForegroundColor Green
    exit 0
}

# 🚀 Actual execution mode
foreach ($entry in $symlinks) {
    $result = Link-Dotfile -Target $entry.Target -LinkPath $entry.Link
    $success = $result.Success
    $message = $result.Message

    if (-not $success) {
        Write-Host "❌ $message" -ForegroundColor Red
        exit 1
    } else {
        Write-Host "✅ $message" -ForegroundColor Green
    }
}

Write-Host "`n🎯 All symlinks created successfully!" -ForegroundColor Cyan
