final: prev: rec {
    python312 = prev.python312.override {
        packageOverrides =  pyfinal: pyprev: {
            pycurl = pyprev.buildPythonPackage {
                pname = "pycurl";
                version = "7.45.4";
                pyproject = true;

                src = prev.fetchFromGitHub {
                    owner = "pycurl";
                    repo = "pycurl";
                    rev = "0e6abd49e1d6e9c2504218eb84e79fb3b72d821e";
                    hash = "sha256-WnrQhv6xiA+/Uz0hUmQxmEUasxtvlIV2EjlO+ZOUgI8=";
                };

                build-system = [ prev.python312.pkgs.setuptools ];
                nativeBuildInputs = [ prev.curl ];
                buildInputs = [
                    prev.curl
                    prev.openssl
                ];
            };
        };
    };
    dvc = prev.dvc.overrideAttrs( pyfinal: pyprev: {
        version = "3.59.0";
        pyproject = true;
        src = prev.fetchFromGitHub {
            owner = "iterative";
            repo = "dvc";
            rev = "refs/tags/3.59.0";
            hash = "sha256-yNnOSYh4lCefTnIgNstsKaRbrPCgSiWEgKeF66KD66k=";
        };
    });
}
