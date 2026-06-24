#contains filebrowsers, media players, image viewers, etc.
{
  pkgs,
  ...
}:
{
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
    feh
    mpvScripts.manga-reader
  ];
}
