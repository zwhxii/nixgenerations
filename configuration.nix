# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
      rocmPackages.clr.icd
    ];
  };

  fileSystems."/mnt/onetera" = {
    device = "/dev/disk/by-uuid/d13d31f6-02d1-4d07-967f-303bc9f1aa31";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  imports =
    [ 
      ./hardware-configuration.nix
      ./hyprland.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.overlays = [
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (_: { doCheck = false; });
    })
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "dm_mod" "cryptd" "aesni_intel" "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  #boot.kernelPackages = pkgs.linuxPackages_latest; # KERNEL LAST VERSION

  boot.kernelPackages = pkgs.linuxPackages_7_0;

  networking.hostName = "NixOSMachine";
 
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Almaty";

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  # console.keymap = "us";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
     #useXkbConfig = true; # use xkb.options in tty.
   };

  #services.xserver.enable = true;

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  # services.pulseaudio.enable = true;

   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
   };
   security.rtkit.enable = true;

  # services.libinput.enable = true;

   users.users.whixie = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" ]; 
     home = "/home/whixie";
     shell = pkgs.zsh;
     packages = with pkgs; [
       tree
     ];
   };

  #programs.firefox.enable = true;
   programs.steam.enable = true;
   hardware.bluetooth.enable = true;

   environment.systemPackages = with pkgs; [
     vim
     wget
     git
     htop
     nvtopPackages.amd
     discord
     fastfetch
     python3
     brave
     net-tools
     libreoffice-still
     wineWow64Packages.stagingFull
     unar
     lutris
     openrgb-with-all-plugins
     easyeffects
     vulkan-tools
     obs-studio
     libva-utils
     prismlauncher
     spotify
   ];
   
   programs.zsh = {
     enable = true;
     enableCompletion = true;
     autosuggestions.enable = false;

     shellAliases = {
       ff = "fastfetch";
       susp = "systemctl suspend";
       shut = "shutdown -P now";
       bton = "bluetoothctl power on";
       btoff = "bluetoothctl power off";
       ser = "ssh -t whixie@192.168.0.101";
       _ = "sudo ";
       hy = "start-hyprland";
       hyex = "hyprctl dispatch exit";
     };
     
     ohMyZsh = {
       enable = true;
       theme = "nicoulaj";
     };
     
     histSize = 10000;
     histFile = "$HOME/.zsh_history";
     setOptions = [
       "HIST_IGNORE_ALL_DUPS"
     ];
   };

  services.flatpak.enable = true;

  services.hardware.openrgb.enable = true;

   nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["steam" "steam-unwrapped" "discord" "spotify"];

   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
     };
   };

  services.zerotierone.enable = true;
  systemd.services.zerotierone.wantedBy = lib.mkForce [];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

   system.copySystemConfiguration = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}

