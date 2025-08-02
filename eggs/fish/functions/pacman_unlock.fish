function pacman_unlock

  set db_lock_file "/var/lib/pacman/db.lck"

  if test -e $db_lock_file
    sudo rm $db_lock_file

    # sudo fuser /var/lib/pacman/db.lck 2> /dev/null
    # sudo fuser /var/lib/pacman/db.lck

    # if test $status = 0
      # echo "a pacman instance is currently running"
      # sudo rm /var/lib/pacman/db.lck
      # else
    # end
  else
    echo "pacman db lock file doesn't exist, there's nothing to unlock"
  end

end

