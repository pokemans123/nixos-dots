{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  pkgs = pkgs.texlive.withPackages (ps: [
    ps.english
  ]);
}
