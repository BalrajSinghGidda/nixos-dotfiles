{ pkgs
, inputs
, ...
}: {
  services.kdeconnect.enable = true;
  services.kdeconnect.indicator = true;

  home.packages = with pkgs; [
    # --- Wayland & Screenshot Tools ---
    grim
    slurp
    wl-clipboard
    brightnessctl
    pavucontrol

    # --- CLI & Terminal Utilities ---
    tmux
    zellij
    ripgrep
    fd

    # --- Nix & Development Tools ---
    nil
    nixpkgs-fmt
    caligula
  ];

  programs.dsearch = {
    enable = true;
    package = inputs.danksearch.packages.${pkgs.stdenv.hostPlatform.system}.dsearch.overrideAttrs (_: {
      vendorHash = "sha256-Gq3tVwe39m5KGfkI3DEnQEQEGs/cLDCiwx6XFM61f6c=";
    });
  };
}
