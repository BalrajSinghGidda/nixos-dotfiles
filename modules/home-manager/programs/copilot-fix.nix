{ pkgs, ... }:

pkgs.github-copilot-cli.overrideAttrs (old: {
  postFixup = (old.postFixup or "") + ''
    if [ -f "$out/bin/.copilot-wrapped" ]; then
      echo "Patching copilot wrapper to remove --no-warnings..."
      substituteInPlace "$out/bin/.copilot-wrapped" \
        --replace "--no-warnings" ""
    fi
  '';
})
