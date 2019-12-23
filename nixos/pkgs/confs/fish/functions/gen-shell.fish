function gen-shell
    if not test $argv[1]
        echo "Usage: gen-shell <name>"
        return 1
    end
    
    if test -e default.nix
        echo "Refusing to override existing `default.nix`!"
        return 1
    end

    set name $argv[1]
    echo "with import <nixpkgs> {};

stdenv.mkDerivation {
  name = \"$name\";
  buildInputs = with pkgs; [
    # Hier könnte Ihre Werbung stehen
  ];
}" > default.nix
    bat default.nix
end
