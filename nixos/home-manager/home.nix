{ lib, pkgs, ... }:

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
      userName = "keloran";
      userEmail = "keloran@chewedfeed.com";
      extraConfig = {
        gpg = {
	        format = "ssh";
	      };
	      "gpg \"ssh\"" = {
	        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
 	      };
	      commit = {
	        gpgsign = true;
	      };
	      user = {
	        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxKs7zVMUjUHGzMLNAQA3GTRzQIucJZkrvhFsaRvdAw";
	      };
      };
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
}
