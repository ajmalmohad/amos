{
  config,
  pkgs,
  inputs,
  ...
}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
  '';
in {
  home.username = "ajmalmohad";
  home.homeDirectory = "/home/ajmalmohad";
  wayland.windowManager.hyprland.enable = true;

  home.packages = [
    pkgs.htop
  ];

  home.file = {
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
