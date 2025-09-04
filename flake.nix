{
  description = "{{PROJECT_NAME}} - A Rust project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rustfmt" "clippy" "rust-analyzer" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            just
            cargo-watch
            cargo-edit
            cargo-audit
            cargo-outdated
            cargo-expand
            bacon
            git
            
            # Development tools
            fd
            ripgrep
            
            # Optional: database tools if needed
            # postgresql
            # sqlite
            
            # Optional: additional tools
            # docker
            # kubectl
          ];

          env = {
            RUST_BACKTRACE = "1";
            RUST_LOG = "debug";
          };

          shellHook = ''
            echo "🦀 Welcome to {{PROJECT_NAME}} development environment!"
            echo "Available commands:"
            echo "  just --list    # Show available recipes"
            echo "  cargo --help   # Rust package manager"
            echo "  bacon          # Background code checker"
            echo ""
            echo "Rust version: $(rustc --version)"
          '';
        };
      });
}
