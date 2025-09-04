# Rust Template Setup Instructions

Welcome to the Rust project template! This template provides a comprehensive setup for modern Rust development.

## Quick Start

### 1. Run Configuration Script

**On Unix/Linux/macOS:**
```bash
chmod +x configure.sh
./configure.sh
```

**On Windows:**
```powershell
.\configure.ps1
```

The script will prompt you for:
- Project name
- Author information
- GitHub username
- Project description
- Keywords and categories

### 2. Install Development Tools

```bash
# If using Nix (recommended)
nix develop

# Or manually install tools
just setup
```

### 3. Start Developing

```bash
# Run tests
just test

# Build project
just build

# See all available commands
just --list
```

## What's Included

### 🛠️ Development Environment
- **Nix Flake**: Reproducible development environment
- **Just**: Task runner for common development tasks
- **Rustfmt & Clippy**: Code formatting and linting
- **Pre-commit hooks**: Automatic code quality checks

### 🚀 CI/CD
- **GitHub Actions**: Automated testing, building, and releases
- **Multi-platform builds**: Linux, macOS, Windows
- **Automated releases**: Version tagging and artifact publishing
- **Security audits**: Dependency vulnerability scanning
- **Code coverage**: Integration with Codecov

### 📚 Documentation
- **Comprehensive README**: Usage, development, and contribution guidelines
- **Contributing guidelines**: Clear instructions for contributors
- **Changelog**: Keep a Changelog format
- **License**: Dual MIT/Apache-2.0 licensing

### 🔧 Configuration
- **Cargo.toml**: Optimized build profiles and metadata
- **Rustfmt**: Consistent code formatting
- **Clippy**: Comprehensive linting rules
- **Gitignore**: Sensible defaults for Rust projects
- **Dependabot**: Automated dependency updates

### 📁 Project Structure
```
your-project/
├── .github/           # GitHub workflows and configuration
├── src/               # Source code
│   ├── lib.rs        # Library code
│   └── main.rs       # Binary entry point
├── Cargo.toml        # Package configuration
├── flake.nix         # Nix development environment
├── justfile          # Task runner configuration
└── configure.*       # Setup scripts
```

Optional directories (created as needed):
- `tests/` - Integration tests (`just new-test <name>`)
- `examples/` - Usage examples (`just new-example <name>`)
- `benches/` - Benchmark tests (`just new-bench <name>`)

## Features

### Modern Rust Practices
- **Edition 2021**: Latest Rust edition
- **MSRV**: Minimum Supported Rust Version (1.70.0)
- **Optimized builds**: Release profile tuned for performance
- **Security**: Regular security audits via GitHub Actions

### Developer Experience
- **Fast feedback**: Watch mode for tests and builds
- **Code quality**: Automated formatting and linting
- **Documentation**: Built-in documentation generation
- **Examples**: Runnable examples for users

### Production Ready
- **Cross-platform**: Builds for major platforms
- **Containerization**: Docker support (optional)
- **Monitoring**: Structured logging support
- **Configuration**: Multiple config file formats

## Available Commands (Just)

```bash
just --list              # Show all available commands
just run                 # Run the project
just test                # Run tests
just test-watch          # Run tests in watch mode
just build               # Build the project
just build-release       # Build optimized release
just fmt                 # Format code
just clippy              # Run lints
just check               # Run all checks (fmt + clippy + test)
just fix                 # Auto-fix issues
just dev                 # Development mode (auto-restart)
just docs                # Generate documentation
just audit               # Security audit
just update              # Update dependencies
just clean               # Clean build artifacts

# Create new components as needed
just new-bin <name>      # Create new binary target
just new-lib <name>      # Create new library module
just new-example <name>  # Create new example (creates examples/ dir)
just new-test <name>     # Create new integration test (creates tests/ dir)
just new-bench <name>    # Create new benchmark (creates benches/ dir)
```

## GitHub Setup

After running the configuration script:

1. **Create GitHub repository**
2. **Push your code:**
   ```bash
   git remote add origin https://github.com/USERNAME/PROJECT_NAME.git
   git push -u origin main
   ```

3. **Set up secrets for releases:**
   - Go to Settings > Secrets and variables > Actions
   - Add `CARGO_REGISTRY_TOKEN` with your crates.io token

4. **Configure branch protection (optional):**
   - Require PR reviews
   - Require status checks
   - Dismiss stale reviews

## Customization

### Adding Dependencies
Edit `Cargo.toml` and uncomment commonly used dependencies:
```toml
[dependencies]
anyhow = "1.0"           # Error handling
clap = { version = "4.0", features = ["derive"] }  # CLI parsing
serde = { version = "1.0", features = ["derive"] }  # Serialization
```

### Modifying CI/CD
Edit `.github/workflows/ci.yml` and `.github/workflows/release.yml` as needed.

### Customizing Development Environment
Modify `flake.nix` to add or remove development tools.

### Adding New Tasks
Edit `justfile` to add project-specific development tasks.

## Publishing

### To Crates.io
1. Update version in `Cargo.toml`
2. Update `CHANGELOG.md`
3. Create a git tag: `just release X.Y.Z`
4. GitHub Actions will automatically publish to crates.io

### Manual Publishing
```bash
cargo publish --dry-run  # Test the publication
cargo publish            # Publish to crates.io
```

## Support

- 📖 [Rust Book](https://doc.rust-lang.org/book/)
- 🦀 [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- 💬 [Rust Community Discord](https://discord.gg/rust-lang)
- 🧰 [Awesome Rust](https://github.com/rust-unofficial/awesome-rust)

## Next Steps

1. Review and customize the generated files
2. Add your actual project logic to `src/`
3. Write tests in `tests/` and `src/`
4. Add examples in `examples/`
5. Update documentation as your project grows
6. Consider adding benchmarks in `benches/`

Happy coding with Rust! 🦀
