# git-refresh initialization hook
#
# You can use the following variables in this file:
# * $package       package name
# * $path          package path
# * $dependencies  package dependencies

# Timeout in seconds before allowing another git pull (default: 15 minutes)
set -q GIT_REFRESH_TIMEOUT; or set -g GIT_REFRESH_TIMEOUT 900

function git-refresh --on-variable PWD \
    --description "git pull automatically wherever inside a git repository"
    test -d .git; or return

    set --local fetch_head .git/FETCH_HEAD
    if test -f $fetch_head
        set --local age (math (date +%s) - (stat -c %Y $fetch_head 2>/dev/null; or stat -f %m $fetch_head))
        if test $age -lt $GIT_REFRESH_TIMEOUT
            echo -e "\e[1m(git-refresh) - Cooldown: "(math $GIT_REFRESH_TIMEOUT - $age)"s remaining\e[0m"
            return
        end
    end

    echo -e "\e[1m(git-refresh) - GIT repo detected\e[0m"
    git pull --all --verbose
end
