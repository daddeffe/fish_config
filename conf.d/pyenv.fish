while set pyenv_index (contains -i -- "/home/df/.pyenv/shims" $PATH)
set -eg PATH[$pyenv_index]; end; set -e pyenv_index
set -gx PATH '/home/df/.pyenv/shims' $PATH
set -gx PYENV_SHELL fish
command pyenv rehash
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case "*"
    command pyenv "$command" $argv
  end
end
