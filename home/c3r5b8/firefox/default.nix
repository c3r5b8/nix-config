{
  inputs,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      AppAutoUpdate = false;
      OverrideFirstRunPage = "";
      DisableFirefoxStudies = true;
      DisablePocket = true;
      EnableTrackingProtection = {
        Cryptomining = true;
        Fingerprinting = true;
        Locked = true;
        Value = true;
      };
      OfferToSaveLogins = false;
      DontCheckDefaultBrowser = true;
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        FirefoxLabs = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
    };
    profiles.c3r5b8 = {
      id = 0;
      isDefault = true;
      name = "default";
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          vimium
          sponsorblock
          automatic-dark
          stylus
          darkreader
          tampermonkey
        ];
      };
      search = {
        force = true;
        default = "ddg";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = ["@nw"];
          };
        };
      };
    };
  };
}
