{ pkgs, ... }:

{
    programs.nvf = {
        enable = true;
        settings = {
            vim = {
                viAlias = true;
                vimAlias = false;

                syntaxHighlighting = true;

                tabline.nvimBufferline.enable = true;

                telescope.enable = true;

                clipboard.enable = true;
                clipboard.providers.xclip.enable = true;
                clipboard.registers = "unnamedplus";

                undoFile.enable = true;

                autocomplete.nvim-cmp.enable = true;

                debugger.nvim-dap.enable = true;

                ui = {
                    colorizer.enable = true;
                    illuminate.enable = true;
                };

                utility = {
                    makdir.enable = true;
                    yazi-nvim.enable = true;
                };

                theme = {
                    enable = true;
                    name = "tokyonight";
                    style = "night";
                };

                options = {
                    shiftwidth = 4;
                    tabstop = 4;
                };

                languages = {
                    enableTreesitter = true;
                    enableeFormat = true;
                    enableDAP = true;

                    python.enable = true;
                    clang.enable = true;
                    bash.enable = true;
                    css.enable = true;
                    go.enable = true;
                    java.enable = true;
                    sql.enable = true;
                    yaml.enable = true;

                    ts = {
                        enable = true;
                        extraDiagnostics.enable = true;
                    };
                                         
                    nix = {
                        enable = true;
                        extraDiagnostics.enable = true;
                    };

                    html = {
                        enable = true;
                        extraDiagnostics.enable = true;
                    };

                    markdown = {
                        enable = true;
                        extensions = {
                            markview-nvim.enable = true;
                        };
                    };
                };

                lsp = {
                    enable = true;
                    formatOnSave = true;
                    lspconfig.enable = true;
                    nvim-docs-view.enable = true;
                };

                statusline.lualine = {
                    enable = true;
                };

                git = {
                    enable = true;
                    neogit.enable = true;
                };

                terminal.toggleterm = {
                    enable = true;
                    lazygit.enable = true;
                    mappings = {
                        open = ",";
                    };
                };

                dashboard.alpha = {
                    enable = true;
                    theme = "dashboard";
                };
                
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
