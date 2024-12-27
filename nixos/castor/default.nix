{ inputs, outputs, config, pkgs, ... } :

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../modules/nixos/UI/gnome.nix
    ./home.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "castor";
    networkmanager.enable = true;
    # wireless.enable = true;
    extraHosts = ''
      127.0.0.1 nixos castor
    '';
  };

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

  services.printing.enable = true;

  users.users.emil = {
    initialPassword = "qwerty";
    isNormalUser = true;
    description = "Emil Andersson";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "docker" ];
    packages = with pkgs; [
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
      winetricks
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Firefox
  programs.firefox.enable = true;

  services.envfs.enable = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
    vscode

    docker
    docker-compose
    gnumake
    python311
    nodejs
    mkcert
    nssTools

    
  ];

  services.teamviewer.enable = true;

  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  # Disable the firewall
  networking.firewall.enable = false;

  ## 
  system.stateVersion = "24.05";
}
