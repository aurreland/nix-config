{ inputs, outputs, lib, config, pkgs, dotfilesDir, ... }: {

  imports = [
    ../../user/apps/app-launcher/fuzzel/default.nix
    ../../user/apps/app-launcher/tofi/default.nix
    ../../user/apps/terminal/kitty/default.nix
    ../../user/services/eww/default.nix
    ../../user/services/mako/default.nix
    ../../user/services/swaylock/default.nix
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
    settings = {
      "monitor" = ",preferred,auto,auto";
      "$mod" = "SUPER"; # Main Keybind
      "$term" = "kitty"; # Sets default terminal
      # "$menu" = "tofi-drun | xargs hyprctl dispatch exec --"; # Sets default menu
      "$menu" = "fuzzel";
      exec-once = [
        "pypr" # Exec Pyprland to have scratchpads
        "swww init" # Exec Swww to have wallpaper working
        "eww open bar" # Exec eww to have the bar working
      ];
      exec = [
        # "bash ~/test.sh"
      ];
      bind = [
        # Principal Keybinds
        "$mod, Return, exec, $term"
        "$mod, Q, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, R, exec, $menu"
        "$mod SHIFT, E, exec, swaylock"
        "$mod, F, fullscreen, 1"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, Y, pin"
        "$mod, V, togglefloating"
        "$mod, J, cyclenext"
        "$mod, K, cyclenext, prev"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"
        "$mod SHIFT, 4, movetoworkspacesilent, 4"
        "$mod SHIFT, 5, movetoworkspacesilent, 5"

        # Pyprland
        "$mod SHIFT, L, exec, pypr attract_lost"
        "$mod SHIFT, V, exec, pypr toggle volume && hyprctl dispatch bringactivetotop"
        "$mod SHIFT, Return, exec, pypr toggle term"
        "$mod SHIFT, K, exec, pypr toggle keepassxc"

        # Screenshots
        ",Print, exec, grim -g '$(slurp)' - | convert  - -shave  1x1 PNG:- | wl-copy"
        "SHIFT, Print, exec, wl-paste | swappy -f -"
      ];
      bindm = [
        # Move/Resize windows with $mod and mouse
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      "$scratchpadsize" = "size 60% 60%";
      "$scratchpad" = "class:^(scratchpad)$";
      "$keepassxc" = "class:^(org.keepassxc.KeePassXC)$";
      "$pip" = "title:^(Picture in picture)$";
      windowrulev2 = [
        "nomaximizerequest, class:.*"
        "float,class:^(pavucontrol)$"
        "opacity 0.80 0.70,class:^(pavucontrol)$"

        # Picture in Picture
        "float,$pip"
        "keepaspectratio,$pip"
        "pin,$pip"
        "move 20 62,$pip"

        # KeePassXC Scratchpad
        "float,$keepassxc"
        "opacity 0.80 0.70,$keepassxc"
        "size 40% 40%,$keepassxc"
        "center,$keepassxc"

        # Dropterm
        "float,$scratchpad"
        "opacity 0.80 0.70,$scratchpad"
        "$scratchpadsize,$scratchpad"
        "workspace special silent,$scratchpad"
        "center,$scratchpad"
      ];
      input = {
        kb_layout = "ca";
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "0xff${config.lib.stylix.colors.base04}";
        "col.inactive_border" = "0xff${config.lib.stylix.colors.base01}";
        resize_on_border = true;
      };
      group = {
        "col.border_active" = "0xff${config.lib.stylix.colors.base04}";
        "col.border_inactive" = "0xff${config.lib.stylix.colors.base01}";
        "col.border_locked_active" = "0xff${config.lib.stylix.colors.base04}";
      };
      decoration = {
        drop_shadow = false;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        force_default_wallpaper = 0;
        background_color = "0xff${config.lib.stylix.colors.base00}";
      };
    };
  };

  xdg.configFile."hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "lost_windows",
    ]

    [scratchpads.keepassxc]
    command = "keepassxc"
    class = "keepassxc"
    lazy = true

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class scratchpad"
    lazy = true

    [scratchpads.volume]
    command = "pavucontrol"
    lazy = true
    unfocus = "hide"
  '';

}
