{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "ajmalmohad";
  home.homeDirectory = "/home/ajmalmohad";

  home.packages = with pkgs; [
    nodePackages.eas-cli
    alacritty
  ];

  home.file = {
  };

  programs = {
    wofi.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "robbyrussell";
      };
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
