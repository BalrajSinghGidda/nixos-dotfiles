{
  pkgs,
  inputs,
  ...
}: {
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;
  home.packages = with pkgs; [
    firefox
    pavucontrol
    brightnessctl
    grim
    slurp
    wl-clipboard
    caligula
    tmux
    zellij
    ripgrep
    fd
    nil
    nixpkgs-fmt
  ];
  programs.dsearch = {
    enable = true;
    package = inputs.danksearch.packages.${pkgs.stdenv.hostPlatform.system}.dsearch.overrideAttrs (_: {
      vendorHash = "sha256-scvZWbMHAhpYWCU0xZK1E6h6sAkoXegqI1iYS44fcCg=";
    });
  };
}
