{
  description = "Slidev development and presentation environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (pkgs) lib;
          nodejs = pkgs.nodejs_24;
          isLinux = pkgs.stdenv.hostPlatform.isLinux;
        in
        {
          default = pkgs.mkShell {
            name = "slidev";

            packages = [
              nodejs
              pkgs.pnpm_12
              pkgs.git
              pkgs.python3
              pkgs.pkg-config
            ]
            ++ lib.optionals isLinux [
              pkgs.chromium
              pkgs.fontconfig
            ];

            # mkShell supplies a compiler and make for native Node.js addons.
            buildInputs = lib.optionals isLinux [ pkgs.libsecret ];
            npm_config_nodedir = "${nodejs}";
            npm_config_python = "${pkgs.python3}/bin/python3";

            # Use pnpm from Nix instead of downloading the packageManager version.
            npm_config_manage_package_manager_versions = "false";

            shellHook = lib.optionalString isLinux ''
              # Upstream browser binaries cannot run directly on NixOS.
              export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
              export CYPRESS_INSTALL_BINARY=0
              export SLIDEV_CHROMIUM_PATH="${lib.getExe pkgs.chromium}"
              export FONTCONFIG_FILE="${
                pkgs.makeFontsConf {
                  fontDirectories = [
                    pkgs.dejavu_fonts
                    pkgs.noto-fonts-cjk-sans
                    pkgs.noto-fonts-color-emoji
                  ];
                }
              }"
            '';
          };
        }
      );
    };
}
