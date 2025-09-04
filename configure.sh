#!/bin/bash

# Rust Project Template Configuration Script
# This script replaces template variables with actual values

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${1}${2}${NC}\n"
}

print_success() {
    print_color $GREEN "✅ $1"
}

print_warning() {
    print_color $YELLOW "⚠️  $1"
}

print_error() {
    print_color $RED "❌ $1"
}

print_info() {
    print_color $BLUE "ℹ️  $1"
}

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    print_warning "Not in a git repository. Initializing git..."
    git init
fi

# Collect information from user
print_info "Configuring your Rust project template..."
echo

# Project name (default to current directory name)
DEFAULT_PROJECT_NAME=$(basename "$(pwd)")
read -p "Project name [$DEFAULT_PROJECT_NAME]: " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-$DEFAULT_PROJECT_NAME}

# Validate project name (Rust package names must be lowercase and can contain hyphens)
if [[ ! "$PROJECT_NAME" =~ ^[a-z][a-z0-9_-]*$ ]]; then
    print_error "Project name must start with a letter and contain only lowercase letters, numbers, hyphens, and underscores"
    exit 1
fi

# Author information
read -p "Author name: " AUTHOR_NAME
read -p "Author email: " AUTHOR_EMAIL

# GitHub information
read -p "GitHub username: " GITHUB_USERNAME

# Project description
read -p "Project description: " PROJECT_DESCRIPTION

# Keywords for Cargo.toml
read -p "Keywords (comma-separated, max 5): " KEYWORDS_INPUT
IFS=',' read -ra KEYWORDS_ARRAY <<< "$KEYWORDS_INPUT"
KEYWORD1=""
KEYWORD2=""
KEYWORD3=""
if [ ${#KEYWORDS_ARRAY[@]} -gt 0 ]; then
    KEYWORD1=$(echo "${KEYWORDS_ARRAY[0]}" | xargs)
fi
if [ ${#KEYWORDS_ARRAY[@]} -gt 1 ]; then
    KEYWORD2=$(echo "${KEYWORDS_ARRAY[1]}" | xargs)
fi
if [ ${#KEYWORDS_ARRAY[@]} -gt 2 ]; then
    KEYWORD3=$(echo "${KEYWORDS_ARRAY[2]}" | xargs)
fi

# Categories for Cargo.toml
print_info "Common Rust categories: command-line-utilities, web-programming, game-development, network-programming, etc."
read -p "Categories (comma-separated, max 5): " CATEGORIES_INPUT
IFS=',' read -ra CATEGORIES_ARRAY <<< "$CATEGORIES_INPUT"
CATEGORY1=""
CATEGORY2=""
if [ ${#CATEGORIES_ARRAY[@]} -gt 0 ]; then
    CATEGORY1=$(echo "${CATEGORIES_ARRAY[0]}" | xargs)
fi
if [ ${#CATEGORIES_ARRAY[@]} -gt 1 ]; then
    CATEGORY2=$(echo "${CATEGORIES_ARRAY[1]}" | xargs)
fi

# Get current year
YEAR=$(date +%Y)

echo
print_info "Configuration summary:"
echo "Project name: $PROJECT_NAME"
echo "Author: $AUTHOR_NAME <$AUTHOR_EMAIL>"
echo "GitHub: $GITHUB_USERNAME"
echo "Description: $PROJECT_DESCRIPTION"
echo "Keywords: $KEYWORD1, $KEYWORD2, $KEYWORD3"
echo "Categories: $CATEGORY1, $CATEGORY2"
echo

read -p "Continue with these settings? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    print_warning "Configuration cancelled"
    exit 0
fi

# List of files to process
FILES=(
    "Cargo.toml"
    "README.md"
    "CHANGELOG.md"
    "CONTRIBUTING.md"
    "LICENSE-MIT"
    "LICENSE-APACHE"
    "flake.nix"
    "justfile"
    "src/main.rs"
    "src/lib.rs"
    ".github/workflows/ci.yml"
    ".github/workflows/release.yml"
    ".github/dependabot.yml"
)

print_info "Replacing template variables..."

# Function to replace variables in a file
replace_in_file() {
    local file="$1"
    if [ -f "$file" ]; then
        print_info "Processing $file"
        
        # Use different sed syntax for macOS vs Linux
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' \
                -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
                -e "s/{{AUTHOR_NAME}}/$AUTHOR_NAME/g" \
                -e "s/{{AUTHOR_EMAIL}}/$AUTHOR_EMAIL/g" \
                -e "s/{{GITHUB_USERNAME}}/$GITHUB_USERNAME/g" \
                -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION/g" \
                -e "s/{{KEYWORD1}}/$KEYWORD1/g" \
                -e "s/{{KEYWORD2}}/$KEYWORD2/g" \
                -e "s/{{KEYWORD3}}/$KEYWORD3/g" \
                -e "s/{{CATEGORY1}}/$CATEGORY1/g" \
                -e "s/{{CATEGORY2}}/$CATEGORY2/g" \
                -e "s/{{YEAR}}/$YEAR/g" \
                "$file"
        else
            # Linux
            sed -i \
                -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
                -e "s/{{AUTHOR_NAME}}/$AUTHOR_NAME/g" \
                -e "s/{{AUTHOR_EMAIL}}/$AUTHOR_EMAIL/g" \
                -e "s/{{GITHUB_USERNAME}}/$GITHUB_USERNAME/g" \
                -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION/g" \
                -e "s/{{KEYWORD1}}/$KEYWORD1/g" \
                -e "s/{{KEYWORD2}}/$KEYWORD2/g" \
                -e "s/{{KEYWORD3}}/$KEYWORD3/g" \
                -e "s/{{CATEGORY1}}/$CATEGORY1/g" \
                -e "s/{{CATEGORY2}}/$CATEGORY2/g" \
                -e "s/{{YEAR}}/$YEAR/g" \
                "$file"
        fi
    else
        print_warning "File $file not found, skipping"
    fi
}

# Process all files
for file in "${FILES[@]}"; do
    replace_in_file "$file"
done

print_success "Template variables replaced successfully!"

# Update the binary name in Cargo.toml to match project name
if [ -f "Cargo.toml" ]; then
    print_info "Updating binary name in Cargo.toml"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/name = \"{{PROJECT_NAME}}\"/name = \"$PROJECT_NAME\"/" Cargo.toml
    else
        sed -i "s/name = \"{{PROJECT_NAME}}\"/name = \"$PROJECT_NAME\"/" Cargo.toml
    fi
fi

# Clean up empty keywords/categories in Cargo.toml
if [ -f "Cargo.toml" ]; then
    print_info "Cleaning up Cargo.toml"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' \
            -e 's/, ""/g' \
            -e 's/"", //g' \
            -e 's/\[""\]//g' \
            -e 's/\[, /[/g' \
            -e 's/, \]/]/g' \
            Cargo.toml
    else
        sed -i \
            -e 's/, ""/g' \
            -e 's/"", //g' \
            -e 's/\[""\]//g' \
            -e 's/\[, /[/g' \
            -e 's/, \]/]/g' \
            Cargo.toml
    fi
fi

# Set up git hooks
print_info "Setting up git hooks"
mkdir -p .git/hooks
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
# Pre-commit hook to run checks
if command -v just >/dev/null 2>&1; then
    just check
else
    echo "Warning: 'just' not found, skipping pre-commit checks"
    echo "Install 'just' with: cargo install just"
fi
EOF
chmod +x .git/hooks/pre-commit

# Initialize/update git repository
print_info "Setting up git repository"
git add .
if git diff --cached --quiet; then
    print_info "No changes to commit"
else
    git commit -m "feat: initialize project from template

- Set up Rust project with modern tooling
- Add Nix development environment
- Configure GitHub Actions CI/CD
- Add comprehensive documentation
- Set up development tools (just, clippy, etc.)"
fi

# Final instructions
echo
print_success "🎉 Project template configured successfully!"
echo
print_info "Next steps:"
echo "1. Review and update the generated files as needed"
echo "2. Install development tools: just setup"
echo "3. Start development shell: nix develop (if using Nix)"
echo "4. Run tests: just test"
echo "5. Build project: just build"
echo "6. See all available commands: just --list"
echo
print_info "Don't forget to:"
echo "- Add your project to GitHub"
echo "- Configure branch protection rules"
echo "- Set up Codecov (optional)"
echo "- Add CARGO_REGISTRY_TOKEN secret for releases"
echo
print_success "Happy coding! 🦀"
