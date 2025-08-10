# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.limine.maxGenerations = 5;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;



  boot.kernelParams = [
        "transparent_hugepage=always"
             ];
   
  system.activationScripts.sysfs.text = ''
    echo advise > /sys/kernel/mm/transparent_hugepage/shmem_enabled
    echo 0 > /sys/kernel/mm/transparent_hugepage/khugepaged/defrag
  '';


  networking.hostName = "Darkstar"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  services.pulseaudio.support32Bit = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.valkyrie = {
    isNormalUser = true;
    description = "Valkyrie";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kdePackages.kate
   
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  
  # Enable KDE Connect
  programs.kdeconnect.enable = true;  

  # Install Tailscale
  # services.tailscale.enable = true;

  # Install git
    programs.git = {
    enable = true;
        };
  
  # Install Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  

  # Install Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  extraCompatPackages   = with pkgs; [ proton-ge-bin ];
  extraPackages         = with pkgs; [
  mangohud
      ]; 
 };
  
  # Enable 32bit Drivers
  
  hardware.graphics.enable32Bit = true;

  # Install Gamemode
  programs.gamemode.enable = true;
  
  # programs.zoxide.enable =  true;
  # programs.zoxide.enableBashIntegration = true;

  # Enable Fish Shell
  programs.fish.enable = true;
  # Generate Completions from man Pages
  programs.fish.generateCompletions = true;
  
  # Enable Starship Prompt
  programs.starship.enable = true;

  # Enable OpenRGB

  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd"; 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

	speedtest-cli # Command line interface for testing internet bandwidth using speedtest.net
	bitwarden-desktop # Secure and free password manager
	btop # Monitor of resources
	vscode # Open source source code editor developed by Microsoft
	prismlauncher # Free, open source launcher for Minecraft
	xdg-dbus-proxy # DBus proxy for Flatpak and others
	protonup-qt # Install and manage Proton-GE
	trayscale # Unofficial GUI wrapper around the Tailscale CLI client
	moonlight-qt # Remote Streaming Client
	fastfetch # Actively maintained, feature-rich and performance oriented, neofetch like system information tool		
	warehouse # Manage all things Flatpak
	mission-center # Monitor your CPU, Memory, Disk, Network and GPU usage
	fira-code # Monospace font with programming ligatures
	umu-launcher # Unified launcher for Windows games on Linux using the Steam Linux Runtime and Tools
	#ulauncher # Fast application launcher for Linux, written in Python, using GTK
	starship # Minimal, blazing fast, and extremely customizable prompt for any shell
	nextcloud-client # Desktop sync client for Nextcloud
	maestral # Open-source Dropbox client for macOS and Linux
	maestral-gui # GUI front-end for maestral (an open-source Dropbox client) for Linux
	gh # GitHub CLI tool
	#vintagestory
	micro # Modern and intuitive terminal-based text editor
	remmina	# Remote desktop client written in GTK
	openrgb # Open source RGB lighting control
	pika-backup # Simple backups based on borg
	kitty # The fast, feature-rich, GPU based terminal emulator
	mesa # Open source 3D graphics library
	resources # Monitor your system resources and processes
	vlc # Cross-platform media player and streaming server
	plexamp # Beautiful Plex music player for audiophiles, curators, and hipsters
	#plex # Media library streaming server
	#jellyfin # Free Software Media System
	git
	
  ];

 


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable SSD Trim Timer
  services.fstrim.enable = true;

  # Enable Tailscale 
  services.tailscale = {
      enable = true;
      openFirewall = true;
    };

  # Enable Flatpak
  #  services.flatpak.enable = true;

  # Enable ZRAM
    zramSwap = {
    enable = true;
    algorithm = "lz4";
               };  

  # Enable Garbage Collection
  # nix.optimise.automatic = true;
  
  nix.gc = {
  automatic = true;
  dates = "daily";
  options = "--delete-older-than 3d";
  };
  
  nix.settings = {
  download-buffer-size = 524288000; # Example: 500 MiB (500 * 1024 * 1024 bytes)  
  };	

  # Bluetooth
  hardware.bluetooth.enable = true;	


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
