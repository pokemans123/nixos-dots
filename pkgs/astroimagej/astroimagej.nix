{ lib, stdenv, fontconfig, freetype, fetchurl, autoPatchelfHook, makeWrapper,
  xorg, libGL, zlib, dejavu_fonts, alsa-lib, ... }:

let
  sources = {
    x86_64-linux = {
      url = "https://github.com/astroimagej/astroimagej/releases/download/6.0.9.00/AstroImageJ-6.0.9.00-linux-x64.tgz";
      hash = "sha256-oV1iygqoX0Ep+rfGMmzZ+BD588QiznsSZKHSr5gFJfc=";
    };
    #   nix-prefetch-url --type sha256 <url>
    #   nix hash to-sri --type sha256 <result>
    aarch64-linux = {
      url = "https://github.com/astroimagej/astroimagej/releases/download/6.0.9.00/AstroImageJ-6.0.9.00-linux-aarch64.tgz";
      hash = "sha256-YGekaKBsY26kXYrncnkCPaoyQpio8mktoG9WRzI3PNk=";
    };
  };
  source = sources.${stdenv.hostPlatform.system}
    or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "astroimagej";
  version = "6.0.9.00";

  src = fetchurl source;

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  buildInputs = [
    xorg.libX11
    xorg.libXext
    xorg.libXtst
    xorg.libXrender
    xorg.libXi
    libGL
    fontconfig
    freetype
    zlib
    alsa-lib
    stdenv.cc.cc.lib
  ];

  # Tell autoPatchelfHook to also search the bundled JRE's lib dirs,
  # so it can patch the JRE binaries without a manual patchelf loop.
  postUnpack = ''
    addAutoPatchelfSearchPath "$sourceRoot/lib/runtime/lib"
    addAutoPatchelfSearchPath "$sourceRoot/lib/runtime/lib/server"
  '';

  sourceRoot = "astroimagej";
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/astroimagej
    cp -a . $out/opt/astroimagej/

    mkdir -p $out/bin
    makeWrapper $out/opt/astroimagej/bin/AstroImageJ $out/bin/astroimagej \
      --chdir "$out/opt/astroimagej" \
      --set-default JAVA_TOOL_OPTIONS "-Dawt.useSystemAAFontSettings=on" \
      --set FONTCONFIG_FILE "${fontconfig.out}/etc/fonts/fonts.conf" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ fontconfig freetype dejavu_fonts ]}" \
      --set XDG_DATA_DIRS "${dejavu_fonts}/share"

    mkdir -p $out/share/applications
    cat > $out/share/applications/astroimagej.desktop << EOF
    [Desktop Entry]
    Name=AstroImageJ
    Comment=ImageJ-based astronomy image processing
    Exec=$out/bin/astroimagej
    Terminal=false
    Icon=$out/opt/astroimagej/AstroImageJ.png
    Type=Application
    Categories=Science;Astronomy;
    EOF

    runHook postInstall
  '';

  meta = {
    description = "ImageJ-based astronomy image processing and photometry tool";
    homepage = "https://astroimagej.com";
    license = lib.licenses.gpl3Plus;
    platforms = [ "x86_64-linux" "aarch64-linux" ]; # add "aarch64-linux" once hash is confirmed
    mainProgram = "astroimagej";
  };
}
