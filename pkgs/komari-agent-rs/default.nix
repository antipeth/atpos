{
  lib,
  stdenvNoCC,
  fetchurl,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "komari-agent";
  version = "1.0.83";
  src = fetchurl {
    url = "https://github.com/GenshinMinecraft/komari-monitor-rs/releases/download/latest/komari-monitor-rs-linux-x86_64-musl";
    sha256 = "sha256-99EcIjMtape2DynxpjkuzK0kceWVOHGR7njxuStSTf8=";
  };
  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src $out/bin/komari-agent-rs
    chmod +x $out/bin/komari-agent-rs
    runHook postInstall
  '';
  meta = with lib; {
    description = "Komari Monitor Agent in Rust";
    homepage = "https://github.com/GenshinMinecraft/komari-monitor-rs";
    license = licenses.free;
    platforms = ["x86_64-linux"];
    maintainers = [atp];
  };
}
