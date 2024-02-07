{ inputs, outputs, lib, config, pkgs, userSettings, systemSettings, ... }: {

  imports = [
    (../../. + "/hosts"+("/"+systemSettings.host)+"/default.nix")
    (../../. + "/wm"+("/"+userSettings.wm)+"/default.nix")
    ../../system/security/default.nix
    ../../system/style/default.nix
    ../../system/apps/virtualization.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
    liberation_ttf
  ];

  boot.initrd.systemd.dbus.enable = true;

  # Configure console keymap
  console.keyMap = "cf";

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  users.users = {
    ${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.name;
      openssh.authorizedKeys.keys = [

      ];
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # Removes xterm
  services.xserver.excludePackages = [ pkgs.xterm ];

  services.ratbagd.enable = true; # To make piper work

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";

}
