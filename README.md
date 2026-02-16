# LaTeX Template Laporan - Setup Guide

This guide follows the instructions for setting up a LaTeX report template using the Antigravity application with vscode-pdf extension.

## Prerequisites Setup

### 1. Install R (Step 1) - OPTIONAL
- Download R from: https://cran.r-project.org/bin/windows/base/
- Install R following the installer prompts

### 2. Install LaTeX Distribution (Step 2) - REQUIRED
Choose ONE of these options:

#### Option A: TinyTeX via R (Original Method)
After installing R, run the setup script:
```r
# Open R or RStudio and run:
source("setup-latex.R")
```

Or manually run these commands in R:
```r
install.packages('tinytex')
tinytex::install_tinytex()

# Check installation:
tinytex::tinytex_root()
tinytex::tlmgr("--version")
```

#### Option B: Direct TinyTeX Installation (Easier)
1. Download TinyTeX from: https://github.com/rstudio/tinytex-releases/releases
2. Download the Windows installer (.exe file)
3. Run the installer and follow the prompts
4. Restart your terminal/PowerShell

#### Option C: MiKTeX Installation (Alternative)
1. Download MiKTeX from: https://miktex.org/download
2. Or use winget: `winget install MiKTeX.MiKTeX`
3. Install and restart your terminal

### 3. Install LaTeX Packages (Step 3)
Run the PowerShell script to install required packages:
```powershell
.\install-packages.ps1
```

### 4. Git SCM and GitHub Connection (Step 4) 
✅ Git is already configured in this project (`.git` folder detected)

### 5. Install VS Code Extensions (Step 5)
Install the following extensions:
- Antigravity
- vscode-pdf

## Usage

### Compiling LaTeX Documents
To compile your LaTeX document, run:
```powershell
.\compile-latex.ps1
```

This script automatically performs:
1. `pdflatex` for initial compilation  
2. `bibtex` for processing references
3. `pdflatex` twice more for finalizing cross-references

### File Structure
- **Main file:** `bukped.tex`
- **Content:** Add your report content in the `chapters/` folder
- **Output:** `bukped.pdf`

## Next Steps
1. Install R from the opened browser tab
2. Run `setup-latex.R` in R
3. Run `install-packages.ps1` in PowerShell
4. Install required VS Code extensions
5. Start writing your LaTeX report!