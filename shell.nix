{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
	buildInputs = [
		ruby_2_7
        nodejs-18_x
	];

	nativeBuildInputs = [
		bundler
	];

    LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}