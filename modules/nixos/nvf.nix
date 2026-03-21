{pkgs, ...}: {
  # Neovim configuration using nvf (Neovim configuration framework)
  # nvf provides a declarative way to configure Neovim within NixOS
  # This replaces the previous manual Lua-based configuration

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # Command aliases for backwards compatibility
        viAlias = true; # Map 'vi' command to nvim
        vimAlias = false; # Keep 'vim' separate

        syntaxHighlighting = true;

        # Tab bar at the top showing open buffers
        tabline.nvimBufferline.enable = true;

        # Fuzzy finder and file navigation
        telescope.enable = true;

        # System clipboard integration
        clipboard.enable = true;
        clipboard.providers.xclip.enable = true;
        clipboard.registers = "unnamedplus"; # Use '+' register for clipboard

        # Persistent undo across sessions
        undoFile.enable = true;

        # Auto-completion engine
        autocomplete.nvim-cmp.enable = true;

        # Debug Adapter Protocol support
        debugger.nvim-dap.enable = true;

        ui = {
          nvim-highlight-colors = {
            # Highlight color codes
            enable = true;
            setupOpts = {
              render = "foreground";
            };
          };
          illuminate.enable = true; # Highlight word under cursor
        };

        utility = {
          mkdir.enable = true; # Auto-create directories on save
          yazi-nvim.enable = true; # Terminal file manager integration
        };

        # Tokyo Night color theme
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        # Editor options
        options = {
          shiftwidth = 4; # Indent with 4 spaces
          tabstop = 4; # Tab displays as 4 spaces
        };

        # Language support configuration
        languages = {
          enableTreesitter = true; # Syntax highlighting and parsing
          enableFormat = true; # Auto-formatting support
          enableDAP = true; # Debug support for languages

          # Enable language servers and tools
          python.enable = true;
          clang.enable = true; # C/C++
          bash.enable = true;
          css.enable = true;
          go.enable = true;
          java.enable = true;
          sql.enable = true;
          yaml.enable = true;

          # TypeScript with enhanced diagnostics
          ts = {
            enable = true;
            extraDiagnostics.enable = true;
          };

          # Nix language support with enhanced diagnostics
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
          };

          # HTML with enhanced diagnostics
          html = {
            enable = true;
            extraDiagnostics.enable = true;
          };

          # Markdown with preview support
          markdown = {
            enable = true;
            extensions = {
              markview-nvim.enable = true; # Live markdown preview
            };
          };
        };

        # Language Server Protocol configuration
        lsp = {
          enable = true;
          formatOnSave = true; # Auto-format on save
          lspconfig.enable = true; # LSP configurations
          nvim-docs-view.enable = true; # Documentation viewer
        };

        # Status line at the bottom
        statusline.lualine = {
          enable = true;
        };

        # Git integration
        git = {
          enable = true;
          neogit.enable = true; # Magit-like Git interface
        };

        # Terminal integration
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true; # TUI for Git
          mappings = {
            open = ","; # Open terminal with comma key
          };
        };

        # Dashboard on startup
        dashboard.alpha = {
          enable = true;
          theme = "dashboard";
        };

        # File tree explorer
        filetree.nvimTree = {
          enable = true;
          setupOpts = {
            git.enable = true;
            modified.enable = true;
            renderer.highlight_git = true;
            renderer.highlight_modified = "icon";
          };
        };
      };
    };
  };
}
