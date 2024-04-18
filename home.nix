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

  home.packages = [
    pkgs.htop
  ];

  home.file = {
  };

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    ];

    settings = {
      "plugin:borders-plus-plus" = {
        add_borders = 1; # 0 - 9

        # you can add up to 9 borders
        "col.border_1" = "rgb(ffffff)";
        "col.border_2" = "rgb(2222ff)";

        border_size_1 = 10;
        border_size_2 = -1;
        natural_rounding = "yes";
      };
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
