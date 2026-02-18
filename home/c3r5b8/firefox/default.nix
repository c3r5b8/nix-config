{
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
      Extensions.Install = map (
        ex: "https://addons.mozilla.org/firefox/downloads/latest/${ex}/latest.xpi"
      ) ["ublock-origin" "bitwarden-password-manager"];
    };
    profiles.c3r5b8 = {
      search = {
        force = true;
        default = "ddg";
      };
    };
  };
}
