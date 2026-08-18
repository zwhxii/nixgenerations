{ config, pkgs, inputs, ... }:
{
  programs.river = {
    enable = true;
    xwayland.enable = true;
  };

  services.libinput.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
#    XDG_CURRENT_DESKTOP = "river";
  };
  environment.systemPackages = with pkgs; [
    wlr-randr
    yambar
  ];
}
