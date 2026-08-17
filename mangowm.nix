{ config, pkgs, inputs, ... }:
{

  disabledModules = [ "/nix/store/cc7ff4ysismx0c3778v8gc6b14plrz3z-source/nixos/modules/programs/wayland/mango.nix" ];

  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  programs.mango.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "mango";
    # WLR_NO_HARDWARE_CURSORS = "1"; # если курсор пропадает
  };

  environment.systemPackages = with pkgs; [
    waybar  
    rofi     
    kitty     
    grim       
    slurp       
    swaybg
    thunar       
    wl-clipboard 
    playerctl    
    xdg-desktop-portal-wlr 
  ];


  xdg.portal = {
    enable = true;
    wlr.enable = true; # портал для wlroots (MangoWC основан на wlroots)
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

}
