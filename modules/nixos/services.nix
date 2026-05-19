{ lib, ... }: {
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable DMS Greeter (Login System)
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/balraj";
  };

  # Ensure greetd is enabled so DMS greeter is started
  services.greetd.enable = true;
  services.greetd.settings.default_session.user = "greeter";

  # DMS can leave stale wallpaper files in its cache, which makes the greeter
  # pre-start script try to copy a file onto itself on the next boot.
  systemd.services.greetd.preStart = lib.mkBefore ''
    rm -f /var/lib/dms-greeter/wallpaper*
  '';

  # Enable XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
