{ pkgs, inputs, ... }:

let
  # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  user="pranav";
  home_dir = "/home/pranav";
in
{
  # imports = [
  #  inputs.spicetify-nix.homeManagerModules.spicetify
  # ];
  # programs.spicetify = {
  #   enable = true;
  #   enabledExtensions = with spicePkgs.extensions; [
  #     adblockify
  #     hidePodcasts
  #     shuffle
  #   ];
  #   theme = spicePkgs.themes.catppuccin;
  #   colorScheme = "mocha";
  # };
  programs.vesktop = {
    enable = true;
    settings = {
      tray = true;
      minimzeToTray = true;
    };
  };

xdg.desktopEntries.vesktop = {
  name = "Vesktop";
  exec = "firejail --noprofile --net=wlp3s0 vesktop";
  icon = "vesktop";
  terminal = false;
  type = "Application";
  categories = [ "Network" "InstantMessaging" ];
};

  # services.mpd = {
  #   enable = true;
  #   musicDirectory = "${home_dir}/Music";
  #   extraConfig = ''
  #     bind_to_address "$XDG_RUNTIME_DIR/mpd_socket"
  #   '';
  # };

  # services.mpd-mpris.enable=true;


  home.packages = with pkgs; [
    ryubing
    cava
    inputs.ytm-player.packages.${system}.default
    unstable.yt-dlp
    the-powder-toy
    osu-lazer
    # rmpc
  ];
}
