{ config, lib, pkgs, inputs, ... }: {

  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    autoEnable = true;
    image = ../../wallpaper;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 10;
    };

    fonts = {
        # monospace = {
           # name = "Fira Code";
           # package = pkgs.fira-code;
        # };
        # serif = config.stylix.fonts.monospace;
        # sansSerif = config.stylix.fonts.monospace;
        emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji-blob-bin;
        };
        sizes = {
          terminal = 12;
          applications = 12;
          popups = 12;
          desktop = 12;
        };
    };

    targets = {
      kitty.enable = true;
      gtk.enable = true;
      hyprland.enable = false;
      dunst.enable = true;
    };

  };

  qt.platformTheme = "gtk3";

}
