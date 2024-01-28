{ config, pkgs, dwl-source, yambar-source, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      yambar = super.yambar.overrideAttrs (oldAttrs: rec {
        src = yambar-source;
      });
      dwl = super.dwl.overrideAttrs (oldAttrs: rec {
        src = dwl-source;
        patches = [
        #  ./dwl-patches/focusdirection.patch
        #  ./dwl-patches/attachbottom.patch
        #  ./dwl-patches/monfig.patch
        #  ./dwl-patches/point.patch
        #  ./dwl-patches/restoreTiling.patch
        #  ./dwl-patches/toggleKbLayout.patch
        #  ./dwl-patches/cursor_warp.patch
        #  ./dwl-patches/output-power-management.patch
        #  ./dwl-patches/autostart.patch
        #  ./dwl-patches/vanitygaps.patch
        ];
      });
    })
  ];
}
