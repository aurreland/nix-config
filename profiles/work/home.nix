{ inputs, outputs, lib, config, pkgs, userSettings, systemSettings, ... }: {
  imports = [
    (../../. + "/wm"+("/"+userSettings.wm)+"/home.nix")
    (../../. + "/hosts"+("/"+systemSettings.host)+"/home.nix")
    ../../user/apps/zathura/default.nix
    ../../user/apps/cli/lf/default.nix
    ../../user/apps/cli/neovim/default.nix
    ../../user/apps/cli/git/default.nix
    ../../user/lang/rust/default.nix
    ../../user/lang/python/default.nix
    ../../user/lang/cc/default.nix
    ../../user/shell/default.nix
    ../../user/style/default.nix
    ../../user/apps/discord/default.nix
    ../../user/services/music/default.nix
    ../../user/apps/virtualization.nix
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
    username = userSettings.username;
    homeDirectory = "/home/"+userSettings.username;
  };

  home.packages = with pkgs; [
    easytag
    mpv
    anki
    piper
    shortwave
    cozy
    mousai
    # textpieces
    blanket
    amberol
    citations
    dialect
    emblem
    # file shredder
    fragments
    # impression
    junction
    komikku
    # letterpress
    pika-backup
    # paper clip
    gnome-podcasts
    newsflash
    gnome-obfuscate
    gnome.polari
    gnome-secrets
    tangram
    # telegraph
    wike
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
