{ config, lib, pkgs, ... } :

let
  profileUUID = "9e6bced8-89d4-4c52-aead-bbd59cbaad09";
in {
  config = {
    fonts.fontconfig.enable = true;
    dconf.settings = {

      # idk ¯\_(·-·)_/¯
      "org/gnome/terminal/legacy" = {
        theme-variant = "dark";
      };
      "org/gnome/terminal/legacy/profiles:" = {
        default = profileUUID;
        list = [ profileUUID ];
      };
      "org/gnome/terminal/legacy/profiles:/:${profileUUID}" = {
        audible-bell = false;
        bold-color-same-as-fg = true;
        use-transparent-background = true;
        background-transparency-percent = 10;
      };

      # General settings
      "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
      "org/gnome/settings-daemon/plugins/color".night-light-enabled = false;
      "org/gnome/desktop/sound".event-sounds = false;
      "org/gnome/desktop/wm/preferences".num-workspaces = 6;
      "org/gnome/shell/app-switcher".current-workspace-only = false;
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        gtk-theme = "Adwaita-dark";
      };
      "org/gnome/mutter" = {
        workspaces-only-on-primary = true;
        dynamic-workspaces = true;
        edge-tiling = true;
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = 3600;
      };


      # Extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "wsmatrix@martin.zurowietz.de"
          "gsconnect@andyholmes.github.io"
          "wsmatrix@martin.zurowietz.de"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "caffeine@patapon.info"
          "unite@hardpixel.eu"
          "dash-to-dock@micxgx.gmail.com"
          
        ];
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        always-center-icons = false;
        apply-custom-theme = false;
        autohide = true;
        background-color = "rgb(192,28,40)";
        background-opacity = 0.6;
        custom-background-color = false;
        custom-theme-customize-running-dots = false;
        custom-theme-running-dots-border-color = "rgb(255,255,255)";
        custom-theme-running-dots-color = "rgb(98,160,234)";
        custom-theme-shrink = false;
        dash-max-icon-size = 38;
        dock-fixed = false;
        dock-position = "BOTTOM";
        extend-height = false;
        height-fraction = 0.6;
        hide-tooltip = false;
        hot-keys = false;
        icon-size-fixed = false;
        intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
        isolate-workspaces = false;
        max-alpha = 0.8;
        preferred-monitor = -2;
        preferred-monitor-by-connector = "DP-3";
        pressure-threshold = 250.0;
        preview-size-scale = 0.0;
        running-indicator-dominant-color = false;
        running-indicator-style = "DOTS";
        scroll-to-focused-application = true;
        show-apps-at-top = false;
        show-favorites = true;
        show-icons-emblems = true;
        show-mounts-network = false;
        show-mounts-only-mounted = true;
        show-show-apps-button = false;
        transparency-mode = "FIXED";
        unity-backlit-items = false;
      };
      "org/gnome/shell/extensions/unite" = {
        app-menu-ellipsize-mode = "end";
        app-menu-max-width = 0;
        autofocus-windows = true;
        enable-titlebar-actions = false;
        extend-left-box = false;
        greyscale-tray-icons = false;
        hide-activities-button = "auto";
        hide-app-menu-icon = false;
        hide-dropdown-arrows = true;
        hide-window-titlebars = "both";
        notifications-position = "center";
        reduce-panel-spacing = false;
        show-desktop-name = true;
        show-legacy-tray = false;
        show-window-buttons = "never";
        show-window-title = "tiled";
        window-buttons-placement = "left";
        window-buttons-theme = "default";
      };
      "org/gnome/shell/extensions/caffeine" = {
      countdown-timer = 0;
      duration-timer = 3;
      indicator-position = 0;
      indicator-position-index = 0;
      indicator-position-max = 3;
      restore-state = true ;
      show-indicator = "only-active";
      show-notifications = true;
      toggle-shortcut = [ "" ];
      toggle-state = true;
      user-enabled = true;
      };
      "org/gnome/shell/extensions/auto-move-windows" = {
        enable = true;
        application-list=[ "code.desktop:2" "spotify.desktop:6" ];
      };
      "org/gnome/shell/extensions/wsmatrix" = {
        multi-monitor = false;
        num-columns = 3;
        popup-timeout = 400;
        scale = 0.25;
        show-overview-grid = true;
        show-thumbnails=true;
        show-workspace-names=false;
      };

      # Keybinds
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kitty";
        name = "Terminal (kitty)";
      };
    };
  };
}