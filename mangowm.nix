{ config, pkgs, inputs, ... }:
{

  disabledModules = [ "/nix/store/jpnpv93s5ppfb1kbvfp8qa763vfb4fjb-source/nixos/modules/programs/wayland/mango.nix" ]; # деривация меняется при flake update, заменять

  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  programs.mango.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    #XDG_CURRENT_DESKTOP = "mango";
    # WLR_NO_HARDWARE_CURSORS = "1"; 
  };

  environment.systemPackages = with pkgs; [
    waybar  
    rofi     
    kitty     
    grim       
    slurp       
    swaybg
    yazi
    wl-clipboard 
    playerctl
    xdg-desktop-portal-wlr
  ];


  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

}
