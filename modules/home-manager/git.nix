{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "BalrajSinghGidda";
    userEmail = "anonystargamerz@gmail.com";
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
