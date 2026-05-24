{ config, pkgs, ... }:
{
  # Включаем программу через модуль NixOS
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;   # поддержка X11-приложений
  };

  # Wayland-окружение
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";     # electron-приложения через wayland
#    WLR_NO_HARDWARE_CURSORS = "1";  # если курсор пропадает
  };

  # Нужные пакеты
  environment.systemPackages = with pkgs; [
    waybar
    rofi
    kitty
    grim
    slurp
    xfce.thunar
    hyprpaper
    wl-clipboard
    pywal
    playerctl
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

}
