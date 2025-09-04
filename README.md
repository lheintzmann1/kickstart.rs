# {{PROJECT_NAME}}

{{PROJECT_DESCRIPTION}}

[![CI](https://github.com/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}/branch/main/graph/badge.svg)](https://codecov.io/gh/{{GITHUB_USERNAME}}/{{PROJECT_NAME}})
[![Crates.io](https://img.shields.io/crates/v/{{PROJECT_NAME}}.svg)](https://crates.io/crates/{{PROJECT_NAME}})
[![Documentation](https://docs.rs/{{PROJECT_NAME}}/badge.svg)](https://docs.rs/{{PROJECT_NAME}})
[![License: MIT OR Apache-2.0](https://img.shields.io/badge/License-MIT%20OR%20Apache--2.0-blue.svg)](LICENSE)
[![MSRV](https://img.shields.io/badge/MSRV-1.70.0-blue.svg)](https://github.com/rust-lang/rust/releases/tag/1.70.0)

## Features

- 🚀 **Fast**: Built with Rust for maximum performance
- 🛡️ **Safe**: Memory safety guaranteed by Rust's type system
- 🔧 **Configurable**: Highly customizable via configuration files
- 📦 **Lightweight**: Minimal dependencies and small binary size
- 🌐 **Cross-platform**: Works on Linux, macOS, and Windows

## Installation

### From Crates.io

```bash
cargo install {{PROJECT_NAME}}
```

### From Source

```bash
git clone https://github.com/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}
cd {{PROJECT_NAME}}
cargo install --path .
```

### Using Nix

```bash
nix develop  # Enter development shell
# or
nix run github:{{GITHUB_USERNAME}}/{{PROJECT_NAME}}
```

## Usage

### Basic Usage

```bash
{{PROJECT_NAME}} --help
```

### Examples

```bash
# Example command
{{PROJECT_NAME}} --input file.txt --output result.txt

# With verbose logging
RUST_LOG=debug {{PROJECT_NAME}} --verbose
```

## Development

This project uses modern Rust development tools and practices.

### Prerequisites

- Rust 1.70.0 or later
- [Just](https://github.com/casey/just) for task running
- [Nix](https://nixos.org/download.html) (optional, for development shell)

### Development Environment

#### Using Nix (Recommended)

```bash
# Enter development shell with all tools
nix develop

# Or use direnv for automatic activation
echo "use flake" > .envrc
direnv allow
```

#### Manual Setup

```bash
# Install development dependencies
just setup

# Or manually:
rustup component add rustfmt clippy rust-analyzer
cargo install cargo-watch cargo-edit cargo-audit cargo-outdated bacon
```

### Common Development Tasks

```bash
# Show all available commands
just

# Run the project
just run

# Run tests
just test

# Run tests in watch mode
just test-watch

# Format code
just fmt

# Run lints
just clippy

# Run all checks (format, lint, test)
just check

# Auto-fix issues
just fix

# Development mode (auto-restart on changes)
just dev

# Background code checking
just bacon
```

### Project Structure

```
{{PROJECT_NAME}}/
├── .github/           # GitHub workflows and templates
│   ├── workflows/     # CI/CD pipelines
│   └── dependabot.yml # Dependency update configuration
├── src/               # Source code
│   ├── main.rs       # Application entry point
│   └── lib.rs        # Library code
├── Cargo.toml        # Rust package configuration
├── flake.nix         # Nix development environment
├── justfile          # Task runner configuration
├── .gitignore        # Git ignore rules
└── README.md         # This file
```

Additional directories can be created as needed:
- `tests/` - Integration tests (`just new-test <name>`)
- `examples/` - Usage examples (`just new-example <name>`)  
- `benches/` - Benchmarks (`just new-bench <name>`)
- `docs/` - Additional documentation

### Testing

```bash
# Run all tests
just test

# Run with coverage
just coverage

# Run benchmarks
just bench

# Security audit
just audit
```

### Release Process

1. Update version in `Cargo.toml`
2. Update `CHANGELOG.md`
3. Create a git tag: `just release X.Y.Z`
4. GitHub Actions will automatically build and publish the release

## Configuration

{{PROJECT_NAME}} can be configured via:

- Command line arguments
- Environment variables
- Configuration files (TOML, JSON, YAML)

### Example Configuration

```toml
# config.toml
[general]
verbose = true
output_format = "json"

[feature]
enabled = true
timeout = 30
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Workflow

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `just check`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

### Code Style

This project uses:
- `rustfmt` for code formatting
- `clippy` for linting
- Conventional commits for commit messages

## License

This project is licensed under either of

- Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or https://www.apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or https://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed changelog.

## Support

- 📖 [Documentation](https://docs.rs/{{PROJECT_NAME}})
- 🐛 [Issue Tracker](https://github.com/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}/issues)
- 💬 [Discussions](https://github.com/{{GITHUB_USERNAME}}/{{PROJECT_NAME}}/discussions)

## Acknowledgments

- Thanks to all contributors
- Built with [Rust](https://www.rust-lang.org/)
- Uses [Nix](https://nixos.org/) for development environment
- Task running with [Just](https://github.com/casey/just)
