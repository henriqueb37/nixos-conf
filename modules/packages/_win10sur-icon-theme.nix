{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  numix-icon-theme-circle,
  jdupes,
  circleFolderIcons ? false,
  whitePanelIcons ? false,
  themeVariants ? [ ],
}:
let
  pname = "Win10Sur-icon-theme";
in
lib.checkListOfEnum "${pname}: theme variants"
  [
    "default"
    "black"
    "blue"
    "brown"
    "green"
    "grey"
    "orange"
    "pink"
    "purple"
    "red"
    "all"
  ]
  themeVariants
  stdenvNoCC.mkDerivation
  {
    inherit pname;
    version = "2022-05-18";

    src = fetchFromGitHub {
      owner = "yeyushengfan258";
      repo = "Win10Sur-icon-theme";
      rev = "2f41287774dffb79946f41aa2a20b90ee22aa648";
      hash = "sha256-oCouCRjT7ajYLA4VJjVC7ufWTfBhUeeAgz8M6C/l4ac=";
    };

    nativeBuildInputs = [
      gtk3
      jdupes
    ];

    buildInputs = [ numix-icon-theme-circle ];

    dontPatchELF = true;
    dontRewriteSymlinks = true;
    dontDropIconThemeCache = true;

    postPatch = ''
      patchShebangs install.sh

      # Fix upstream argument parsing bug
      sed -i 's/shift 2/shift 1/g' install.sh
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons
      ${
        if builtins.elem "all" themeVariants then
          ''
            ./install.sh --dest $out/share/icons \
              --name Win10Sur \
              -a \
              ${lib.optionalString circleFolderIcons "-c"} \
              ${lib.optionalString whitePanelIcons "-w"}
          ''
        else if themeVariants == [ ] || themeVariants == [ "default" ] then
          ''
            ./install.sh --dest $out/share/icons \
              --name Win10Sur \
              ${lib.optionalString circleFolderIcons "-c"} \
              ${lib.optionalString whitePanelIcons "-w"}
          ''
        else
          ''
            ${lib.concatMapStringsSep "\n" (theme: ''
              ./install.sh --dest $out/share/icons \
                --name Win10Sur \
                -${theme} \
                ${lib.optionalString circleFolderIcons "-c"} \
                ${lib.optionalString whitePanelIcons "-w"}
            '') (lib.remove "default" themeVariants)}
          ''
      }

      jdupes --link-soft --recurse $out/share

      runHook postInstall
    '';

    postFixup = ''
      find $out/share/icons -xtype l -delete
    '';

    meta = {
      description = "Windows 10 Sur style icon theme for Linux desktops";
      homepage = "https://github.com/yeyushengfan258/Win10Sur-icon-theme";
      license = lib.licenses.gpl3Plus;
      platforms = lib.platforms.linux;
    };
  }
