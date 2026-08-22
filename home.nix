{pkgs, ... }:
{
  home.stateVersion = "25.11";
  services.wlsunset = {
    enable = true;
    temperature = {
      day = 7500;
      night = 4000;
    };
    sunrise = "08:00";
    sunset = "22:00";
  };
}
