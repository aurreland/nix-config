{ inputs, outputs, lib, config, pkgs, username, name, hostname, wm, host, ... }: {

  imports = [
    (../../. + "/hosts"+("/"+host)+"/default.nix")
    ../../wm/dwl/default.nix
    (../../. + "/wm"+("/"+wm)+"/default.nix")
    ../../system/security/default.nix
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

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = name;
      openssh.authorizedKeys.keys = [
      
      ];
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
  
}
