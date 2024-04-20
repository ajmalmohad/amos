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
    (import ./scripts/tmuxus.nix {inherit pkgs;})
  ];

  home.file = {
    ".config/i3/config" = {
      source = ./dotfiles/i3/config;
    };
    ".config/i3status/config" = {
      source = ./dotfiles/i3status/config;
    };
  };

  programs = {
    home-manager.enable = true;
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

  home.stateVersion = "23.11";
}
