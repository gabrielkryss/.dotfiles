# Path to symchk.exe (adjust if installed elsewhere)
$symchkPath = "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe"

# Check if symchk exists
if (-not (Test-Path $symchkPath)) {
    Write-Error "symchk.exe not found at $symchkPath. Please install Debugging Tools for Windows (SDK/WDK)."
    exit 1
}

# Define cache folder
$cachePath = "C:\symbols"
if (-not (Test-Path $cachePath)) {
    New-Item -ItemType Directory -Path $cachePath | Out-Null
}

# Set global symbol path permanently
setx _NT_SYMBOL_PATH "srv*$cachePath*https://msdl.microsoft.com/download/symbols"

# List of core system DLLs
$modules = @(
    "$env:SystemRoot\System32\user32.dll",
    "$env:SystemRoot\System32\kernel32.dll",
    "$env:SystemRoot\System32\gdi32.dll",
    "$env:SystemRoot\System32\advapi32.dll",
    "$env:SystemRoot\System32\ntdll.dll"
)

# Download symbols
foreach ($m in $modules) {
    Write-Host "Downloading symbols for $m..."
    & $symchkPath /r $m /s srv*$cachePath*https://msdl.microsoft.com/download/symbols
}

# Final success message
Write-Host "✅ All requested symbols have been downloaded successfully into $cachePath."