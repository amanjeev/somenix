starship init fish | source

# gnome-keyring insists on setting this to itself, even if ssh support is disabled
set -x SSH_AUTH_SOCK "/run/user/1000/gnupg/S.gpg-agent.ssh"

# Fix some utf-8 errors
set -x LC_ALL en_GB.utf8

# Better nix-shell support!
any-nix-shell fish --info-right | source
 
# tuuuuuuuurbofish!
set fish_greeting 'Welcome to the '(set_color 323AA8)'::<>' (set_color normal)'...'

# python virtualenvwrapper
set -g -x WORKON_HOME ~/virtualenvs
