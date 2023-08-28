_mypyenv_win()
{
    local cur prev cword cmds
    _get_comp_words_by_ref -n : cur prev cword
    cmds="versions venv virtualenv activate_adjust delete"

    cur_cmd=""
    if [ $cword -gt 1 ]; then
        cmds=""
    fi

    if [ "$prev" = "venv" ] || [ "$prev" = "virtualenv" ]; then
          if type "py" > /dev/null 2>&1
          then
            py_ver_list="$(py --list 2> /dev/null | grep "\-" | sed -e 's/-//1' | sed -e 's/ //1')"
            cmds="$py_ver_list"
          fi
    elif [ "$prev" = "activate_adjust" ]; then
        venv_root="$HOME/Documents/python_venvs"
        venvs=$(find "$venv_root" -mindepth 1 -maxdepth 1 -type d | sed 's!^.*/!!')
        cmds="$venvs"
    elif [ "$prev" = "delete" ]; then
        venv_root="$HOME/Documents/python_venvs"
        venvs=$(find "$venv_root" -mindepth 1 -maxdepth 1 -type d | sed 's!^.*/!!')
        cmds="$venvs"
    fi
    COMPREPLY=( $(compgen -W "${cmds}" -- "${cur}") )
}

cmd_name=$(grep "pyenv_func" -rl "$HOME/bin" | head -1)
if [ -z "$cmd_name" ]; then
    cmd_name=$(find "$HOME/bin" -type l | xargs grep "pyenv_func" -rl | head -1)
fi
echo "$cmd_name  !!"
if [ -n "$cmd_name" ]; then
    cmd_name="$(basename "$cmd_name")"
    echo "$cmd_name"
    complete -F _mypyenv_win "$cmd_name"
fi
# complete -F _mypyenv_win "mypyev_win"
