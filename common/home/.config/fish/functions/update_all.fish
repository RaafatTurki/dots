set current_stage 1 
set total_stages 6 

function title
    set_color green
    echo -e "\n - [$current_stage/$total_stages] $argv[1]"
    set_color normal
    set current_stage (math $current_stage + 1)
end

function update_all
    # title " - Fetching New Mirror List"
    # fetch new mirrors

    title "Refreshing Package Databases"
    sudo pacman -Syy
    
    title "Updating Arch Keyring"
    sudo pacman -S archlinux-keyring --needed

    title "Updating Official Packages"
    sudo pacman -Su --disable-download-timeout

    if test (command -v paru)
        title "Updating AUR Packages (paru)"
        paru -Su --disable-download-timeout
    end

    if test (command -v yay)
        title "Updating AUR Packages (yay)"
        yay -Su --disable-download-timeout
    else if test (command -v pkgfile)
        title "Updating Repo Files Lists"
        sudo pkgfile -u
    end

    title "Updating Fish Completions"
    fish_update_completions
end
