{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  imports = [ ./system.nix ];

  time.timeZone = "Asia/Dubai";
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    enable = true;
    package = pkgs.nixVersions.nix_2_28;

    optimise.automatic = true;

    settings = {
      keep-outputs = true;
      keep-derivations = true;

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      extra-platforms = mkIf config.isDarwin [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
