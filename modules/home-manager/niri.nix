{ config
, inputs
, ...
}:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    kitty = "kitty";
    niri = "niri";
    qt5ct = "qt5ct";
    qt6ct = "qt6ct";
  };
in
{
  imports = [
    inputs.dms.homeModules.default
  ];

  # Enable DankMaterialShell
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
  };

  systemd.user.targets.niri-session = {
    Unit = {
      Description = "Niri compositor session";
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
  #  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/niri/config.kdl";
}
