function nrepl
    if test $argv[1]
        nix repl $argv
    else
        nix repl '<nixpkgs>'
    end
end
