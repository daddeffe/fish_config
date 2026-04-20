function duh --description "Disk usage utility"
    if test (count $argv) -eq 0
        #echo "duh: missing operand" >&2
        #return 1
        set fold '.'
    else
        set fold $argv
    end


    du -hd1 $fold | sort -h
end
