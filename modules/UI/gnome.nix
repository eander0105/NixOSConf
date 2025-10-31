{ inputs, outputs, config, pkgs, ... } :
{
  config = {

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

    environment = {
      systemPackages = with pkgs; [
        # General pkgs
        # firefox
        chromium
        vscode
        spotify
        wl-clipboard
        mangohud
        darktable
        # piper
        freecad
        usb-modeswitch
        lact

        wofi
        ghostty
        jetbrains-mono

        # Gnome pkgs
        gnome-tweaks
        gnome-terminal
        adwaita-icon-theme
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
        cheese # webcam tool
        # gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        yelp # Help view

        pkgs.gnome-console
        pkgs.gnome-connections
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-weather
        gnome-characters
      ]);
    };

    /* programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    }; */
    programs = {
      gnome-terminal = {
        enable = true;
      };

      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/settings-daemon/plugins/media-keys" = {
                area-screenshot = [ "<Primary><Shift>Print" ];
              };
            };
            lockAll = true;
          }
        ];
      };
    };


    # services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    # services.udev.extraRules = ''
    #   ATTR{idVendor}=="046d", ATTR{idProduct}=="c261", RUN+="usb_modeswitch '%b/%k'"
    # '';

    services.ratbagd.enable = true;

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    hardware.graphics = {
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        amdvlk
        driversi686Linux.amdvlk

        rocmPackages.clr.icd

        # Jellyfin
        /* intel-media-driver
        intel-vaapi-driver
        vaapiVdpau
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
        # OpenCL support for intel CPUs before 12th gen
        # see: https://github.com/NixOS/nixpkgs/issues/356535
        # intel-compute-runtime-legacy1
        vpl-gpu-rt # QSV on 11th gen or newer
        intel-media-sdk # QSV up to 11th gen */
      ];
    };

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
