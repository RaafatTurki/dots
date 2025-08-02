function sqlive
    set db $argv[1]
    set table $argv[2]
    set interval $argv[3]

    watch -t -w -c -n $interval "litecli -D $db -e 'SELECT * FROM $table'"
end
