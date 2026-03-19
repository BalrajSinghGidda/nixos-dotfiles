{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nc = "nvim ~/nixos-dotfiles/.";
      btw = "echo I use NixOS, btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw";
      edit-config = "nvim ~/nixos-dotfiles/configuration.nix";
      edit-home-config = "nvim ~/nixos-dotfiles/home.nix";
      ls = "eza --long -ahF --no-user --no-permissions --git --icons=always --color=always --grid";
      cd = "z";
      bm = "bashmount";
    };
    historyIgnore = [
      "ls"
      "exit"
    ];
    bashrcExtra = ''
      export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      export MANPAGER="nvim +Man!"
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
      eval "$(direnv hook bash)"
      eval "$(zoxide init bash)"
      nitch
    '';
  };
}
