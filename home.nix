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
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  home.username = "ajmalmohad";
  home.homeDirectory = "/home/ajmalmohad";
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$mod" = "ALT";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    bind =
      [
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # terminal
        "$mod, Return, exec, alacritty"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ]
      ++ workspaces;
  };

  home.file = {
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
