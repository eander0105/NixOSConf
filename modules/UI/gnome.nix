{ inputs, outputs, config, pkgs, ... } :
let
  unstable = inputs.unstable.legacyPackages.${pkgs.system};
in
{
  config = {
    services.xserver = {
      enable = true;
    };
    services.displayManager.gdm = {
      enable = true;
      settings.greeter.includeAll = true;
    };
    services.desktopManager.gnome = {
      enable = true;
    };

    # TODO: Add to hyprland later
    # windowManager.hyprland = {
    #   enable = true;
    # };

    services.xserver.xkb = {
      layout = "se";
      variant = "";
    };

    environment = {
      systemPackages = with pkgs; [
        # General pkgs
        firefox
        chromium
        vscode
        spotify
        wl-clipboard
        mangohud
        darktable
        signal-desktop
        neovide

        ## Refactor this to a separate file
        # mangohud
        # darktable
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

      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };


    services.ratbagd.enable = true;

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    hardware.graphics = {
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    services.pulseaudio.enable = false;
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
