function p --description 'Fuzzy-jump to a repo under ~/code'
    set -l root ~/code
    set -l repos (find $root \( -name node_modules -o -name target -o -name .venv -o -name venv \) -prune \
        -o -name .git -prune -print 2>/dev/null | string replace -r '/\.git$' '' | string replace -- "$root/" '' | sort)
    test (count $repos) -gt 0; or begin
        echo "no repos under $root"
        return 1
    end

    set -l pick (printf '%s\n' $repos | fzf --query "$argv" --select-1 --exit-0 --scheme path \
        --preview "git -C $root/{} log --oneline --color=always -8 2>/dev/null; echo; ls $root/{}")
    test -n "$pick"; and cd $root/$pick
end
