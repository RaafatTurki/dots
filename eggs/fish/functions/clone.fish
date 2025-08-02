function clone --description 'git clone into ~/code/<owner>/<repo> and create its project note'
    argparse 'o/owner=' -- $argv; or return
    set -l url $argv[1]
    if test -z "$url"
        echo 'usage: clone <git-url> [-o owner]'
        echo '  owner defaults to the URL owner; your own repos go to "me"'
        return 1
    end

    set -l repo (string replace -r '\.git$' '' -- (path basename $url))
    set -l owner $_flag_owner
    if test -z "$owner"
        set owner (string match -rg '[:/]([^/:]+)/[^/]+/?$' -- $url)
        test (string lower -- "$owner") = raafatturki; and set owner me
    end
    set owner (string lower -- $owner)

    set -l dest ~/code/$owner/$repo
    if test -e $dest
        echo "already here: $dest"
        cd $dest
        return
    end

    mkdir -p (path dirname $dest); and git clone $url $dest; or return
    project-note $dest
    cd $dest
end
