function search --description "Finding some code with sk(1) and rg(1)"
    set SELECTED (sk --ansi -c 'rg --color=always --line-number \"{}\"')
    echo (cat $SELECTED | sed 's/\(\:[0-9]*\).*/\1/' | tr ':' ' ')
end
