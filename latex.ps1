<#
latex.ps1
Compile bukped.tex to bukped.pdf using pdflatex + bibtex.
Usage: run this script in PowerShell from the project folder, or double-click in Explorer.
Requires a TeX distribution (MiKTeX or TeX Live) with pdflatex and bibtex on PATH.
#>

Set-Location $PSScriptRoot

function Find-Program {
    param([string]$name)
    # Try Get-Command first (this works if it's on PATH already)
    $g = Get-Command $name -ErrorAction SilentlyContinue
    if ($g) { return $g.Source }
    $cmd = $null
    

    # Check common MiKTeX / TeX Live install paths
    $candidates = @(
        "C:\\Program Files\\MiKTeX\\miktex\\bin\\x64\\$name.exe",
        "C:\\Program Files\\MiKTeX\\miktex\\bin\\$name.exe",
        "$env:LOCALAPPDATA\\Programs\\MiKTeX\\miktex\\bin\\x64\\$name.exe",
        "C:\\texlive\\2026\\bin\\win32\\$name.exe",
        "C:\\texlive\\2025\\bin\\win32\\$name.exe",
        "C:\\texlive\\2024\\bin\\win32\\$name.exe"
    )
    foreach ($p in $candidates) { if (Test-Path $p) { return $p } }

    return $null
}

$pdflatexCmd = Find-Program pdflatex
$bibtexCmd = Find-Program bibtex

if (-not $pdflatexCmd -or -not $bibtexCmd) {
    Write-Error "pdflatex or bibtex not found. Try restarting the shell or ensure MiKTeX/TeX Live install put them on PATH."
    Write-Host "pdflatex found: $pdflatexCmd"
    Write-Host "bibtex found: $bibtexCmd"
    exit 1
}

Write-Host "Compiling bukped.tex -> bukped.pdf"

# Initial compile
& "$pdflatexCmd" -interaction=nonstopmode -halt-on-error bukped.tex

# Process bibliography (uses \bibliography{...} in the .tex file)
& "$bibtexCmd" bukped

# Finalize (run twice for proper cross-references)
& "$pdflatexCmd" -interaction=nonstopmode -halt-on-error bukped.tex
& "$pdflatexCmd" -interaction=nonstopmode -halt-on-error bukped.tex

if (Test-Path "bukped.pdf") {
    Write-Host "Success: bukped.pdf created in $PSScriptRoot"
} else {
    Write-Error "Compilation finished but bukped.pdf not found. Check log for errors."
}
