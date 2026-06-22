#contains filebrowser
{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    thunar
    thunar-volman
    file-roller
    ffmpeg
    ffmpegthumbnailer
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-vcs-plugin
    unzip
    unzrip
  ];
}
