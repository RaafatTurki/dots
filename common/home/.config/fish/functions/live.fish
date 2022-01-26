function live
    set cmd $argv[1]
    set interval 0.1

    watch -n $interval $cmd
end
