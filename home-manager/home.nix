{ inputs, config, lib, pkgs, ... }:

{
  imports = [ 
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "keloran";
    homeDirectory = "/home/keloran";
    stateVersion = "24.11";
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
    home-manager = {
      enable = true;
    };
  };

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };

  home-manager = {
    users = {
      keloran = {
        home = {
          stateVersion = "24.11";
          
          packages = with pkgs; [
            neovim
	    unzip
	    git
	    rustup
	    ripgrep
	    yq
	    jq
	    rustc
	    fastfetch
	    pnpm
	    nodejs_22
	    go
	    gotools
	    google-chrome
	    _1password-cli
	    _1password-gui
	    alacritty
          ];
        };
      };
    };
  };
}
