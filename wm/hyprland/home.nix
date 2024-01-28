{ inputs, outputs, lib, config, pkgs, dotfilesDir, ... }: {

  imports = [
    ../../user/apps/app-launcher/wofi/default.nix
    ../../user/apps/terminal/kitty/default.nix
    ../../user/services/eww/default.nix
    ../../user/services/mako/default.nix
    ../../user/apps/app-launcher/bemenu/default.nix
  ];


  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  home.packages = with pkgs; [
    swww
    grim
    slurp
    swappy
    wl-clipboard
    imagemagick
    pyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      monitor=,preferred,auto,auto
      exec-once = pypr
      exec-once = swww init
      exec-once = eww open bar
      $term = kitty
      $menu = wofi --show drun

      input {
        kb_layout = ca
      }

      general {
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        layout = dwindle
        col.active_border = 0xff${config.lib.stylix.colors.base04}
        col.inactive_border = 0xff${config.lib.stylix.colors.base01}
      }

      group {
        col.border_active = 0xff${config.lib.stylix.colors.base04}
        col.border_inactive = 0xff${config.lib.stylix.colors.base01}
        col.border_locked_active = 0xff${config.lib.stylix.colors.base04}
      }

      decoration {
        blur {
          enabled = true
          size = 3
          passes = 1
          vibrancy = 0.1696
        }
      }

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      misc {
        force_default_wallpaper = 0
        background_color = 0xff${config.lib.stylix.colors.base00}
      }

      windowrulev2 = nomaximizerequest, class:.*
      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = opacity 0.80 0.70,class:^(pavucontrol)$
      windowrulev2 = float,class:^(org.keepassxc.KeePassXC)$
      windowrulev2 = float,class:^(kitty-dropterm)$
      windowrulev2 = opacity 0.80 0.70,class:^(org.keepassxc.KeePassXC)$
      windowrulev2 = opacity 0.80 0.80,class:^(Code)$
      windowrulev2 = opacity 0.80 0.80,class:^(dunst)$
      #windowrulev2 = opacity 0.80 0.80,class:^(Brave-browser)$

      $mainMod = SUPER

      bind = $mainMod, Return, exec, $term
      bind = $mainMod, Q, killactive,
      bind = $mainMod SHIFT CONTROL, Q, exit,
      bind = $mainMod SHIFT, L, exec, pypr attract_lost
      bind = $mainMod, M, exec, $term ncmpcpp
      bind = $mainMod, E, exec, $term lf
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, F, fullscreen, 1
      bind = $mainMod SHIFT, F, fullscreen, 0
      bind = $mainMod SHIFT, Return, exec, pypr toggle term
      bind = $mainMod SHIFT, V, exec, pypr toggle volume
      bind = $mainMod, K, exec, pypr toggle keepassxc
      bind = ,Print, exec, grim -g "$(slurp)" - | convert  - -shave  1x1 PNG:- | wl-copy
      bind = SHIFT, Print, exec, wl-paste | swappy -f -

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

    '';
  };

  xdg.configFile."hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "lost_windows",
    ]

    #[scratchpads.keepassxc]
    #animation = "fromLeft"
    #command = "keepassxc"
    #class = "keepassxc"
    #size = "40% 40%"

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "40% 30%"

    [scratchpads.volume]
    animation = "fromRight"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 90%"
    unfocus = "hide"
  '';

}
