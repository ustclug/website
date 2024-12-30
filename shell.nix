{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    buildInputs = [
        ruby_3_2
        nodejs-18_x
        curl
        bundler
    ];

    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LD_LIBRARY_PATH = "${lib.makeLibraryPath [ curl ]}";
}
