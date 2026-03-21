{pkgs, ...}: {
  # Bash shell configuration
  programs.bash = {
    enable = true;
    enableCompletion = true; # Tab completion for commands

    # Custom shell aliases for convenience
    shellAliases = {
      # NixOS management
      nc = "nvim ~/nixos-dotfiles/."; # Quick edit dotfiles
      btw = "echo I use NixOS, btw"; # Because we have to let everyone know
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/#nixos-btw"; # Rebuild system
      collect-garbage = "sudo nix-collect-garbage -d"; # Garbage collect the system

      # Config editing shortcuts
      edit-nixos = "nvim ~/nixos-dotfiles/modules/nixos/";
      edit-home = "nvim ~/nixos-dotfiles/modules/home-manager/";
      edit-host = "nvim ~/nixos-dotfiles/hosts/nixos-btw/";
      edit-nvf = "nvim ~/nixos-dotfiles/modules/nixos/nvf.nix";

      # Enhanced file operations
      ls = "eza --long -ahF --no-user --no-permissions --git --icons=always --color=always --grid";
      cd = "z"; # Use zoxide for smart directory jumping

      # Utilities
      bm = "bashmount"; # Mount/unmount utility
      install-copilot = "curl -fsSL https://gh.io/copilot-install | bash"; # Manual installation of Github Copilot CLI
      copilot = "~/.local/bin/copilot"; # Github Copilot CLI (downloaded manually)
    };

    # Don't save these commands in history
    historyIgnore = [
      "ls"
      "exit"
      "collect-garbage"
      "nrs"
    ];

    # Additional bash configuration
    bashrcExtra = ''
      # Custom gruvbox prompt: green user@host, teal directory, orange prompt
      export PS1="\[\e[38;5;142m\]\u@\h \[\e[38;5;108m\]\w \[\e[38;5;214m\]\$ \[\e[0m\]"

      # Use Neovim as manpage viewer
      export MANPAGER="nvim +Man!"

      # Use fd for faster file searching in fzf
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'

      # Initialize direnv (per-directory environments)
      eval "$(direnv hook bash)"

      # Initialize zoxide (smart cd)
      eval "$(zoxide init bash)"

      # Show system info on shell startup
      nitch
    '';
  };
}
