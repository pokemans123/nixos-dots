{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  pkgs = pkgs.texlive.withPackages (ps: [
    ps.english
  ]);
}
