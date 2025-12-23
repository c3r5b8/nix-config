{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/Console" = {
      theme = "auto";
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/settings-daemon/plugins/housekeeping" = {
      donation-reminder-last-shown = mkInt64 1766520096523585;
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [(mkTuple ["xkb" "us"])];
      sources = [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "ua"])];
      xkb-options = ["caps:escape_shifted_capslock"];
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      monospace-font-name = "AdwaitaMono Nerd Font 11";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = ["org.gnome.Settings.desktop" "org.gnome.Contacts.desktop" "org.gnome.Nautilus.desktop"];
    };

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "freedesktop";
    };

    "org/gnome/desktop/wm/preferences" = {
      auto-raise = true;
      button-layout = "appmenu:close";
      focus-mode = "sloppy";
    };

    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
    };

    "org/gnome/nautilus/window-state" = {
      maximized = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/shell" = {
      favorite-apps = ["firefox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Console.desktop"];
      disable-extension-version-validation = true;
      enabled-extensions = ["AlphabeticalAppGrid@stuarthayhurst" "blur-my-shell@aunetx" "gsconnect@andyholmes.github.io" "panel-corners@aunetx" "rounded-window-corners@fxgn" "unblank@sun.wxg@gmail.com"];
      welcome-dialog-last-shown-version = "4999";
    };
    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/gsconnect" = {
      missing-openssl = false;
      name = "acrab";
    };

    "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
      settings-version = mkUint32 7;
    };

    "org/gnome/shell/extensions/unblank" = {
      power = false;
      time = 30;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
}
