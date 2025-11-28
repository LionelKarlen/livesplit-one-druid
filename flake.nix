{
  description = "Solidjs + Pocketbase flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = {
          default =
            with pkgs;
            mkShell {
              nativeBuildInputs = [
                pkg-config
                wrapGAppsHook3
              ];
              buildInputs = [
                glib
                pango
                gtk3
              ];
              # https://nixos.wiki/wiki/Development_environment_with_nix-shell#No_GSettings_schemas_are_installed_on_the_system
              shellHook = ''
                export XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH
              '';
            };
        };
      }
    );
}
