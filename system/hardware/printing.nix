{ config, pkgs, ... }: {

  # Enable printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };
  
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
  

  environment.systemPackages = [ pkgs.cups-filters ];
  
}
