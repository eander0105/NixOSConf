{ inputs, outputs, config, pkgs, ... } :
{
  config = {
    environment = {

      systemPackages = with pkgs; [
        # General pkgs
        # firefox
        chromium
        # vscode
        spotify
        # wl-clipboard
        # mangohud
        # darktable
        # piper
        # freecad
        # usb-modeswitch

        # Gnome pkgs
        gnome.gnome-tweaks
        gnome.gnome-terminal
        gnome.adwaita-icon-theme
        gnomeExtensions.blur-my-shell
        gnomeExtensions.appindicator
        gnomeExtensions.gsconnect
        gnomeExtensions.workspace-matrix
        gnomeExtensions.auto-move-windows
        gnomeExtensions.unite
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
      ];

      gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
      ]) ++ (with pkgs.gnome; [
        cheese # webcam tool
        # gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        # pkgs.gnome-console
        pkgs.gnome-connections
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-weather
        gnome-characters
      ]);
    };

    programs.gnome-terminal = {
      enable = true;
    };
    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/settings-daemon/plugins/media-keys" = {
              area-screenshot = [ "<Primary><Shift>S" ];
            };
          };
          lockAll = true;
        }
      ];
    };

    # services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    # services.udev.extraRules = ''
    #   ATTR{idVendor}=="046d", ATTR{idProduct}=="c261", RUN+="usb_modeswitch '%b/%k'"
    # '';

    # services.ratbagd.enable = true;

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    /* hardware.opengl = {
      driSupport = true;# This is already enabled by default
      driSupport32Bit = true;# For 32 bit applications
      extraPackages = with pkgs; [
        amdvlk
        driversi686Linux.amdvlk
      ];
    }; */

    services.xserver = {
      enable = true;
      # videoDrivers = [ "amdgpu" ];
      displayManager.gdm = {
        enable = true;
        settings.greeter.includeAll = true;
      };
      desktopManager.gnome = {
        enable = true;
        # extraGSettingsOverridePackages = [ pkgs.gnome.mutter ];
        # extraGSettingsOverride = ''
        #  [org.gnome.mutter]
        #   experimental-features=['scale-monitor-framebuffer']
        # '';
      };
      xkb = {
        layout = "se";
        variant = "";
      };
    };

    sound.enable = false;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      # jack.enable = true;
    };

  };
}
