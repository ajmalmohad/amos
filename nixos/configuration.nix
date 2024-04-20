{
  config,
  pkgs,
  inputs,
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
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

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
    LC_CTYPE = "en_US.utf8";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
      ];
    };
  };

  services.printing.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  nixpkgs.config.allowUnfree = true;

  users.users.ajmalmohad = {
    isNormalUser = true;
    description = "Ajmal Mohad";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    wget
    gparted
    ntfs3g
    neofetch
    alejandra
    openssl
    gnome.gnome-keyring
    picom
    dmenu
    rofi

    git
    tmux
    zsh
    fzf
    neovim
    vscode
    brave
    nodejs_21
    typescript
    nodePackages.ts-node
    nodePackages_latest.pnpm
  ];

  programs = {
    zsh.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system.stateVersion = "23.11";
}
