{ config, inputs, ... }: {
  imports = [
    inputs.dms.homeModules.default
  ];

  # Enable DankMaterialShell
  programs.dank-material-shell = {
    enable = true;
    # Disable wallpaper handling to avoid pre-start script issues
    greeter.wallpaperPath = null;
  };

  # Out-of-store symlink for Hyprland config
  # This allows editing ~/nixos-dotfiles/config/hypr/hyprland.conf and seeing changes instantly
  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/hypr/hyprland.conf";
}
