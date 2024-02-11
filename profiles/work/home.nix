{ inputs, outputs, lib, config, pkgs, userSettings, systemSettings, ... }: {
  imports = [
    (../../. + "/wm"+("/"+userSettings.wm)+"/home.nix")
    (../../. + "/hosts"+("/"+systemSettings.host)+"/home.nix")
    # ../../user/apps/zathura/default.nix
    # ../../user/apps/flatpak/default.nix
    # ../../user/apps/cli/lf/default.nix
    ../../user/apps/cli/neovim/default.nix
    ../../user/apps/cli/git/default.nix
    ../../user/lang/rust/default.nix
    ../../user/lang/python/default.nix
    ../../user/lang/cc/default.nix
    ../../user/shell/default.nix
    ../../user/style/default.nix
    ../../user/apps/discord/default.nix
    # ../../user/services/music/default.nix
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
    # Base utilities
    gthumb # Image Viewer
    fragments # Torrents Manager
    foliate # Ebook Viewer
    pika-backup # Backup Files
    wordbook # English Dictionary
    komikku # Manga Reader
    pavucontrol # Manage Sound
    wike # Wikipedia Viewer
    gnome-obfuscate # Blur Screenshots
    mousai # Shazam
    citations # Manage References
    dialect # Traductions
    clapper # View videos
    gnome-secrets # Manage KeePass DataBase
    gnome.nautilus # File Manager
    gnome.sushi # File Previewer for Nautilus

    # Configuring Mice / KB / Joysticks
    piper
    antimicrox

    # Music
    lollypop # Music Player
    kid3 # Music Tagger / Needed by lollypop
    shortwave # Radio
    blanket # Background Sounds

    # Notes / School
    anki # Flashcard For Revision
    texliveFull # Enables Latex

  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
