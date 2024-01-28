{ config, lib, pkgs, stylix, ... }: {
  
  imports = [ stylix.nixosModules.stylix ];

  stylix = {
    autoEnable = false;
    image = ../../wallpaper;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 10;
    };

    fonts = {
        monospace = {
            name = "Iosevka";
            package = pkgs.iosevka;
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji-blob-bin;
        };
        sizes = {
          terminal = 18;
          applications = 12;
          popups = 12;
          desktop = 12;
        };
    };

    targets = {
      console.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      nix-vim.enable = true;
    };
  };

}