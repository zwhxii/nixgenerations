{pkgs, ... }:
{
  home.stateVersion = "25.11";
  services.wlsunset = {
    enable = true;
    temperature = {
      day = 6500;
      night = 3000;
    };
    sunrise = "08:00";
    sunset = "22:00";
  };  
}
