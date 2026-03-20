{ pkgs }:

pkgs.github-copilot-cli.overrideAttrs (old: {
  postFixup = (old.postFixup or "") + ''
    if [ -f "$out/bin/.copilot-wrapped" ]; then
      echo "Patching copilot wrapper (binary-safe)..."

      tmpfile=$(mktemp)

      # remove the offending flag safely
      cat "$out/bin/.copilot-wrapped" \
        | tr -d '\000' \
        | sed 's/--no-warnings//g' \
        > "$tmpfile"

      chmod +x "$tmpfile"
      mv "$tmpfile" "$out/bin/.copilot-wrapped"
    fi
  '';
})
