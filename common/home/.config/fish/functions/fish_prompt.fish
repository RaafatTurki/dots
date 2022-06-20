# this is a modified version of the sashimi fish prompt https://github.com/isacikgoz/sashimi

function fish_prompt
  # must be on too to store the last command's exit code
  set -l last_status $status

  set cyan (set_color cyan)
  set yellow (set_color yellow)
  set green (set_color green)
  set red (set_color red)
  set blue (set_color blue)
  set normal (set_color normal)
  set whitespace ' '

  # cwd
  set -l pwd (prompt_pwd)
  set -l curr_path "$blue$pwd "

  # ssh info
  if [ (_is_ssh) ]
    set -l ssh_hostname (echo $hostname)
    set ssh_info (printf "%sSSH -> %s%s: " $red $yellow $ssh_hostname)
  end

  # git branch
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set -l git_branch "$red$git_branch"

    if [ (_is_git_dirty) ]
      set git_dirty "$normal ●"
    end

    set git_info "$git_branch$git_dirty "
  end

  # exit codes
  if test $last_status != 0
    set exit_code "$red$last_status "
  end

  echo -n -s $ssh_info $curr_path $git_info $exit_code
end


# returns git branch name if pwd is git dir, nothing otherwise
function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

# returns something if pwd is dirty git, nothing otherwise
function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

# returns $SSH_TTY if SSH, false otherwise
function _is_ssh
  echo $SSH_TTY
end
