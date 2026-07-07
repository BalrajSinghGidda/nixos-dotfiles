{inputs, ...}: {
  imports = [
    ./shell.nix
    ./niri.nix
    ./devtools.nix
    ./gui-apps.nix
    inputs.danksearch.homeModules.dsearch
  ];
}
