# Shared base configuration for all hosts
{ config, pkgs, ... }:

{
  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Deduplicate and optimise nix store
    auto-optimise-store = true;
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Timezone & locale
  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  console.keyMap = "sv-latin1";

  # Printing
  services.printing.enable = true;

  # User account
  users.users.emil = {
    isNormalUser = true;
    description = "Emil Andersson";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Essential system packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  # Security
  security.polkit.enable = true;
}
