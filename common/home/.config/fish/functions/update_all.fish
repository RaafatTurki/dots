set current_stage 1

function title
  set_color green
  echo -e "\n - STAGE $current_stage $argv[1]\n"
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
    paru --gendb  # make paru aware of all -git packages upstream updates if not installed by it
    paru -Su --disable-download-timeout
  else if test (command -v aura)
    title "Updating AUR Packages (aura)"
    sudo aura -Akuax
  else if test (command -v yay)
    title "Updating AUR Packages (yay)"
    yay -Su --disable-download-timeout
  end

  if test (command -v pkgfile)
    title "Updating Repo Files Lists"
    sudo pkgfile -u
  end

  title "Updating Fish Completions"
  fish_update_completions

  title "Rebuilding Font Cache Files"
  fc-cache -frv
end
