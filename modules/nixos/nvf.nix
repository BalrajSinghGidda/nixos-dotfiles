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

        # Custom color theme
        theme = {
          enable = false;
        };

        # Custom colorscheme via extraConfigLuaPre
        extraConfigLuaPre = ''
          -- Custom colorscheme based on new1.md
          vim.cmd([[
            hi clear
            if exists("syntax_on")
              syntax reset
            endif
            set background=dark
            let g:colors_name = "custom"

            " Base colors
            hi Normal guifg=#f4decd guibg=#0f0f0f
            hi Visual guifg=#0f0f0f guibg=#f4decd
            hi Cursor guifg=#0f0f0f guibg=#f4decd
            hi CursorLine guibg=#1e1f1e
            hi CursorColumn guibg=#1e1f1e
            hi LineNr guifg=#3b403c guibg=#0f0f0f
            hi CursorLineNr guifg=#f4decd guibg=#1e1f1e gui=bold

            " Syntax highlighting
            hi Comment guifg=#3b403c gui=italic
            hi Constant guifg=#ebadd6
            hi String guifg=#a4daa4
            hi Character guifg=#a4daa4
            hi Number guifg=#ebadd6
            hi Boolean guifg=#ebadd6
            hi Float guifg=#ebadd6
            hi Identifier guifg=#b0d4e8
            hi Function guifg=#b0d4e8
            hi Statement guifg=#ef968f gui=bold
            hi Conditional guifg=#ef968f
            hi Repeat guifg=#ef968f
            hi Label guifg=#f4b585
            hi Operator guifg=#f4decd
            hi Keyword guifg=#ef968f
            hi Exception guifg=#ef968f
            hi PreProc guifg=#abd4bf
            hi Include guifg=#abd4bf
            hi Define guifg=#ebadd6
            hi Macro guifg=#ebadd6
            hi PreCondit guifg=#abd4bf
            hi Type guifg=#f4b585 gui=bold
            hi StorageClass guifg=#f4b585
            hi Structure guifg=#f4b585
            hi Typedef guifg=#f4b585
            hi Special guifg=#abd4bf
            hi SpecialChar guifg=#ebadd6
            hi Tag guifg=#abd4bf
            hi Delimiter guifg=#f4decd
            hi SpecialComment guifg=#3b403c gui=italic
            hi Debug guifg=#ef968f
            hi Underlined guifg=#b0d4e8 gui=underline
            hi Ignore guifg=#3b403c
            hi Error guifg=#ef968f guibg=#1e1f1e
            hi Todo guifg=#ebadd6 guibg=#1e1f1e gui=bold

            " UI elements
            hi Pmenu guifg=#f4decd guibg=#1e1f1e
            hi PmenuSel guifg=#0f0f0f guibg=#b0d4e8
            hi PmenuSbar guibg=#3b403c
            hi PmenuThumb guibg=#f4decd
            hi StatusLine guifg=#f4decd guibg=#1e1f1e gui=bold
            hi StatusLineNC guifg=#3b403c guibg=#1e1f1e
            hi TabLine guifg=#3b403c guibg=#1e1f1e
            hi TabLineFill guibg=#1e1f1e
            hi TabLineSel guifg=#f4decd guibg=#0f0f0f gui=bold
            hi VertSplit guifg=#3b403c guibg=#0f0f0f
            hi Folded guifg=#3b403c guibg=#1e1f1e
            hi FoldColumn guifg=#3b403c guibg=#0f0f0f
            hi SignColumn guibg=#0f0f0f
            hi Search guifg=#0f0f0f guibg=#f4b585
            hi IncSearch guifg=#0f0f0f guibg=#ef968f
            hi MatchParen guifg=#0f0f0f guibg=#ebadd6 gui=bold
            hi NonText guifg=#3b403c
            hi SpecialKey guifg=#3b403c
            hi Title guifg=#b0d4e8 gui=bold
            hi Directory guifg=#abd4bf
            hi ErrorMsg guifg=#ef968f guibg=#0f0f0f
            hi WarningMsg guifg=#f4b585
            hi MoreMsg guifg=#a4daa4
            hi Question guifg=#a4daa4
            hi WildMenu guifg=#0f0f0f guibg=#b0d4e8

            " Diff colors
            hi DiffAdd guifg=#a4daa4 guibg=#1e1f1e
            hi DiffChange guifg=#f4b585 guibg=#1e1f1e
            hi DiffDelete guifg=#ef968f guibg=#1e1f1e
            hi DiffText guifg=#b0d4e8 guibg=#3b403c gui=bold

            " Git signs
            hi GitSignsAdd guifg=#a4daa4
            hi GitSignsChange guifg=#f4b585
            hi GitSignsDelete guifg=#ef968f

            " Diagnostics
            hi DiagnosticError guifg=#ef968f
            hi DiagnosticWarn guifg=#f4b585
            hi DiagnosticInfo guifg=#b0d4e8
            hi DiagnosticHint guifg=#abd4bf
          ]])
        '';

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
