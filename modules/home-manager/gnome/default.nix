{ config, lib, pkgs, ... } :

let
  profileUUID = "9e6bced8-89d4-4c52-aead-bbd59cbaad09";
in{
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

      # Generall settings
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
        ];
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