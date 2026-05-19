{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable DMS Greeter (Login System)
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
  };

  # Enable XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
