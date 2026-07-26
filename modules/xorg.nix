{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.i3.enable = true;
    windowManager.qtile.enable = true;
    windowManager.awesome.enable = true;
  };
  services.picom = {
    enable = true;
    backend = "glx";
    activeOpacity = 0.9;
    inactiveOpacity = 0.75;
    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 2.0;
      };
    };
  };

  services.autorandr = {
    enable = true;
    defaultTarget = "eDP-1";
    profiles = {
      laptop.config = {
        eDP-1 = {
          enable = true;
          primary = true;
        };
        HDMI-1 = {
          enable = false;
        };
      };

      dual.config = {
        eDP-1 = {
          enable = true;
          primary = true;
          position = "0x0";
        };
        HDMI-1 = {
          enable = true;
          position = "1920x0";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    xwallpaper
    xclip
    maim
    i3status
  ];
}
