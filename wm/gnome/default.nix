{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = userSettings.username;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-photos
  ]) ++ (with pkgs.gnome; [
    tali # poker game
    iagno # go game
    geary # Mail Client
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-initial-setup
    gnome-music # Music app
    totem # video player
    eog # Image Viewer
  ]);

}
