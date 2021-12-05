function venv_auto
    if set -q python_auto_venv
        if test -e "./bin/activate.fish"
            and test -e "./pyvenv.cfg"
            venv_switch on
        else
            venv_switch off
        end
    end
end
