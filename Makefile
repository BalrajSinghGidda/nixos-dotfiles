.PHONY: help switch test build update clean check fmt

# Default target
help:
	@echo "NixOS Dotfiles - Available Commands"
	@echo ""
	@echo "  make switch      - Build and switch to new configuration"
	@echo "  make test        - Build and test configuration (doesn't activate)"
	@echo "  make build       - Build configuration without activating"
	@echo "  make update      - Update flake.lock dependencies"
	@echo "  make clean       - Clean old generations"
	@echo "  make check       - Check flake and run basic validation"
	@echo "  make fmt         - Format all Nix files"
	@echo ""

# Apply configuration
switch:
	sudo nixos-rebuild switch --flake .#nixos-btw

# Test configuration without switching
test:
	sudo nixos-rebuild test --flake .#nixos-btw

# Build configuration
build:
	sudo nixos-rebuild build --flake .#nixos-btw

# Update flake dependencies
update:
	nix flake update
	@echo "Dependencies updated. Run 'make switch' to apply."

# Clean old generations (keeps last 3)
clean:
	@echo "Cleaning old system generations..."
	sudo nix-collect-garbage --delete-older-than 7d
	@echo "Done!"

# Validate flake
check:
	nix flake check
	@echo "Flake validation passed!"

# Format Nix files
fmt:
	nixpkgs-fmt flake.nix
	nixpkgs-fmt modules/**/*.nix
	nixpkgs-fmt hosts/**/*.nix
	@echo "All Nix files formatted!"
