{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
  mpv,
  yt-dlp,
}:
buildNpmPackage rec {
  pname = "youtube-music-cli";
  version = "0.5.2"; # change if upstream updates

  src = fetchFromGitHub {
    owner = "involvex";
    repo = "youtube-music-cli";
    rev = "v${version}";
    hash = lib.fakeHash;
  };

  npmDepsHash = lib.fakeHash;

  nativeBuildInputs = [
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/youtube-music-cli \
      --prefix PATH : ${
      lib.makeBinPath [
        mpv
        yt-dlp
      ]
    }
  '';

  meta = with lib; {
    description = "Terminal UI YouTube Music player";
    homepage = "https://github.com/involvex/youtube-music-cli";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "youtube-music-cli";
  };
}
