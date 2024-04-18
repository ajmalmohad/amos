{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "ajmalmohad";
  home.homeDirectory = "/home/ajmalmohad";

  home.packages = [
    pkgs.htop
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
