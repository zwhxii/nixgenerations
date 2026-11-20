{ pkgs, ... }:
{
  programs.river-classic = {
    enable = true;
    xwayland.enable = true;
    extraPackages = [ ];
  };

  services.libinput.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.portal = {
    enable = true;
    config.river = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wideriver
    wlr-randr
    swaynotificationcenter
    brightnessctl
    wireplumber
  ];
}
