{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./hardware.nix];

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

  boot.supportedFilesystems = ["ntfs"];

  networking = {
    hostName = "ajmalmohad";
    networkmanager.enable = true;
    firewall.enable = false;
  };

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

  services = {
    printing.enable = true;
    openssh.enable = true;
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

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  security.rtkit.enable = true;
  programs.zsh.enable = true;
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
    pavucontrol

    dmenu
    rofi
    feh

    git
    tmux
    zsh
    fzf
    alacritty
    neovim
    vscode
    brave
    nodejs_21
    typescript
    nodePackages.ts-node
    nodePackages_latest.pnpm

    rustup
    gcc
    go
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system.stateVersion = "23.11";
}
