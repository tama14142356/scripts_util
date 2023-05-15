#!/bin/bash
script_dir=$(
    cd "$(dirname "$0")" || exit 1
    pwd
)
month="$1"
add_one=${2:-"y"}
year=${3:-"2022"}

syokuban=${4:-"12345678"}
kanji_name=${5:-"田中太郎"}
syorui_name=${6:-"報告書"}

# final_filename_basename="$syokuban"_""$kanji_name"""$year"".""$month""$syorui_name"
final_filename_basename="$syokuban""_""$kanji_name""_""$year"".""$month""$syorui_name"
final_filename="$final_filename_basename.pdf"

output_name="output.pdf"
ja_file_begin_name="$final_filename_basename""_1.pdf"
ja_file_end_name="$final_filename_basename""_2.pdf"
en_file_begin_name="tmp1.pdf"
en_file_end_name="tmp2.pdf"
if [ "$add_one" == "y" ];then
    ja_file_add_name="$final_filename_basename""_3.pdf"
    en_file_add_name="tmp3.pdf"
fi

tar_dir="$(dirname "$script_dir")"
work_dir="temp"

output_dir="$tar_dir/after_unite"
mkdir -p "$output_dir"

pushd "$tar_dir"
if [ -d "$work_dir" ]; then
    rm -rf "$work_dir"
fi
if [ -f "$final_filename" ]; then
    rm "$final_filename"
fi
mkdir "$work_dir"

pushd "$work_dir"
if [ -f "$output_name" ]; then
    rm "$output_name"
fi

cp "$tar_dir/$ja_file_begin_name" .
cp "$tar_dir/$ja_file_end_name" .
mv "$ja_file_begin_name" "$en_file_begin_name"
mv "$ja_file_end_name" "$en_file_end_name"

if [ "$add_one" == "y" ];then
    cp "$tar_dir/$ja_file_add_name" .
    mv "$ja_file_add_name" "$en_file_add_name"
    pdfunite "$en_file_begin_name" "$en_file_end_name" "$en_file_add_name" "$output_name"
else
    pdfunite "$en_file_begin_name" "$en_file_end_name" "$output_name"
fi

mv "$output_name" "$output_dir/$final_filename"
popd
rm -rf "$work_dir"
popd
