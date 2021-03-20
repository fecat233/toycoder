function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)
    set -l cwd $cyan(pwd | sed "s:^$HOME:~:")

    echo -n -s $cwd $normal

    if [ (_git_branch_name) ]
      set -l git_branch (_git_branch_name)

      if [ (_git_is_dirty) ]
        set git_info '{' $yellow $git_branch "±" $normal '}'
      else
        set git_info '{' $yellow $git_branch $normal '}'
      end
      echo -n -s ' ' $git_info $normal
    end

    set -l prompt_color $blue
    echo -e ''
    echo -e -n -s $prompt_color '$ ' $normal
end
