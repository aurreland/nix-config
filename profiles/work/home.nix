# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  host,
  wm,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # outputs.homeManagerModules.example
    (../../. + "/wm"+("/"+wm)+"/home.nix")
    (../../. + "/hosts"+("/"+host)+"/home.nix")
    ../../user/apps/browser/firefox/default.nix
    ../../user/apps/browser/qutebrowser/default.nix
    ../../user/services/music/default.nix
    ../../user/apps/cli/lf/default.nix
    ../../user/apps/cli/neovim/default.nix
    ../../user/apps/cli/git/default.nix
    ../../user/lang/rust/default.nix
    ../../user/lang/python/default.nix
    ../../user/lang/cc/default.nix
    ../../user/shell/default.nix
    ../../user/style/default.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = username;
    homeDirectory = "/home/"+username;
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    keepassxc
    brave
    vscode
    discord
    mpv
    zathura
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
