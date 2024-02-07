{ config, pkgs, userSettings, ... }: {

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  
  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];

}
