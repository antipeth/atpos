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
    url = "https://github.com/komari-monitor/komari-agent/releases/download/1.0.83/komari-agent-linux-amd64";
    sha256 = "sha256-v+5wewXrHYiooeGllkWfiau0tv7xZOOMDa2vlwXWvSs=";
  };
  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src $out/bin/komari-agent
    chmod +x $out/bin/komari-agent
    runHook postInstall
  '';
  meta = with lib; {
    description = "komari agent";
    homepage = "https://github.com/komari-monitor/komari-agent";
    license = licenses.free;
    platforms = ["x86_64-linux"];
    maintainers = [atp];
  };
}
