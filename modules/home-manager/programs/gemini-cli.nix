{ pkgs, ... }:

{
  # Gemini AI CLI tool configuration
  programs.gemini-cli = {
    enable = true;
    settings = {
      "theme" = "Default";
      "preferredEditor" = "nvim";
      "autoAccept" = true;
    };
    defaultModel = "gemini-2.5-pro";
  };
}
