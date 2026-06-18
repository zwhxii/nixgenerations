{ config, pkgs, inputs, ... }:
{

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
    waybar       # статус-бар
    rofi         # лаунчер
    foot         # терминал (нативный wayland)
    kitty        # альтернативный терминал
    grim         # скриншоты
    slurp        # выделение области
    swaybg       # обои
    wl-clipboard # буфер обмена
    playerctl    # управление медиа
    xdg-desktop-portal-wlr # портал для wlroots-композиторов
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true; # портал для wlroots (MangoWC основан на wlroots)
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Дисплей-менеджер: greetd с автологином
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "mango";
        user = "your-username"; # замените на своего пользователя
      };
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

}
