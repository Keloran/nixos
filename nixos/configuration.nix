# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Actual 1 liners
  time.timeZone = "Europe/London";
  console.keyMap = "uk";
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  system = {
    stateVersion = "24.11";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://channels.nixos.org/nixos-24.11";
    };
  };
  
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
  };


  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };
  
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "gb";
	variant = "";
      };
    };
    displayManager = {
      sddm = {
        wayland = {
	  enable = true;
	};
        enable = true;
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
    printing = {
      enable = true;
    };
  };

  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs; in {
    settings = {
      experimental-features = "nix-command flakes";
      nix-path = config.nix.nixPath;
      allowed-users = [
        "@wheel"
      ];
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  users = {
    users = {
      keloran = {
        isNormalUser = true;
	description = "Keloran";
	extraGroups = [
	  "networkmanager"
	  "wheel"
	];
	packages = with pkgs; [
	  kdePackages.kate
	];
      };
    };
  };
  
  services = {
    openssh = {
      enable = true;
    };
    locate = {
      enable = true;
      package = pkgs.mlocate;
      interval = "hourly";
      localuser = null;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
	support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      nerdfonts
    ];
    shellAliases = {
      vi = "nvim";
    };
    etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
	  zen-browser
	  google-chrome-stable
	'';
	mode = "0755";
      };
    };
  };

  programs = {
    firefox = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    _1password = {
      enable = true;
    };
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["keloran"];
    };
    git = {
      enable = true;
    };
  };
}
