{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    broot  # An interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands https://github.com/Canop/broot
    # not installing cargo here in tools because it needs to come from rustup instead
    # if you install cargo like this you will hate yourself because then you will not
    # be able to run commands with toolchain specifiers like 
    # cargo +nightly run
    # https://stackoverflow.com/questions/63574841/cargo-nightly-error-no-such-subcommand
    # 
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
    libclang
    llvm
    mtr
    mtr-gui
    oh-my-zsh
    openssl
    pandoc
    procs  # ps replacement in rust https://github.com/dalance/procs
    python3Full
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
    unixtools.ping
    nvi
    wally-cli
  ];
}