function nxs
    if test $argv[1]
        nix run -f '<nixpkgs>' $argv
    else
        if test -e default.nix
            nix-shell
        else
            echo "No `default.nix`"
            return 1
        end
    end
end
