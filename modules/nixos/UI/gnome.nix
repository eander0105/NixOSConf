{ config, pkgs, ... } :
{
  config = {
    environment = {
      systemPackages = with pkgs; [
        # firefox
        # wl-clipboard
        spotify
        gnomeExtensions.appindicator
        gnomeExtensions.gsconnect
        gnomeExtensions.workspace-matrix
      ];
      gnome.excludePackages = with pkgs.gnome; [
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
      ];
    };
    
    services.xserver = {
      displayManager.gdm = {
        enable = true;
        settings.greeter.includeAll = true;
      };
      desktopManager.gnome.enable = true;
      layout = "se";
      xkbVariant = "";
    };

  };
}