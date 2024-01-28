{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  locale,
  timezone,
  ...
}: {

  imports = [
    ./hardware-configuration.nix
    ../../system/hardware/pipewire.nix
  ];

  # Boot loader
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      enable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };
  
  boot.initrd.luks.devices."luks-67516d05-67c4-48b7-bb8b-83671bdfe23b".device = "/dev/disk/by-uuid/67516d05-67c4-48b7-bb8b-83671bdfe23b";
  
  # Set your time zone.
  time.timeZone = timezone;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

}


