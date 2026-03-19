{ stdenv }:

stdenv.mkDerivation {
  name = "custom-scripts";
  src = ../bin;
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/* $out/bin/
    chmod +x $out/bin/*
  '';
}