{ stdenv }:

stdenv.mkDerivation {
  name = "wallpapers";
  src = ./wallpapers/Pictures;
  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r $src/* $out/share/wallpapers/
  '';
}
