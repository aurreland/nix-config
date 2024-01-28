{ config, pkgs, ... }: {

  imports = [
    ./dwl.nix
  ];

  environment.systemPackages = [ pkgs.dwl pkgs.yambar ];

  nixpkgs.overlays = [
    (final: prev:{
	    dwl = prev.dwl.override { conf = ./config.h; };
    })
    (self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        #src = ;
        patches = [
          ./patches/attachbottom.patch
          ./patches/capslock.patch
          #./patches/scratchpads.patch
          ./patches/ipc.patch
        ];
      });
    })
  ];

}