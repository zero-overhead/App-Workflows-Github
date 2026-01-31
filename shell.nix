{ pkgs ? import <nixpkgs> {} }:
 pkgs.mkShell {
    packages = [
      pkgs.rakudo
      pkgs.zef
      
      pkgs.git
      pkgs.curl
      
      pkgs.readline
      pkgs.cacert
      pkgs.zlib
      pkgs.openssl        
      pkgs.zeromq
    ];

    # Avoid this error: Cannot locate native library 'libreadline.so.7': libreadline.so.7: cannot open shared object file: No such file or directory
    # or: Cannot locate native library 'libssl.so': libssl.so: cannot open shared object file: No such file or directory
    # etc.
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ 
      pkgs.readline
      pkgs.cacert
      pkgs.zlib
      pkgs.openssl
      pkgs.zeromq
    ];

    # Set zef environment variables
    ZEF_FETCH_DEGREE = 4;
    ZEF_TEST_DEGREE = 4;

    shellHook = ''
      echo including $HOME/.raku/bin in PATH
      export PATH="$HOME/.raku/bin:$PATH"

      echo installing dependenciees of current module
      zef install --debug --deps-only .

      echo installing current module
      zef install --debug .

      echo installing all Raku modules listed in jupyter-chatbook-modules.txt from https://raku.land using zef
      cat raku-modules.txt | raku -e 'for $*IN.lines.grep(/^^\w/) { say shell "zef install --serial --debug \"$_\"" }'      
    '';    
}