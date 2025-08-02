function title
  set_color green
  echo -e "$argv[1]\n"
  set_color normal
  set current_stage (math $current_stage + 1)
end

function error
  set_color red
  echo -e "$argv[1]\n"
  set_color normal
  set current_stage (math $current_stage + 1)
end


function javav
  set VERSION $argv[1]

  switch $VERSION
    case ''
      archlinux-java status
    case 8
      sudo archlinux-java set java-8-openjdk/jre
      title 'Java version 8 set'
    case 11
      sudo archlinux-java set java-11-openjdk
      title 'Java version 11 set'
    case 17
      sudo archlinux-java set java-17-openjdk
      title 'Java version 17 set'
    case 19
      sudo archlinux-java set java-19-openjdk
      title 'Java version 19 set'
    case 21
      sudo archlinux-java set java-21-openjdk
      title 'Java version 21 set'
    case 24
      sudo archlinux-java set java-24-openjdk
      title 'Java version 21 set'
    case '*'
      error 'Java version unsupported'
  end



  # if test $VERSION -e 8
  #   echo "asdad"
  # end

  # if test (command -v paru)
  #   title "Updating Unofficial Packages (paru)"
  #   paru --gendb  # make paru aware of all -git packages upstream updates if not installed by it
  #   paru -Su --disable-download-timeout
  # else if test (command -v aura)
  #   title "Updating Unofficial Packages (aura)"
  #   sudo aura -Akuax
  # else if test (command -v yay)
  #   title "Updating Unofficial Packages (yay)"
  #   yay -Su --disable-download-timeout
  # end
end

