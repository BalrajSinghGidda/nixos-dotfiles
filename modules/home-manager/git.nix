{ pkgs, ... }:

{
  # Git version control configuration
  programs.git = {
    enable = true;
    # IMPORTANT: Change these to your own details!
    settings = {
      user.name = "BalrajSinghGidda";
      user.email = "anonystargamerz@gmail.com";
    };
  };

  # GitHub CLI configuration
  programs.gh = {
    enable = true;
    # Use gh as git credential helper
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";  # Use HTTPS for git operations (change to "ssh" if you prefer)
      prompt = "enabled";      # Enable interactive prompts
      editor = "nvim";         # Default editor for gh commands
    };
  };
}