{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    buildInputs = [
        ruby_3_2
        nodejs_22
        curl
        bundler
    ];

    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LD_LIBRARY_PATH = "${lib.makeLibraryPath [ curl ]}";
}
