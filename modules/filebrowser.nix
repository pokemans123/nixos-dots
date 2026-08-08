#contains filebrowsers, media players, image viewers, etc.
{
  pkgs,
  ...
}:
{

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpris
      manga-reader
    ];
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
    thunderbird
  ];
}
