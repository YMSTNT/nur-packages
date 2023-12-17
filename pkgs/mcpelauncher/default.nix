{ lib, appimageTools, fetchurl }:

let
  version = "0.12.1-763";
  pname = "mcpelauncher";

  src = fetchurl {
    url = "https://github.com/minecraft-linux/appimage-builder/releases/download/v${version}/Minecraft_Bedrock_Launcher-x86_64-v${builtins.replaceStrings ["-"] ["."] version}.AppImage";
    hash = "sha256-FHC4+nzldBau0ViRmgdUk2nPIPJi8WI4IxQTtzpO1W4=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}

    #install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
    #install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    #substituteInPlace $out/share/applications/${pname}.desktop \
    #  --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "An unofficial Minecraft: Bedrock Edition launcher for Linux";
    longDescription = ''
      An unofficial Minecraft: Bedrock Edition launcher for Linux
    '';
    homepage = "https://mcpelauncher.readthedocs.io";
    downloadPage = "ttps://github.com/minecraft-linux/appimage-builder/releases/";
    license = licenses.gpl3Only;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = with maintainers; [ ymstnt ];
    platforms = [ "x86_64-linux" ];
  };
}