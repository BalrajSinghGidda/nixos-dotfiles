{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    # Custom shell aliases
    shellAliases = {
      # NixOS management
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw";
      sysclean = "sudo nix-collect-garbage -d";
      nc = "nvim ~/nixos-dotfiles/";

      # Config editing shortcuts
      edit-nixos = "nvim ~/nixos-dotfiles/modules/nixos/";
      edit-home = "nvim ~/nixos-dotfiles/modules/home-manager/";
      edit-hypr = "nvim ~/nixos-dotfiles/config/hypr/hyprland.conf";

      # Enhanced file operations
      ls = "ls"; # Nushell has a built-in structured ls
      la = "ls -a";
    };

    extraConfig = ''
      $env.config = {
        show_banner: false,
      }
    '';
  };

  # Integration
  programs.zoxide.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
