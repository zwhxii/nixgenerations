{ config, pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
   #WLR_NO_HARDWARE_CURSORS = "1"; # если курсор пропадает
  };

  environment.systemPackages = with pkgs; [
    waybar
    rofi
    kitty
    grim
    slurp
    thunar
    hyprpaper
    wl-clipboard
    pywal
    playerctl
  ];

  xdg.portal = {
    enable = true;
    #extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
