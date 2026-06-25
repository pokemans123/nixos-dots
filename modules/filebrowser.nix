#contains filebrowsers, media players, image viewers, etc.
{
  pkgs,
  ...
}:
{
  services.picom = {
   enable = true;
   activeOpacity = 0.90;
   inactiveOpacity = 0.80;
  };
  home.packages = with pkgs; [
    thunar
    nautilus
    thunar-volman
    file-roller
    ffmpeg
    ffmpegthumbnailer
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-vcs-plugin
    unzip
    unzrip
    shotwell
    mpv
    xwallpaper
    xclip
    maim
    mpvScripts.manga-reader
  ];
}
