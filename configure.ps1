# Rust Project Template Configuration Script (PowerShell)
# This script replaces template variables with actual values

param(
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Rust Project Template Configuration Script

This script configures your Rust project template by replacing placeholder
variables with actual values.

Usage: .\configure.ps1

The script will prompt you for:
- Project name
- Author information
- GitHub username
- Project description
- Keywords and categories

After configuration, it will:
- Replace all template variables in files
- Set up git repository and hooks
- Provide next steps for development
"@
    exit 0
}

# Colors for output
function Write-Success { param($Message) Write-Host "✅ $Message" -ForegroundColor Green }
function Write-Warning { param($Message) Write-Host "⚠️  $Message" -ForegroundColor Yellow }
function Write-Error { param($Message) Write-Host "❌ $Message" -ForegroundColor Red }
function Write-Info { param($Message) Write-Host "ℹ️  $Message" -ForegroundColor Blue }

# Check if we're in a git repository
if (!(Test-Path ".git")) {
    Write-Warning "Not in a git repository. Initializing git..."
    git init
}

# Collect information from user
Write-Info "Configuring your Rust project template..."
Write-Host ""

# Project name (default to current directory name)
$DefaultProjectName = Split-Path -Leaf (Get-Location)
$ProjectName = Read-Host "Project name [$DefaultProjectName]"
if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    $ProjectName = $DefaultProjectName
}

# Validate project name
if ($ProjectName -notmatch '^[a-z][a-z0-9_-]*$') {
    Write-Error "Project name must start with a letter and contain only lowercase letters, numbers, hyphens, and underscores"
    exit 1
}

# Author information
$AuthorName = Read-Host "Author name"
$AuthorEmail = Read-Host "Author email"

# GitHub information
$GitHubUsername = Read-Host "GitHub username"

# Project description
$ProjectDescription = Read-Host "Project description"

# Keywords for Cargo.toml
$KeywordsInput = Read-Host "Keywords (comma-separated, max 5)"
$KeywordsArray = $KeywordsInput -split ',' | ForEach-Object { $_.Trim() }
$Keyword1 = if ($KeywordsArray.Count -gt 0) { $KeywordsArray[0] } else { "" }
$Keyword2 = if ($KeywordsArray.Count -gt 1) { $KeywordsArray[1] } else { "" }
$Keyword3 = if ($KeywordsArray.Count -gt 2) { $KeywordsArray[2] } else { "" }

# Categories for Cargo.toml
Write-Info "Common Rust categories: command-line-utilities, web-programming, game-development, network-programming, etc."
$CategoriesInput = Read-Host "Categories (comma-separated, max 5)"
$CategoriesArray = $CategoriesInput -split ',' | ForEach-Object { $_.Trim() }
$Category1 = if ($CategoriesArray.Count -gt 0) { $CategoriesArray[0] } else { "" }
$Category2 = if ($CategoriesArray.Count -gt 1) { $CategoriesArray[1] } else { "" }

# Get current year
$Year = (Get-Date).Year

Write-Host ""
Write-Info "Configuration summary:"
Write-Host "Project name: $ProjectName"
Write-Host "Author: $AuthorName <$AuthorEmail>"
Write-Host "GitHub: $GitHubUsername"
Write-Host "Description: $ProjectDescription"
Write-Host "Keywords: $Keyword1, $Keyword2, $Keyword3"
Write-Host "Categories: $Category1, $Category2"
Write-Host ""

$Confirm = Read-Host "Continue with these settings? (y/N)"
if ($Confirm -notmatch '^[Yy]$') {
    Write-Warning "Configuration cancelled"
    exit 0
}

# List of files to process
$Files = @(
    "Cargo.toml",
    "README.md",
    "CHANGELOG.md",
    "CONTRIBUTING.md",
    "LICENSE-MIT",
    "LICENSE-APACHE",
    "flake.nix",
    "justfile",
    "src\main.rs",
    "src\lib.rs",
    ".github\workflows\ci.yml",
    ".github\workflows\release.yml",
    ".github\dependabot.yml"
)

Write-Info "Replacing template variables..."

# Function to replace variables in a file
function Replace-InFile {
    param($FilePath)
    
    if (Test-Path $FilePath) {
        Write-Info "Processing $FilePath"
        
        $Content = Get-Content $FilePath -Raw
        $Content = $Content -replace '\{\{PROJECT_NAME\}\}', $ProjectName
        $Content = $Content -replace '\{\{AUTHOR_NAME\}\}', $AuthorName
        $Content = $Content -replace '\{\{AUTHOR_EMAIL\}\}', $AuthorEmail
        $Content = $Content -replace '\{\{GITHUB_USERNAME\}\}', $GitHubUsername
        $Content = $Content -replace '\{\{PROJECT_DESCRIPTION\}\}', $ProjectDescription
        $Content = $Content -replace '\{\{KEYWORD1\}\}', $Keyword1
        $Content = $Content -replace '\{\{KEYWORD2\}\}', $Keyword2
        $Content = $Content -replace '\{\{KEYWORD3\}\}', $Keyword3
        $Content = $Content -replace '\{\{CATEGORY1\}\}', $Category1
        $Content = $Content -replace '\{\{CATEGORY2\}\}', $Category2
        $Content = $Content -replace '\{\{YEAR\}\}', $Year
        
        Set-Content $FilePath -Value $Content -NoNewline
    } else {
        Write-Warning "File $FilePath not found, skipping"
    }
}

# Process all files
foreach ($File in $Files) {
    Replace-InFile $File
}

Write-Success "Template variables replaced successfully!"

# Clean up empty keywords/categories in Cargo.toml
if (Test-Path "Cargo.toml") {
    Write-Info "Cleaning up Cargo.toml"
    $CargoContent = Get-Content "Cargo.toml" -Raw
    $CargoContent = $CargoContent -replace ', ""', ''
    $CargoContent = $CargoContent -replace '"", ', ''
    $CargoContent = $CargoContent -replace '\[""\]', ''
    $CargoContent = $CargoContent -replace '\[, ', '['
    $CargoContent = $CargoContent -replace ', \]', ']'
    Set-Content "Cargo.toml" -Value $CargoContent -NoNewline
}

# Set up git hooks
Write-Info "Setting up git hooks"
$HooksDir = ".git\hooks"
if (!(Test-Path $HooksDir)) {
    New-Item -ItemType Directory -Path $HooksDir -Force | Out-Null
}

$PreCommitHook = @'
#!/bin/sh
# Pre-commit hook to run checks
if command -v just >/dev/null 2>&1; then
    just check
else
    echo "Warning: 'just' not found, skipping pre-commit checks"
    echo "Install 'just' with: cargo install just"
fi
'@

Set-Content "$HooksDir\pre-commit" -Value $PreCommitHook

# Make hook executable (if on Unix-like system via WSL/Git Bash)
if (Get-Command chmod -ErrorAction SilentlyContinue) {
    chmod +x "$HooksDir\pre-commit"
}

# Initialize/update git repository
Write-Info "Setting up git repository"
git add .
$GitStatus = git status --porcelain
if ($GitStatus) {
    git commit -m @"
feat: initialize project from template

- Set up Rust project with modern tooling
- Add Nix development environment
- Configure GitHub Actions CI/CD
- Add comprehensive documentation
- Set up development tools (just, clippy, etc.)
"@
} else {
    Write-Info "No changes to commit"
}

# Final instructions
Write-Host ""
Write-Success "🎉 Project template configured successfully!"
Write-Host ""
Write-Info "Next steps:"
Write-Host "1. Review and update the generated files as needed"
Write-Host "2. Install development tools: just setup"
Write-Host "3. Start development shell: nix develop (if using Nix)"
Write-Host "4. Run tests: just test"
Write-Host "5. Build project: just build"
Write-Host "6. See all available commands: just --list"
Write-Host ""
Write-Info "Don't forget to:"
Write-Host "- Add your project to GitHub"
Write-Host "- Configure branch protection rules"
Write-Host "- Set up Codecov (optional)"
Write-Host "- Add CARGO_REGISTRY_TOKEN secret for releases"
Write-Host ""
Write-Success "Happy coding! 🦀"
