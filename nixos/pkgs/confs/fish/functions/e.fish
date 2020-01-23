# Spawn an emacs daemon for a project directory
function e --description='Setup emacs server and open emacsclient'
    set session (basename (pwd))
    #set session 'emacs-daemon'
    
    ps x | grep emacs | grep $session > /dev/null

    if test $status != 0
        emacs --daemon=$session
    end
    
    emacsclient -c -s $session --eval '(fzf)' ^ /dev/null > /dev/null &
end
