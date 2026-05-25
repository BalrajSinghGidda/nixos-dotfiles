{
  config,
  inputs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    kitty = "kitty";
    hypr = "hypr";
    qt5ct = "qt5ct";
    qt6ct = "qt6ct";
  };
in {
  imports = [
    inputs.dms.homeModules.default
  ];

  # Enable DankMaterialShell
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
  };

  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland compositor session";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
      Before = [ "graphical-session.target" ];
    };
  };

  # Out-of-store symlink for configs
  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  # old way:
  #  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/hypr/hyprland.conf";
}
