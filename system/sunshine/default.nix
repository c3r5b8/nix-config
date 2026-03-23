{
  pkgs,
  lib,
  ...
}: let
  sunshine-beta = let
    inherit (pkgs.stdenv.hostPlatform) isLinux;
    ffmpegBinaries = pkgs.fetchzip {
      url = "https://github.com/LizardByte/build-deps/releases/download/v2026.323.141148/Linux-x86_64-ffmpeg.tar.gz";
      hash = "sha256-jL4Ar5LNBaVrJu1BcAfQFhnSnixS2eL/T2xaIufVsg8=";
    };
    pythonWithGlad = pkgs.python3.withPackages (ps: with ps; [jinja2 setuptools pip]);
  in
    pkgs.sunshine.overrideAttrs (finalAttrs: prevAttrs: rec {
      version = "2026.323.32542";

      src = pkgs.fetchFromGitHub {
        owner = "LizardByte";
        repo = "Sunshine";
        tag = "v${version}";
        hash = "sha256-07LJaw7X8/99S409LtN4pRpuKNyDzlv5Oe+SbbtCbtM=";
        fetchSubmodules = true;
      };

      ui = pkgs.buildNpmPackage {
        inherit (finalAttrs) src version;
        pname = "sunshine-ui";
        npmDepsHash = "sha256-gXY1pRQGqcNXZRMJOdBPtvTUL/nNjD66ie4O3iySUJs=";

        # use generated package-lock.json as upstream does not provide one
        postPatch = ''
          cp ${./package-lock.json} ./package-lock.json
        '';

        installPhase = ''
          runHook preInstall

          mkdir -p "$out"
          cp -a . "$out"/

          runHook postInstall
        '';
      };

      postPatch =
        # don't look for npm since we build webui separately
        ''
          substituteInPlace cmake/targets/common.cmake \
            --replace-fail 'find_program(NPM npm REQUIRED)' ""
        ''
        + ''
          substituteInPlace src/nvenc/nvenc_base.cpp \
            --replace '#error Check and update NVENC code for backwards compatibility!' '// #error disabled for NixOS (SDK mismatch)' \
            --replace 'format_config.pixelBitDepthMinus8 = 2;' '// format_config.pixelBitDepthMinus8 = 2; # NixOS workaround' \
            --replace 'format_config.inputPixelBitDepthMinus8 = 2;' '// format_config.inputPixelBitDepthMinus8 = 2; # NixOS workaround'
        ''
        # use system boost instead of FetchContent.
        # FETCH_CONTENT_BOOST_USED prevents Simple-Web-Server from re-finding boost
        + ''
          substituteInPlace cmake/dependencies/Boost_Sunshine.cmake \
            --replace-fail 'set(BOOST_VERSION "1.89.0")' 'set(BOOST_VERSION "${pkgs.boost.version}")'
          echo 'set(FETCH_CONTENT_BOOST_USED TRUE)' >> cmake/dependencies/Boost_Sunshine.cmake
        ''
        # remove upstream dependency on systemd and udev
        + lib.optionalString isLinux ''
          substituteInPlace cmake/packaging/linux.cmake \
            --replace-fail 'find_package(Systemd)' "" \
            --replace-fail 'find_package(Udev)' ""

          substituteInPlace packaging/linux/dev.lizardbyte.app.Sunshine.desktop \
            --subst-var-by PROJECT_NAME 'Sunshine' \
            --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
            --subst-var-by SUNSHINE_DESKTOP_ICON 'sunshine' \
            --subst-var-by CMAKE_INSTALL_FULL_DATAROOTDIR "$out/share" \
            --replace-fail '/usr/bin/env systemctl start --u app-@PROJECT_FQDN@' 'sunshine'

          substituteInPlace packaging/linux/app-dev.lizardbyte.app.Sunshine.service.in \
            --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
            --subst-var-by SUNSHINE_EXECUTABLE_PATH $out/bin/sunshine \
            --replace-fail '/bin/sleep' '${lib.getExe' pkgs.coreutils "sleep"}'
        '';
      cmakeFlags =
        (prevAttrs.cmakeFlags or [])
        ++ [
          "-DFFMPEG_PREPARED_BINARIES=${ffmpegBinaries}"
          "-DPython3_EXECUTABLE=${pythonWithGlad.interpreter}"
          "-DGLAD_SKIP_PIP_INSTALL=ON"
          "-DSUNSHINE_ENABLE_CUDA=OFF"
        ];
      nativeBuildInputs =
        (prevAttrs.nativeBuildInputs or [])
        ++ [
          pythonWithGlad
          pkgs.autoPatchelfHook
          pkgs.pkg-config
          pkgs.pipewire # ← fixes libpipewire-0.3
          pkgs.sysprof # ← fixes sysprof-capture-4 / glib warnings
        ];
    });
in {
  services.sunshine = {
    enable = true;
    package = sunshine-beta;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
