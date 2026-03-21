{ pkgs, ... }:

{
    programs.nvf = {
        enable = true;
        settings = {
            vim = {
                viAlias = true;
                vimAlias = false;
                theme = {
                    enable = true;
                    name = "gruvbox";
                    style = "dark";
                };
                languages = {
                    nix.enable = true;
                };
                lsp = {
                    enable = true;
                };
                statusline.lualine = {
                    enable = true;
                };
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;
            };
        };
    };
}
