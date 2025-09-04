# Contributing to {{PROJECT_NAME}}

Thank you for your interest in contributing to {{PROJECT_NAME}}! This document provides guidelines and information for contributors.

## Code of Conduct

This project adheres to a code of conduct that we expect all contributors to follow. Please be respectful and constructive in all interactions.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, please include:

- A clear and descriptive title
- Steps to reproduce the problem
- Expected behavior
- Actual behavior
- Your environment (OS, Rust version, etc.)
- Any relevant logs or error messages

### Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- A clear and descriptive title
- A detailed description of the proposed feature
- Explanation of why this enhancement would be useful
- Possible implementation approaches (if you have ideas)

### Pull Requests

1. Fork the repository
2. Create a new branch for your feature or bugfix
3. Make your changes
4. Add tests for your changes
5. Ensure all tests pass: `just check`
6. Update documentation as needed
7. Create a pull request with a clear description

### Development Setup

See the [Development section](README.md#development) in the README for setup instructions.

### Coding Standards

- Follow Rust conventions and idioms
- Use `rustfmt` for formatting: `just fmt`
- Pass all clippy lints: `just clippy`
- Write tests for new functionality
- Update documentation for public APIs
- Follow conventional commit format for commit messages

#### Commit Message Format

```
type(scope): description

[optional body]

[optional footer(s)]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect code meaning (formatting, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to build process or auxiliary tools

### Testing

- Write unit tests for all new functions
- Add integration tests for new features
- Ensure all tests pass: `just test`
- Check test coverage: `just coverage`

### Documentation

- Document all public APIs with rustdoc comments
- Update README.md for user-facing changes
- Update CHANGELOG.md following Keep a Changelog format
- Include examples in documentation when helpful

## Release Process

Maintainers handle releases using this process:

1. Update version in `Cargo.toml`
2. Update `CHANGELOG.md`
3. Create and push a git tag: `git tag v0.x.y && git push origin v0.x.y`
4. GitHub Actions automatically builds and publishes the release

## Questions?

Feel free to open an issue for any questions about contributing!

## Attribution

This contributing guide is adapted from open source contribution best practices.
