starship init fish | source

# Fix some utf-8 errors
set -x LC_ALL en_GB.utf8

# Better nix-shell support!
any-nix-shell fish --info-right | source
 
# tuuuuuuuurbofish!
set fish_greeting 'Welcome to the '(set_color FA1100)'::<>' (set_color normal)'...'

# python virtualenvwrapper
set -g -x WORKON_HOME ~/virtualenvs
