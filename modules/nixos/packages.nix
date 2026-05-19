{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    matugen
    kitty
    wget
    curl
    github-copilot-cli
    yazi
    gemini-cli
    lazygit
    gh
    vscodium
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
