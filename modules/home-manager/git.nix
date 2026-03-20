{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "BalrajSinghGidda";
      user.email = "anonystargamerz@gmail.com";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enable";
      editor = "nvim";
    };
  };
}