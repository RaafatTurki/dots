function venv_switch
    set op $argv[1]

    if test $op = "on"
        source ./bin/activate.fish
    else if test $op = "off"
        if test -n "$_OLD_VIRTUAL_PATH"
            set -gx PATH $_OLD_VIRTUAL_PATH
            set -e _OLD_VIRTUAL_PATH
        end
        if test -n "$_OLD_VIRTUAL_PYTHONHOME"
            set -gx PYTHONHOME $_OLD_VIRTUAL_PYTHONHOME
            set -e _OLD_VIRTUAL_PYTHONHOME
        end
        if test -n "$_OLD_FISH_PROMPT_OVERRIDE"
            functions -e fish_prompt
            set -e _OLD_FISH_PROMPT_OVERRIDE
            functions -c _old_fish_prompt fish_prompt
            functions -e _old_fish_prompt
        end
        set -e VIRTUAL_ENV
    end
end
