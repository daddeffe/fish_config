set -g fish_greeting "Hi Dadd"

# Set editor
set -gx EDITOR nvim
set -gx KUBE_EDITOR nvim
set -g TERM xterm-256color

# For enable nvim server, first instance become the listener
#set -gx NVIM_LISTEN_ADDRESS /tmp/nvim-server.sock

# Set correct TERM and TERMINAL for kitty

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings

    # Disable flow control (Ctrl+S/Ctrl+Q) to prevent terminal freeze
    # stty -ixon

    # Handle spurious cursor position reports that might appear in prompt
    # This happens when background jobs query the terminal

    # Ctrl-o   	    Find a file.
    # Ctrl-r 	      Search through command history.
    # Alt-c 	      cd into sub-directories (recursively searched).
    # Alt-Shift-c 	cd into sub-directories, including hidden ones.
    # Alt-o        	Open a file/dir using default editor ($EDITOR)
    # Alt-Shift-o 	Open a file/dir using xdg-open or open command

    set -g fish_sequence_key_delay_ms 200
    bind -M insert -m default j,k cancel repaint-mode

    # \c Ctrl, \e Alt
    bind -M insert \cy 'y; commandline -f repaint'
    bind -M insert \cv 'nvim; commandline -f repaint'
    bind -M insert \cz 'zellij; commandline -f repaint'
    bind -M insert \cx 'set -l dir (zoxide query -l | fzf --height 40% --reverse); and cd $dir; commandline -f repaint'
    bind -M insert \cu forward-char
    set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

    set -U autovenv_enable yes
    set -U autovenv_announce yes
    set -U autovenv_dir .venv

    git-refresh
    # Check max tmux window in the Home session and open the Home session in a new tmux window
    # Find max window number in the Home session
    #if test -z "$TMUX";
    #  # set name "$(date '+%Y%m%d_%H%M%S')"
    #  # exec flock -w 1 -F -n "/tmp/zellij-$name" zellij -s "$name"
    #      exec tmux
    #end
    # if test -z "$ZELLIJ";
    #   # set name "$(date '+%Y%m%d_%H%M%S')"
    #   # exec flock -w 1 -F -n "/tmp/zellij-$name" zellij -s "$name"
    #   exec zellij
    # end

end

fish_add_path /home/df/.opencode/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/df/.lmstudio/bin
# End of LM Studio CLI section

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Go
fish_add_path $HOME/go/bin

# Cargo (Rust)
fish_add_path $HOME/.cargo/bin

alias claude 'claude --allow-dangerously-skip-permissions'
