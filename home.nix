{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  bin = "${config.home.homeDirectory}/nixos-dotfiles/bin";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
  };
in

{
  home.username = "balraj";
  home.homeDirectory = "/home/balraj";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nc = "nvim ~/nixos-dotfiles/.";
      btw = "echo I use NixOS, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#servos";
      sysclean = "sudo nix-collect-garbage -d";
      edit-config = "nvim ~/nixos-dotfiles/configuration.nix";
      edit-home-config = "nvim ~/nixos-dotfiles/home.nix";
      make-py-devshell = "bash ${bin}/make-py-devshell";
      make-cpp-devshell = "bash ${bin}/make-cpp-devshell";
      ls = "eza --long -ahF --no-user --no-permissions --git --icons=always --color=always --grid";
      cd = "z";
    };
    historyIgnore = [
      "ls"
      "exit"
    ];
    bashrcExtra = ''
      export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
      eval "$(direnv hook bash)"
      eval "$(zoxide init bash)"
      eval "$(oh-my-posh init bash --config hul10)"
      nitch
    '';
  };

  programs.git = {
    enable = true;
    settings.user.name = "BalrajSinghGidda";
    settings.user.email = "anonystargamerz@gmail.com";
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enable";
      editor = "nvim";
    };
  };

  programs.gemini-cli = {
    enable = true;
    settings = {
      "theme" = "Default";
      "preferredEditor" = "nvim";
      "autoAccept" = true;
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

#      (pkgs.writeShellApplication {
#       name = "ns";
#       runtimeInputs = with pkgs; [
#       fzf
#       nix-search-tv
#       ];
#       text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
#       })
#
  home.packages = with pkgs; [
    ripgrep
      nil
      nixpkgs-fmt
      nodejs
      gcc 
      yazi
      eza
      zoxide
      python313Packages.euporie
      ];
}
