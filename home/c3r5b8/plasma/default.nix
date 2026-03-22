{
  pkgs,
  config,
  ...
}: {
  xdg.dataFile."color-schemes/Light.colors".source = ./Light.colors;
  home.file."pictures/wallpaper.jpg".source = ./wallpaper.jpg;
  gtk = {
    gtk2.configLocation = "${config.home.homeDirectory}/.config/.gtkrc-2.0";
    enable = true;
    cursorTheme = {
      name = "Bibata-Original-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme.override {color = "green";};
    };
    theme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };
  home.packages = let
    krohnkite = pkgs.callPackage ./krohnkite.nix {
      inherit (pkgs) lib nodejs_22 zip buildNpmPackage fetchFromCodeberg nix-update-script;
      inherit (pkgs.kdePackages) kwin kpackage;
    };
  in [
    krohnkite
  ];

  programs.plasma = {
    enable = true;
    fonts = {
      fixedWidth = {
        family = "FiraCode Nerd Font";
        pointSize = 10;
      };

      general = {
        family = "Fira Sans";
        pointSize = 10;
      };
      menu = {
        family = "Fira Sans";
        pointSize = 10;
      };
      small = {
        family = "Fira Sans";
        pointSize = 8;
      };
      toolbar = {
        family = "Fira Sans";
        pointSize = 10;
      };
      windowTitle = {
        family = "Fira Sans";
        pointSize = 10;
      };
    };
    input = {
      keyboard = {
        layouts = [
          {
            layout = "us";
          }
          {
            layout = "ua";
          }
        ];
        options = ["caps:escape_shifted_capslock"];
        switchingPolicy = "winClass";
      };
      touchpads = [
        {
          disableWhileTyping = true;
          enable = true;
          middleButtonEmulation = true;
          name = "ELAN06FA:00 04F3:327E Touchpad";
          naturalScroll = true;
          productId = "327e";
          tapToClick = true;
          vendorId = "04f3";
        }
      ];
    };
    krunner = {
      activateWhenTypingOnDesktop = false;
      historyBehavior = "enableSuggestions";
      position = "center";
      shortcuts = {
        launch = "Meta+D";
        runCommandOnClipboard = "";
      };
    };
    kscreenlocker = {
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
        wallpaper = "/home/c3r5b8/pictures/wallpaper.jpg";
      };
      autoLock = true;
      lockOnResume = true;
      lockOnStartup = false;
      passwordRequired = true;
      passwordRequiredDelay = 5;
      timeout = 3;
    };
    kwin = {
      borderlessMaximizedWindows = false;
      cornerBarrier = false;
      edgeBarrier = 0;
      effects = {
        blur = {
          enable = true;
          noiseStrength = 8;
          strength = 12;
        };
        cube.enable = false;
        desktopSwitching = {
          animation = "off";
          navigationWrapping = true;
        };
        dimAdminMode.enable = true;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        hideCursor = {
          enable = true;
          hideOnInactivity = 30;
          hideOnTyping = true;
        };
        invert.enable = false;
        magnifier.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = false;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
        zoom.enable = false;
      };
      scripts.polonium.enable = false;
      virtualDesktops = {
        names = [
          "Desktop 1"
          "Desktop 2"
          "Desktop 3"
          "Desktop 4"
          "Desktop 5"
          "Desktop 6"
          "Desktop 7"
          "Desktop 8"
          "Desktop 9"
        ];
        number = 9;
        rows = 1;
      };
    };
    overrideConfig = true;
    panels = [
      {
        alignment = "center";
        floating = false;
        height = 32;
        hiding = "none";
        lengthMode = "fill";
        location = "top";
        opacity = "translucent";
        screen = 0;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                alphaSort = true;
                applicationsDisplay = 0;
                favoritesPortedToKAstats = true;
                forceDarkMode = false;
                highlightNewlyInstalledApps = false;
                recentOrdering = 1;
                systemFavorites = "suspend\\,logout\\,reboot\\,shutdown";
              };
            };
          }
          {
            name = "org.kde.plasma.pager";
            config = {
              General = {
                displayedText = "Number";
                showOnlyCurrentScreen = true;
                wrapPage = true;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.battery"
              ];
              hidden = [
                "org.kde.plasma.weather"
              ];
            };
          }
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                dateDisplayFormat = "BesideTime";
                enabledCalendarPlugins = "astronomicalevents";
                showWeekNumbers = true;
              };
            };
          }
        ];
      }
    ];
    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay = {
          enable = true;
          idleTimeout = 300;
        };
        dimKeyboard.enable = false;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        turnOffDisplay = {
          idleTimeout = 600;
          idleTimeoutWhenLocked = 60;
        };
        whenLaptopLidClosed = "doNothing";
        whenSleepingEnter = "standby";
      };
      battery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 300;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 60;
        };
        dimKeyboard.enable = false;
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        turnOffDisplay = {
          idleTimeout = 90;
          idleTimeoutWhenLocked = 30;
        };
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "standby";
      };
      batteryLevels = {
        criticalAction = "sleep";
        criticalLevel = 2;
        lowLevel = 20;
      };
      general.pausePlayersOnSuspend = true;
      lowBattery = {
        autoSuspend = {
          action = "sleep";
          idleTimeout = 60;
        };
        displayBrightness = 5;
        keyboardBrightness = 0;
        powerProfile = "powerSaving";
        dimDisplay = {
          enable = true;
          idleTimeout = 30;
        };
        dimKeyboard.enable = false;
        inhibitLidActionWhenExternalMonitorConnected = false;
        powerButtonAction = "showLogoutScreen";
        turnOffDisplay = {
          idleTimeout = 45;
          idleTimeoutWhenLocked = 30;
        };
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "standby";
      };
    };
    session = {
      general.askForConfirmationOnLogout = true;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };
    shortcuts = {
      "KDE Keyboard Layout Switcher" = {
        "Switch to Last-Used Keyboard Layout" = "";
        "Switch to Next Keyboard Layout" = "Alt+Shift";
      };
      kaccess."Toggle Screen Reader On and Off" = "";
      kmix = {
        decrease_microphone_volume = "Microphone Volume Down";
        decrease_volume = "Volume Down";
        decrease_volume_small = "Shift+Volume Down";
        increase_microphone_volume = "Microphone Volume Up";
        increase_volume = "Volume Up";
        increase_volume_small = "Shift+Volume Up";
        mic_mute = [
          "Microphone Mute"
          "Meta+Volume Mute"
        ];
        mute = "Volume Mute";
      };
      ksmserver = {
        "Lock Session" = [
          "Meta+Esc"
          "Screensaver"
        ];
        "Log Out" = "Ctrl+Alt+Del";
      };
      kwin = {
        "Activate Window Demanding Attention" = [];
        "Edit Tiles" = [];
        Expose = [
        ];
        ExposeAll = [
        ];
        ExposeClass = [
        ];
        "Grid View" = [];
        "Kill Window" = [];
        MoveMouseToCenter = [];
        MoveMouseToFocus = [];
        Overview = [];
        "Show Desktop" = [];
        "Switch One Desktop Down" = [];
        "Switch One Desktop Up" = [];
        "Switch One Desktop to the Left" = [];
        "Switch One Desktop to the Right" = [];
        "Switch Window Down" = [];
        "Switch Window Left" = [];
        "Switch Window Right" = [];
        "Switch Window Up" = [];
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Walk Through Windows" = [
        ];
        "Walk Through Windows (Reverse)" = [
        ];
        "Walk Through Windows of Current Application" = [
        ];
        "Walk Through Windows of Current Application (Reverse)" = [
        ];
        "Window Close" = "Meta+Shift+Q";
        "Window Maximize" = [];
        "Window Minimize" = [];
        "Window One Desktop Down" = [];
        "Window One Desktop Up" = [];
        "Window One Desktop to the Left" = [];
        "Window One Desktop to the Right" = [];
        "Window Operations Menu" = [];
        "Window Quick Tile Bottom" = [];
        "Window Quick Tile Left" = [];
        "Window Quick Tile Right" = [];
        "Window Quick Tile Top" = [];
        "Window to Next Screen" = [];
        "Window to Previous Screen" = [];
        disableInputCapture = [];
        view_actual_size = [];
        view_zoom_in = [
        ];
        view_zoom_out = [];
        KrohnkiteBTreeLayout = [];
        KrohnkiteCascadeLayout = [];
        KrohnkiteColumnsLayout = [];
        KrohnkiteDecrease = [];
        KrohnkiteFloatAll = [];
        KrohnkiteFloatingLayout = [];
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusNext = [];
        KrohnkiteFocusPrev = [];
        KrohnkiteFocusRight = "Meta+L";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteGrowHeight = "Meta+Ctrl+J";
        KrohnkiteIncrease = [];
        KrohnkiteLowerSurfaceCapacity = [];
        KrohnkiteMeta = [];
        KrohnkiteMonocleLayout = [];
        KrohnkiteNextLayout = [];
        KrohnkitePreviousLayout = [];
        KrohnkiteQuarterLayout = [];
        KrohnkiteRaiseSurfaceCapacity = [];
        KrohnkiteRotate = [];
        KrohnkiteRotatePart = [];
        KrohnkiteSetMaster = [];
        KrohnkiteShiftDown = "Meta+Shift+J";
        KrohnkiteShiftLeft = "Meta+Shift+H";
        KrohnkiteShiftRight = "Meta+Shift+L";
        KrohnkiteShiftUp = "Meta+Shift+K";
        KrohnkiteShrinkHeight = "Meta+Ctrl+K";
        KrohnkiteShrinkWidth = "Meta+Ctrl+H";
        KrohnkiteSpiralLayout = [];
        KrohnkiteSpreadLayout = [];
        KrohnkiteStackedLayout = [];
        KrohnkiteStairLayout = [];
        KrohnkiteTileLayout = [];
        KrohnkiteToggleFloat = "Meta+Shift+Space";
        KrohnkiteTreeColumnLayout = [];
        KrohnkitegrowWidth = "Meta+Ctrl+L";
        KrohnkitetoggleDock = [];
      };
      mediacontrol = {
        nextmedia = "Media Next";
        pausemedia = "Media Pause";
        playpausemedia = "Media Play";
        previousmedia = "Media Previous";
        seekbackwardmedia = "Media Rewind";
        seekforwardmedia = "Media Fast Forward";
        stopmedia = "Media Stop";
      };
      org_kde_powerdevil = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        Hibernate = "Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        PowerDown = "Power Down";
        PowerOff = "Power Off";
        Sleep = "Sleep";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        powerProfile = [
          "Battery"
          "Meta+B"
        ];
      };
      plasmashell = {
        "activate application launcher" = [
        ];
        "activate task manager entry 1" = [];
        "activate task manager entry 2" = [];
        "activate task manager entry 3" = [];
        "activate task manager entry 4" = [];
        "activate task manager entry 5" = [];
        "activate task manager entry 6" = [];
        "activate task manager entry 7" = [];
        "activate task manager entry 8" = [];
        "activate task manager entry 9" = [];
        clipboard_action = [];
        cycle-panels = [];
        "manage activities" = [];
        "next activity" = [];
        "previous activity" = [];
        "show dashboard" = [];
        show-on-mouse-pos = "Meta+V";
      };
      "services/org.kde.konsole.desktop"._launch = "Meta+Space";
      "services/org.kde.dolphin.desktop"._launch = "Meta+E";
      "services/org.kde.plasma.emojier.desktop"._launch = "Meta+.";
      "services/org.kde.plasma-systemmonitor.desktop"._launch = "Ctrl+Shift+Esc";
      "services/systemsettings.desktop"._launch = "Meta+I";
    };
    spectacle.shortcuts = {
      captureActiveWindow = "Meta+Print";
      captureCurrentMonitor = null;
      captureEntireDesktop = "Shift+Print";
      captureRectangularRegion = "Meta+Shift+S";
      captureWindowUnderCursor = "Meta+Ctrl+Print";
      launch = "Meta+Shift+S";
    };
    workspace = {
      clickItemTo = "select";
      colorScheme = "Light";
      cursor = {
        animationTime = 5;
        cursorFeedback = "Bouncing";
        size = 24;
        taskManagerFeedback = true;
        theme = "Bibata-Original-Ice";
      };
      iconTheme = "Papirus";
      soundTheme = "freedesktop";
      splashScreen = {
        engine = "none";
        theme = "None";
      };
      theme = "default";
      tooltipDelay = 2000;
      wallpaper = "/home/c3r5b8/pictures/wallpaper.jpg";
      widgetStyle = "breeze";
      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };
    };
    configFile = {
      kdeglobals = {
        General = {
          accentColorFromWallpaper = true;
        };
      };
      breezerc = {
        "Windeco Exception 0" = {
          BorderSize = 0;
          Enabled = true;
          ExceptionPattern = ".*";
          ExceptionType = 0;
          HideTitleBar = true;
          Mask = 0;
        };
      };
      kwinrc = {
        Effect-overview.TouchBorderActivate = 4;
        TouchEdges.Top = "ApplicationLauncher";
        Wayland.InputMethod = "/run/current-system/sw/share/applications/org.kde.plasma.keyboard.desktop";
        Plugins = {
          virtualdesktopsonlyonprimaryEnabled = true;
          krohnkiteEnabled = true;
        };
        Script-krohnkite = {
          focusNormal = 6;
          movePointerOnFocus = true;
          soleWindowNoBorders = true;
          soleWindowNoGaps = true;
          spiralLayoutOrder = 1;
          tileLayoutOrder = 4;
        };
      };
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
      plasmarc.OSD.kbdLayoutChangedEnabled = false;
    };
    dataFile = {
    };
  };
}
