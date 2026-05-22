{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    # Custom shell aliases
    shellAliases = {
      # NixOS management
      nixos-rebuild = "nh os";
      rebuild-nix = "nh os switch ~/nixos-dotfiles/#nixos-btw";
      rebuild-mac = "nh os switch ~/nixos-dotfiles/#mac-btw";
      sysclean = "sudo nh clean all";
      sysclean-verbose = "sudo nh clean all -v";
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
