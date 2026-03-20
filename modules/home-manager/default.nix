# Home Manager module aggregator
# This file imports all user-level configuration modules
{
  imports = [
    # Tool categories
    ./cli-tools.nix   # Command-line utilities
    ./gui-apps.nix    # GUI applications
    ./dev-tools.nix   # Development tools and languages
    
    # Program-specific configurations
    ./programs/gemini-cli.nix  # Gemini AI CLI
    
    # Core configurations
    ./git.nix    # Git and GitHub configuration
    ./shell.nix  # Shell environment (bash)
  ];
}
