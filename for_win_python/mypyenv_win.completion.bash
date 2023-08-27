_mypyenv_win()
{
    local cur prev cword cmds prev_cmd
    _get_comp_words_by_ref -n : cur prev cword
    cmds="versions venv virtualenv activate_adjust delete"

    cur_cmd=""
    if [ $cword -gt 1 ]; then
        cur_cmd=${COMP_WORDS[1]}
        cmds=""
        # echo "in if $cur_cmd"
    fi

    # echo "COMP_CWORD: ${COMP_CWORD}"
    # echo "COMP_WORDS: ${COMP_WORDS[@]}"
    # echo "$cword"

    # if [ "$cur_cmd" = "versions" ];then
    # cmds=""
    if [ "$cur_cmd" = "venv" ] || [ "$cur_cmd" = "virtualenv" ]; then
        if [ $cword -eq 3 ]; then
            if type "py" > /dev/null 2>&1
            then
                py_ver_list="$(py --list 2> /dev/null | grep "\-" | sed -e 's/-//1' | sed -e 's/ //1')"
                cmds="$py_ver_list"
            fi
        fi
    elif [ "$cur_cmd" = "activate_adjust" ]; then
        if [ $cword -eq 2 ]; then
            venv_root="$HOME/Documents/python_venvs"
            venvs=$(find "$venv_root" -mindepth 1 -maxdepth 1 -type d | sed 's!^.*/!!')
            cmds="$venvs"
        fi
    elif [ "$cur_cmd" = "delete" ]; then
        if [ $cword -eq 2 ]; then
            venv_root="$HOME/Documents/python_venvs"
            venvs=$(find "$venv_root" -mindepth 1 -maxdepth 1 -type d | sed 's!^.*/!!')
            cmds="$venvs"
        fi
    fi
    COMPREPLY=( $(compgen -W "${cmds}" -- "${cur}") )
}

cmd_name=$(grep "pyenv_func" -rl "$HOME/bin" | head -1)
if [ -z "$cmd_name" ]; then
    cmd_name=$(find "$HOME/bin" -type l | xargs grep "pyenv_func" -rl | head -1)
fi
cmd_name="$(basename "$cmd_name")"
# echo "$cmd_name"
complete -F _mypyenv_win "$cmd_name"
