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
	#zellij
	tmux
end
