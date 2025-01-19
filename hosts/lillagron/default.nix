{ inputs, outputs, config, pkgs, ... } :

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../modules/UI/gnome.nix
    ./home.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxPackages_6_6;
    # Make v4l2loopback kernel module available to NixOS.
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    # Activate kernel module(s).
    kernelModules = [
      # Virtual camera.
      "v4l2loopback"
      # Virtual Microphone. Custom DroidCam v4l2loopback driver needed for audio.
      "snd-aloop"
    ];
    extraModprobeConfig = ''
      # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
      # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
      # https://github.com/umlaeute/v4l2loopback
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
  security.polkit.enable = true;


  # TODO: rename to "lillagron"
  networking = {
    hostName = "lillagron";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 nixos
    '';
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "sv_SE.UTF-8";
  i18n.extraLocaleSettings = {
    # LC_ADDRESS = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    # LC_IDENTIFICATION = "en_US.UTF-8";
    # LC_MEASUREMENT = "en_US.UTF-8";
    # LC_MONETARY = "en_US.UTF-8";
    # LC_NAME = "en_US.UTF-8";
    # LC_NUMERIC = "en_US.UTF-8";
    # LC_PAPER = "en_US.UTF-8";
    # LC_TELEPHONE = "en_US.UTF-8";
    # LC_TIME = "en_US.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    tmux
    wget
    kitty
    dconf
    appimage-run

    discord
    legcord

    jre8
    jdk8
    python3
    nodejs
    docker
    docker-compose
    vlc
    codeium
    gcc
    go
    gnumake

    droidcam
    v4l-utils
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        droidcam-obs
      ];
    })

    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    # Gaming
    steam
    lutris
    prismlauncher # super duper minecraft launcher
    # proton-ge-bin

    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
  ];

  environment.sessionVariables = {
    GSK_RENDERER = "gl";
  };

  programs.java.enable = true;

  # To make codeium work?
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  programs.gamemode.enable = true;

  services.solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window = "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };


  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # programs.starship = {
  #   enable = true;
  # }

  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   plugins = with pkgs.vimPackages; [
  #     nvim-lspconfig
  #     neodev-nvim
  #     nvim-cmp
  #     comment-nvim
  #     gruvbux-nvim
  #   ]
  # };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };


  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Open ports in the firewall.
  # 25565 is the default port for Minecraft.
  # 3000 is the default port for Jellyfin.
  networking.firewall.allowedTCPPorts = [ 25565 3000 443 80 8080 8000 5173 ];
  networking.firewall.allowedUDPPorts = [ 25565 3000 443 80 8080 8000 5173 ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
