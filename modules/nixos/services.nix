{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable DMS Greeter (Login System)
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
  };

  # Ensure greetd is enabled so DMS greeter is started
  services.greetd.enable = true;
  services.greetd.settings.default_session.user = "greeter";
  # Ensure greetd launches DMS as the default session/greeter
  services.greetd.settings.default_session.command = "dms";

  # Enable XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
