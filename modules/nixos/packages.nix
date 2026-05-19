{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    matugen
    kitty
    wget
    curl
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
