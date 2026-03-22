{
  lib,
  nix-update-script,
  buildNpmPackage,
  fetchFromCodeberg,
  nodejs_22,
  kwin,
  kpackage,
  zip,
}:
buildNpmPackage (finalAttrs: {
  pname = "krohnkite";
  version = "0.9.9.2";

  src = fetchFromCodeberg {
    owner = "anametologin";
    repo = "Krohnkite";
    rev = "fac21fefc7e1ec18b362832f70b6b70656309d83";
    hash = "sha256-9zrNKkcH04KcpiyNPZXU0K8iQpJEnKOO2c3doTVRBCk=";
  };
  patches = [./krohnkite-dont-resize-virtual-keyboard.patch];

  npmDepsHash = "sha256-MCfG0C+h2VC/eKO2Js31vrCt0AXTGrkXptwKjdQzwLQ=";

  dontWrapQtApps = true;

  nodejs = nodejs_22;

  nativeBuildInputs = [
    kpackage
    zip
    kwin
  ];

  npmBuildScript = "tsc";

  installPhase = ''
    runHook preInstall

    substituteInPlace Makefile --replace-fail '7z a -tzip' 'zip -r'
    # Override PROJECT_VER and PROJECT_REV because we don't have .git
    make \
      KWINPKG_FILE=krohnkite.kwinscript \
      PROJECT_REV=${finalAttrs.version} \
      PROJECT_VER=${finalAttrs.version} \
      krohnkite.kwinscript
    kpackagetool6 --type=KWin/Script --install=krohnkite.kwinscript --packageroot=$out/share/kwin/scripts

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Dynamic Tiling Extension for KWin 6";
    homepage = "https://codeberg.org/anametologin/Krohnkite";
    changelog = "https://codeberg.org/anametologin/Krohnkite/releases/tag/${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      ben9986
      dramforever
    ];
    platforms = lib.platforms.all;
  };
})
