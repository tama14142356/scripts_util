#!/bin/bash

on_tmux() {
    tmux_name="$1"
    cwd_path=${2:-"$(pwd)"}
    is_on_code_tmux=$(tmux ls 2> /dev/null | grep "$tmux_name")
    if [ -n "$is_on_code_tmux" ];then
        tmux a -t "$tmux_name"
    else
        cd "$cwd_path"
        tmux new -s "$tmux_name"
    fi
}

pycache_clean(){
    set -x
    tar_dir=${1:-"$(pwd)"}
    pushd "$tar_dir"
    pycache_dirs=$(find "$tar_dir" -type d -name "__pycache__")
    for d in ${pycache_dirs};
    do
        rm -rf "$d"
    done
    popd
    set +x
}

# wait detectron
wait_detecron() {
    set +x
    set -x
    # model_rel="$1"
    model_rel_path="$1"
    epoch="$2"
    pixpro_root=${3:-"$HOME/ssl_pj/pixpro_pj/PixPro"}
    scirpt_name=${4:-"jobs/cityscapes/train_nofinetune_num5.sh"}
    job_state_name=${5:-"pjstat"}
    # if [ -n "$epoch" ];then
    #     convert_d2="convert_d2_models/ckpt_epoch_$epoch"
    #     model_rel_path="$model_rel/$convert_d2"
    # else
    #     model_rel_path="$model_rel"
    # fi
    model_path="$pixpro_root/output/$model_rel_path.pkl"
    set +x
    while [ ! -e "$model_path" ]
    do
      sleep 1
    done
    set -x
    detectron2_root="$HOME/ssl_pj/detectron2/projects/DeepLab"
    pushd "$detectron2_root"
        set +x
        job_num=$("$job_state_name" | wc -l)
        set -x
        job_num=$(($job_num-1))
        set +x
        while [ $job_num -ge 289 ]
        do
            job_num=$("$job_state_name" | wc -l)
            job_num=$(($job_num-1))
            sleep 5
        done
        echo "$job_num"
        set -x
        bash "$scirpt_name" "$model_rel_path" "$pixpro_root"
    popd
    set +x
}

wait_detecron_finetune() {
    set +x
    set -x
    model_rel_path="$1"
    pixpro_root=${2:-"$HOME/ssl_pj/pixpro_pj/PixPro"}
    scirpt_name=${3:-"jobs/cityscapes/train_finetune_num5.sh"}
    wait_detecron "$model_rel_path" "" "$pixpro_root" "$scirpt_name"
    set +x
}


wait_detecron_conv_d2() {
    set +x
    set -x
    model_rel="$1"
    epoch="$2"
    pixpro_root=${3:-"$HOME/ssl_pj/pixpro_pj/PixPro"}
    scirpt_name=${4:-"jobs/cityscapes/train_nofinetune_num5.sh"}
    base_name="ckpt_epoch_$epoch"
    convert_d2="convert_d2_models"
    convert_d2_script="$pixpro_root/transfer/detection/convert_pretrain_to_d2.py"
    model_path="$pixpro_root/output/$model_rel/$base_name.pth"
    conver_d2_path="$pixpro_root/output/$model_rel/$convert_d2/$base_name.pkl"
    if [ ! -e "$conver_d2_path" ];then
        set +x
        while [ ! -e "$model_path" ]
        do
          sleep 1
        done
        set -x
        pushd "$pixpro_root"
        mkdir -p "output/$model_rel/$convert_d2"
        python "$convert_d2_script" "$model_path" "$conver_d2_path"
        popd
    fi
    wait_detecron "$model_rel/$convert_d2/$base_name" "" "$pixpro_root" "$scirpt_name"
    set +x
}

wait_detecrons_conv_d2() {
    set +x
    set -x
    model_rel="$1"
    s_epoch="$2"
    end_epoch="$3"
    exclude_epoch="$4"
    pixpro_root=${5:-"$HOME/ssl_pj/pixpro_pj/PixPro"}
    scirpt_name=${6:-"jobs/cityscapes/train_nofinetune_num5.sh"}
    is_exist=""
    model_rel_path="$model_rel"
    for ((i=$s_epoch; i<=$end_epoch; i++))
    do
        for e in ${exclude_epoch};
        do
            if [ "$e" == "$i" ];then
                is_exist="is_exist"
                break
            fi
        done
        if [ -n "$is_exist" ];then
            is_exist=""
            continue
        fi
        wait_detecron_conv_d2 "$model_rel" "$i" "$pixpro_root" "$scirpt_name"
        sleep 5
    done
    set +x
}

wait_detecrons() {
    set -x
    model_rel_root="$1"
    num=${2:-5}
    epoch=${3:-10}
    scirpt_name=${4:-"jobs/cityscapes/train_nofinetune_num5.sh"}
    model_root="$HOME/ssl_pj/pixpro_pj/PixPro"
    convert_d2="convert_d2_models/ckpt_epoch_$epoch"
    model_paths=$(find "$model_root/output/$model_rel_root" -maxdepth 1 -mindepth 1 -type d | sort | tail -"$num")
    model_rels=$(echo "$model_paths" | xargs -I{} basename {})
    for model_rel in ${model_rels};
    do
        wait_detecron "$model_rel_root/$model_rel/$convert_d2" "" "$model_root" "$scirpt_name"
        set -x
    done
    set +x
}
