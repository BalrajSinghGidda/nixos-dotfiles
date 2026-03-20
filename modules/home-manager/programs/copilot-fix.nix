{ pkgs }:

pkgs.github-copilot-cli.overrideAttrs (old: {
  doInstallCheck = false;

  postFixup = (old.postFixup or "") + ''
    if [ -f "$out/bin/.copilot-wrapped" ]; then
      echo "Patching copilot wrapper to remove --no-warnings..."

      # safer patch: don't mess with binary structure too much
      sed -i 's/--no-warnings//g' "$out/bin/.copilot-wrapped" || true
    fi
  '';
})
