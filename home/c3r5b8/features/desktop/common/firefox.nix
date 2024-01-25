{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.c3r5b8 = {
      extensions = with pkgs.inputs.firefox-addons; [
        bitwarden
        clearurls
        darkreader
        enhanced-github
        fastforwardteam
        i-dont-care-about-cookies
        one-click-wayback
        refined-github
        return-youtube-dislikes
        sidebery
        sponsorblock
        stylus
        ublock-origin
        user-agent-string-switcher
        vimium
        widegithub
      ];
      id = 0;
      name = "c3r5b8";
      search = {
        default = "Brave";
        force = true;
        order = [
          "Brave"
          "Nix Packages"
          "NixOS Wiki"
        ];
        privateDefault = "Brave";
        engines = {
          "Nix Packages" = {
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

          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };
          "Brave" = {
            urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/brave-search-icon.rCBTNmje.svg";
            definedAliases = ["@b"];
          };
        };
      };
      userChrome = ''
        /* hide indow control buttons */
        .titlebar-buttonbox-container {
          display: none !important;
        }

        /* hide tabs menu button */
        #alltabs-button {
          display: none !important;
        }

        #sidebar-header,
        #sidebar-splitter {
          display: none !important;
        }

        /* hide tabs menu when side tabs is used */
        #main-window #titlebar {
          overflow: hidden;
          transition: height 0.3s 0.3s !important;
        }

        #main-window #titlebar {
          height: 3em !important;
        }

        #main-window[uidensity="touch"] #titlebar {
          height: 3.35em !important;
        }

        #main-window[uidensity="compact"] #titlebar {
          height: 2.7em !important;
        }

        #main-window[titlepreface*="XXX"] #titlebar {
          height: 0 !important;
        }

        #main-window[titlepreface*="XXX"] #tabbrowser-tabs {
          z-index: 0 !important;
        }

        #nav-bar {
          width: 100vw !important;
        }



        #browser {
          position: relative;
        }

        #sidebar-box #sidebar-header {
          display: none;
        }

        #sidebar-box:not([hidden]) {

          display: block;

          position: absolute;
          top: 0;
          bottom: 0;
          z-index: 1;

          min-width: 40px !important;
          max-width: 40px !important;

          border-right: none;

          transition: all 0.2s ease;

          overflow: hidden;


        }

        #sidebar,
        #sidebar-box:hover {
          min-width: 10vw !important;
          width: 30vw !important;
          max-width: 250px !important;
        }

        #sidebar-box {
          background-color: black;
        }

        #sidebar {
          height: 100%;
          max-height: 100%;
          background-color: black;
        }

        #sidebar-box:not([hidden])~#appcontent {
          margin-left: 40px;
        }

        #main-window[inFullscreen][inDOMFullscreen] #appcontent {
          margin-left: 0;
        }

        #sidebar-box #sidebar-header,
        #sidebar-box~#sidebar-splitter {
          display: none;
        }


        /*
        * Sideberry css
        * Sideberry css
        * Sideberry css
        */

        /*

        #root.root {--ntb-border-radius: 10px;}
        #root.root {--tabs-border-radius: 10px;}
        #root {
            --tabs-height: 42px;
            --tabs-pinned-height: var(--tabs-height);
            --tabs-pinned-width: var(--tabs-height);
            --selected-bg: rgba(0, 108, 151, 0.8) !important;
            --selected-border: var(--selected-bg) !important;
            --fav-size: 24px;
          }

          .Tab .fav {
            width: var(--fav-size);
            height: var(--fav-size);
          }
          .Tab .fav > .fav-icon {
            width: var(--fav-size);
            height: var(--fav-size);
        }

        .top-horizontal-box, .BottomBar {
          display: none !important;
        }

        body {
        	#root.root {--tabs-indent: 0px;}
          transition: all 0.2s ease;
        	width: 40px;
        }


        body:hover {
        	#root.root {--tabs-indent: 10px;}
        	width: 250px;
        }

        */
      '';
    };
  };
}
