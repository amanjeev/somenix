{ vscode-with-extensions, vscode-extensions, vscode-utils }:

vscode-with-extensions.override {
  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
    ms-vscode-remote.remote-ssh
    github.vscode-pull-request-github
    editorconfig.editorconfig
    rust-lang.rust-analyzer
    jnoortheen.nix-ide
    bungcip.better-toml
    eamodio.gitlens
    
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "base16-themes";
      publisher = "AndrsDC";
      version = "1.4.5";
      sha256 = "molx+cRKSB6os7pDr0U1v/Qbaklps+OvBkZCkSWEvWM=";
    }
    {
      name = "Bookmarks";
      publisher = "alefragnani";
      version = "13.3.1";
      sha256 = "CZSFprI8HMQvc8P9ZH+m0j9J6kqmSJM1/Ik24ghif2A=";
    }
  ];
}
