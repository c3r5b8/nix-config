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
      Extensions.Install = map (
        ex: "https://addons.mozilla.org/firefox/downloads/latest/${ex}/latest.xpi"
      ) ["ublock-origin" "bitwarden-password-manager"];
    };
    profiles.c3r5b8 = {
      id = 0;
      isDefault = true;
      name = "default";
      extensions = {
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          bitwarden
          vimium
          sponsorblock
        ];
      };
      search = {
        force = true;
        default = "ddg";
      };
    };
  };
}
