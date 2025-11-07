set -g fish_greeting "Hi Dadd"

# set nvim editor
set -g EDITOR nvim
set -g KUBE_EDITOR nvim
set -g TERM xterm-256color

if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_vi_key_bindings


  # Ctrl-o   	    Find a file.
  # Ctrl-r 	      Search through command history.
  # Alt-c 	      cd into sub-directories (recursively searched).
  # Alt-Shift-c 	cd into sub-directories, including hidden ones.
  # Alt-o        	Open a file/dir using default editor ($EDITOR)
  # Alt-Shift-o 	Open a file/dir using xdg-open or open command

  set -g fish_sequence_key_delay_ms 200
  bind -M insert -m default j,k cancel repaint-mode
  bind -M insert \cn \\t
  set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

  alias claude="~/.claude/local/claude"
  # Check max tmux window in the Home session and open the Home session in a new tmux window
  # Find max window number in the Home session
  set TERM 'xterm-kitty'
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




