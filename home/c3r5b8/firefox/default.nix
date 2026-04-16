{
  pkgs,
  lib,
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
      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.startup.page" = 3;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "browser.ai.control.linkPreviewKeyPoints" = "blocked";
        "browser.ai.control.sidebarChatbot" = "blocked";
        "browser.display.use_document_fonts" = 0;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.search.suggest.enabled.private" = true;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["newtaboverride_agenedia_com-browser-action","addon_darkreader_org-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","vertical-spacer","urlbar-container","downloads-button","fxa-toolbar-menu-button","unified-extensions-button","ublock0_raymondhill_net-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":[]},"seen":["developer-button","screenshot-button","newtaboverride_agenedia_com-browser-action","addon_darkreader_org-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ublock0_raymondhill_net-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","unified-extensions-area","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":23,"newElementCount":3}'';
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "font.size.monospace.x-western" = 14;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}
