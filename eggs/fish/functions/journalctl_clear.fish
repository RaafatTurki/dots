function journalctl_clear
  sudo journalctl --rotate
  sudo journalctl --vacuum-time=1s

  # sudo systemctl restart systemd-journald
end
