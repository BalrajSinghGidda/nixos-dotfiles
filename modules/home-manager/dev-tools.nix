{ pkgs, ... }:

let
  # Import custom devshell scripts package
  devshell-scripts = pkgs.callPackage ./devshell-scripts.nix { };
in
{
  # Development tools and programming languages
  home.packages = with pkgs; [
    # Programming languages & compilers
    nodejs # JavaScript runtime
    gcc # C/C++ compiler

    # Python packages
    python313Packages.euporie # Jupyter notebook terminal client

    # Custom scripts for creating development environments
    devshell-scripts
  ];
}
