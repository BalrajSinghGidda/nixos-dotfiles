{inputs, ...}: {
  imports = [
    ./shell.nix
    ./hyprland.nix
    ./devtools.nix
    ./gui-apps.nix
    inputs.danksearch.homeModules.dsearch
  ];
}
