{ pkgs, ... }:

{
  # Command-line tools and utilities
  home.packages = with pkgs; [
    # Code search and analysis
    ripgrep         # Fast grep alternative (rg)
    
    # File management
    yazi            # Terminal file manager
    eza             # Modern ls replacement
    zoxide          # Smart cd command
    
    # Nix development tools
    nil             # Nix language server
    nixpkgs-fmt     # Nix code formatter
  ];
}
