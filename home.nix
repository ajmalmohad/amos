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

  home.file.".config/i3/config" = {
    source = ./dotfiles/i3/config;
    onChange = ''
      ${pkgs.i3}/bin/i3-msg reload
    '';
  };

  home.file.".config/i3status/config" = {
    source = ./dotfiles/i3status/config;
    onChange = ''
      ${pkgs.i3status}/bin/i3status -c ${./dotfiles/i3status/config}
    '';
  };

  programs = {
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
