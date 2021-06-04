#!/bin/bash
script_dir=$(
    cd "$(dirname "$0")" || exit 1
    pwd
)
pushd "$script_dir"
if [ $# -lt 1 ]
then
	echo "交換したい前半部分の名前を入力してください"
	exit 1
fi

# [:punct:] : ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
# [:blank:] : スペース タブ
delete_moji="[[:punct:][:blank:]]"
first_half_name="$1"

# 指定した文字で始まるファイルリストの取得
files=$(find "$script_dir" -name "$first_half_name*" | xargs basename -a)
for file in ${files}
do
    basefile_name=${file%.*} # 拡張子抜きのファイル名
    suffix=""
    if [ "$file" != "$basefile_name" ]; then
        # 拡張子が存在したら"."も追加
        suffix=${file##*.} # 拡張子の名前
        suffix=".""$suffix"
    fi
    second_half=${basefile_name#$first_half_name*} # 指定した文字列以降のファイル名(拡張子なし)
    if [ -n "$second_half" ]; then
        # 後半部分が存在すれば
        top_moji=${second_half:0:1} # 先頭の文字列
        if [[ "$top_moji" =~ $delete_moji ]]; then
            # 先頭の文字列がdelete_mojiのどれかに当てはまるとき,削除
            second_half=${second_half/$delete_moji/}
        else
            # 先頭の文字列がdelete_mojiのどれかに当てはまらないとき,ひっくり返した後のつなぎ目を_にする
            top_moji="_"
        fi
        second_half="$second_half""$top_moji"
    fi
    after_file="$second_half""$first_half_name""$suffix"
    mv "$file" "$after_file"
done
popd
