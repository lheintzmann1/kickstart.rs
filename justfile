# {{PROJECT_NAME}} - Development recipes
# Run `just --list` to see all available recipes

# Default task: list all available commands
default:
    @just --list

# Install development dependencies
setup:
    @echo "Setting up development environment..."
    rustup update
    rustup component add rustfmt clippy rust-analyzer
    cargo install cargo-watch cargo-edit cargo-audit cargo-outdated cargo-expand bacon

# Run the project
run *ARGS:
    cargo run {{ARGS}}

# Build the project
build:
    cargo build

# Build for release
build-release:
    cargo build --release

# Generate code coverage (requires cargo-tarpaulin)
coverage:
    cargo tarpaulin --out html

# Benchmark (if you have bench tests)
bench:
    @if [ -d "benches" ]; then cargo bench; else echo "No benches/ directory found. Create it first with: just new-bench <name>"; fi

# Run tests
test:
    cargo test

# Run tests with output
test-verbose:
    cargo test -- --nocapture

# Run tests in watch mode
test-watch:
    cargo watch -x test

# Format code
fmt:
    cargo fmt

# Check formatting
fmt-check:
    cargo fmt --check

# Run clippy lints
clippy:
    cargo clippy -- -D warnings

# Run clippy for all targets
clippy-all:
    cargo clippy --all-targets -- -D warnings

# Fix clippy issues automatically
clippy-fix:
    cargo clippy --fix --allow-dirty --allow-staged

# Run all checks (format, clippy, test)
check: fmt-check clippy test

# Auto-fix issues
fix: fmt clippy-fix

# Clean build artifacts
clean:
    cargo clean

# Update dependencies
update:
    cargo update

# Check for outdated dependencies
outdated:
    cargo outdated

# Security audit
audit:
    cargo audit

# Generate documentation
docs:
    cargo doc --open

# Generate documentation without opening
docs-build:
    cargo doc

# Run with watch mode (auto-restart on changes)
dev:
    cargo watch -x run

# Run bacon (background code checker)
bacon:
    bacon

# Expand macros for debugging
expand *TARGET:
    cargo expand {{TARGET}}

# Check code coverage (requires cargo-tarpaulin)
coverage:
    cargo tarpaulin --out html

# Benchmark (if you have bench tests)
bench:
    cargo bench

# Install the binary locally
install:
    cargo install --path .

# Create a new release (tags and pushes)
release VERSION:
    @echo "Creating release {{VERSION}}"
    git tag -a "v{{VERSION}}" -m "Release v{{VERSION}}"
    git push origin "v{{VERSION}}"

# Docker build (if Dockerfile exists)
docker-build:
    docker build -t {{PROJECT_NAME}} .

# Docker run
docker-run:
    docker run --rm -it {{PROJECT_NAME}}

# Initialize git hooks
git-hooks:
    @echo "Setting up git hooks..."
    echo '#!/bin/sh\njust check' > .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit

# Create a new binary target
new-bin NAME:
    @echo "Creating new binary: {{NAME}}"
    mkdir -p src/bin
    echo 'fn main() {\n    println!("Hello from {{NAME}}!");\n}' > src/bin/{{NAME}}.rs
    @echo "Created src/bin/{{NAME}}.rs"
    @echo "Run with: cargo run --bin {{NAME}}"

# Create a new library module
new-lib NAME:
    @echo "Creating new library module: {{NAME}}"
    echo 'pub mod {{NAME}};' >> src/lib.rs || echo 'pub mod {{NAME}};' > src/lib.rs
    echo '//! {{NAME}} module\n\npub fn hello() {\n    println!("Hello from {{NAME}} module!");\n}' > src/{{NAME}}.rs
    @echo "Created src/{{NAME}}.rs and updated lib.rs"

# Create a new example
new-example NAME:
    @echo "Creating new example: {{NAME}}"
    mkdir -p examples
    echo '//! {{NAME}} example\n\nfn main() {\n    println!("Hello from {{NAME}} example!");\n}' > examples/{{NAME}}.rs
    @echo "Created examples/{{NAME}}.rs"
    @echo "Run with: cargo run --example {{NAME}}"

# Create a new benchmark
new-bench NAME:
    @echo "Creating new benchmark: {{NAME}}"
    mkdir -p benches
    echo '//! {{NAME}} benchmark\n\nfn main() {\n    println!("Running {{NAME}} benchmark...");\n    // Add your benchmark code here\n}' > benches/{{NAME}}.rs
    @echo "Created benches/{{NAME}}.rs"
    @echo "Run with: cargo run --bin {{NAME}} or add criterion for proper benchmarks"

# Create a new integration test
new-test NAME:
    @echo "Creating new integration test: {{NAME}}"
    mkdir -p tests
    echo '//! {{NAME}} integration test\n\n#[test]\nfn test_{{NAME}}() {\n    // Add your integration test here\n    assert!(true);\n}' > tests/{{NAME}}.rs
    @echo "Created tests/{{NAME}}.rs"
    @echo "Run with: cargo test"
