{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  nix = {
    settings.auto-optimise-store = true;
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 7d";
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
    configurationLimit = 5;
  };

  networking.hostName = "ajmalmohad";
  # networking.wireless.enable = true;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.printing.enable = true;
  services.openssh.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  users.users.ajmalmohad = {
    isNormalUser = true;
    description = "Ajmal Mohad";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    gparted
    ntfs3g
    neofetch
    alejandra

    git
    tmux
    zsh
    fzf
    neovim
    vscode
    vivaldi
    nodejs
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11";

  # nix flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
