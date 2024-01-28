{ inputs, outputs, lib, config, pkgs, username, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.xserver = {
    enable = true;
    layout = "ca";
    xkbVariant = "";
    displayManager = {
      autoLogin = { # Enables Auto Login 
        #enable = true;
        user = username;
      };
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  services.gnome = {
    gnome-keyring.enable = true;
  };

}