function zjs -d "Avvia zellij in una nuova finestra TERM"
    if test (count $argv) -eq 0
        $TERM -e zellij &
    else
        $TERM -e zellij attach -c $argv[1] &
    end
    disown
end
