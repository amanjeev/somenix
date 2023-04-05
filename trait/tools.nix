{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    broot  # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands https://github.com/Canop/broot
    cargo
    cargo-cross
    cargo-edit
    cargo-flamegraph
    cargo-asm
    cargo-expand
    cargo-outdated
    clang
    direnv
    du-dust  # du replacement in rust https://github.com/bootandy/dust
    exa  # ls replacement in rust https://github.com/ogham/exa
    fd  # find replacement in rust https://github.com/sharkdp/fd
    fish
    fzf # general-purpose cli fuzzy finder
    gcc
    gdb
    gitFull
    gnum4
    gnumake
    gnupg
    graphviz
    haskellPackages.digest
    jid  # interactive wrapper for jq
    jq
    oh-my-zsh
    openssl
    pandoc
    pkg-config
    procs  # ps replacement in rust https://github.com/dalance/procs
    ripgrep
    ripgrep-all
    rust-analyzer
    rnix-lsp
    rustup
    sd  # sed replacement in rust https://github.com/chmln/sd
    skim
    smartmontools
    tealdeer  # is a very fast implementation of tldr, a command-line program for displaying simplified, example based and community-driven man pages
    topgrade
  ];
}

