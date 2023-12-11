{ inputs, outputs, config, pkgs, ... } :
{
  config = {
    environment = {

      systemPackages = with pkgs; [
        firefox
        chromium
        vscode
        spotify
        wl-clipboard
        gnome.adwaita-icon-theme
        gnomeExtensions.appindicator
        gnomeExtensions.gsconnect
        gnomeExtensions.workspace-matrix
        gnomeExtensions.auto-move-windows
        gnomeExtensions.unite
      ];

      gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
      ]) ++ (with pkgs.gnome; [
        cheese # webcam tool
        gedit # text editor
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        pkgs.gnome-console
        pkgs.gnome-connections
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-weather
        gnome-characters
      ]);
    };

    programs.gnome-terminal.enable = true;

    programs.zsh.vteIntegration = true;

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
              area-screenshot = [ "<Primary><Shift>Print" ];
            };
          };
          lockAll = true;
        }
      ];
    };

    # services.udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
    
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        settings.greeter.includeAll = true;
      };
      desktopManager.gnome.enable = true;
      layout = "se";
      xkbVariant = "";
      
    };

    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  };
}