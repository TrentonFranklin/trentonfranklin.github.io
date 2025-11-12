# serve.ps1 - convenience script to start a local HTTP server for this site
# Usage: In PowerShell run `.\serve.ps1` or
#        `powershell -ExecutionPolicy Bypass -File .\serve.ps1`
# The script will try `py -3` (Python launcher) then `python`. If neither is found
# it will fall back to opening index.html in your default browser.

$cwd = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location $cwd
$port = 8000

if (Get-Command py -ErrorAction SilentlyContinue) {
    Write-Host "Starting server with 'py -3 -m http.server $port'..."
    Start-Process -FilePath "py" -ArgumentList "-3 -m http.server $port"
    Write-Host "Server started (background). Open http://localhost:$port in your browser."
} elseif (Get-Command python -ErrorAction SilentlyContinue) {
    Write-Host "Starting server with 'python -m http.server $port'..."
    Start-Process -FilePath "python" -ArgumentList "-m http.server $port"
    Write-Host "Server started (background). Open http://localhost:$port in your browser."
} else {
    Write-Host "Python not found on PATH. Opening index.html in your default browser instead."
    Start-Process .\index.html
}
