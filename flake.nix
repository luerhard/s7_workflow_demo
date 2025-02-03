{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/1bde3e8e37a72989d4d455adde764d45f45dc11c";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-linux" ] (
      system:
      let


        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true; # necessary for CUDA
          };
          overlays = [
            (import ./nix/python-overlay.nix)
            (import ./nix/system-overlay.nix)
          ];
        };

        # general system dependencies
        systemDeps = with pkgs; [
          git # so git works in terminal
          glibcLocales # get rid of error msgs "unable to set locale -- default to 'C'" in R
          R # necessary, otherwise no package is found in R
          pandoc
          ruff
          python3Packages.papermill
          dvc
        ];

        # Linux CUDA deps.
        # Currently broken for python312 (?) Mismatch in driver version.
        # linuxCudaDeps =
        #   if system == "x86_64-linux" then
        #     with pkgs;
        #     [
        #       cudatoolkit
        #       linuxPackages.nvidia_x11
        #       cudaPackages.cudnn
        #     ]
        #   else
        #     [ ];

        # all R packages go here
        rEnv = with pkgs.rPackages; [
          here
          reticulate
          tidyverse
        ];

        # all python packages go here
        pyEnv = pkgs.python311.withPackages (
          ppkgs: with ppkgs; [
            pip # important for reticulate
            ipykernel # important for jupyter integration
            matplotlib
            pandas
            pytest
          ]
        );

      in
      {
        defaultPackage = pkgs.mkShell {
          packages = [
            pyEnv # needs to be @ top of list, so the correct python interpreter is exposed
            rEnv
            # linuxCudaDeps
            systemDeps
          ];

          ldLibPath = if system == "x86_64-linux" then "${pkgs.linuxPackages.nvidia_x11}/lib" else "";

          shellHook = ''
                      export PYTHONPATH="$(pwd):$PYTHONPATH"
                      # export LD_LIBRARY_PATH="$ldLibPath:$LD_LIBRARY_PATH"
                      export RETICULATE_PYTHON=$(which python)
            	  '';
        };
      }
    );
}
