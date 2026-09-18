{pkgs, ... }:
{
  home.stateVersion = "25.11";
  services.wlsunset = {
    enable = true;
    temperature = {
      day = 7500;
      night = 3500;
    };
    sunrise = "07:00";
    sunset = "22:00";
  };
}
