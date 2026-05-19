{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    matugen
    kitty
    wget
    nitch
    curl
    github-copilot-cli
    yazi
    gemini-cli
    lazygit
    gh
    vscodium
    blueman
    bluez
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    corefonts
    vista-fonts
  ];
}
