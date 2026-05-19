{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    pavucontrol
    brightnessctl
    grim
    slurp
    wl-clipboard
    tmux
    zellij
    ripgrep
    fd
    nil
    nixpkgs-fmt
  ];
}
