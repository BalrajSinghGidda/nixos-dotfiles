{ stdenv }:

stdenv.mkDerivation {
  name = "devshell-scripts";
  src = ./devshell-scripts;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    chmod +x $out/bin/*
  '';
}
