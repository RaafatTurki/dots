function pn --description "Open the current repo's note (creates it if missing)"
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$root"
        echo "pn: not inside a git repo"
        return 1
    end

    set -l note (project-note --path $root | tail -1)
    if test -z "$note"
        echo "pn: couldn't find or create a note for $root"
        return 1
    end

    set -l editor $EDITOR
    test -n "$editor"; or set editor nvim
    $editor $note
end
