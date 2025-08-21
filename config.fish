set -g fish_greeting "Hi Dadd"

# set nvim editor
set -g EDITOR nvim

if status is-interactive
	# Commands to run in interactive sessions can go here
	fish_vi_key_bindings


	set -g fish_sequence_key_delay_ms 200
	bind -M insert -m default j,k cancel repaint-mode
	bind -M insert \cn \\t

	fzf_configure_bindings --git_status=\cg --history=\cr --variables= --processes=
	# Check max tmux window in the Home session and open the Home session in a new tmux window
	# Find max window number in the Home session
	set tmux_max_windows_in_home (tmux list-windows -t Home | awk '{print $1}' | sed 's/[^0-9]*//g' | sort -n | tail -n 1)
	if test -z "$TMUX"
		if test -n "$SSH_CONNECTION"
			tmux new-session -A -s Home
		else
			tmux new-session -A -s Home
		end
	end
end
