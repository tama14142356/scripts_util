# scripts_util
楽するためのコマンドスクリプト集

## search_old_date.sh
現在いるフォルダ内でのファイルの中で一番古い更新日のファイルを出力し、
フォルダの中で一番古い更新日のファイルを出力するもの

## rename.sh
現在いるフォルダ内で使用可能  
そのファルダ内でパターンに一致するファイル名を一括変換できる  
使い方は以下  
```
$ cd ~/rename_dir
~/rename_dir $ ls
rename.sh testkkk_tmp1.txt testkkk_tmp2.txt testkkk_tmp3.txt
~/rename_dir $ bash rename.sh test val testkkk*
~/rename_dir $ ls
rename.sh valkkk_tmp1.txt valkkk_tmp2.txt valkkk_tmp3.txt
```

## rename_extend.sh
現在いるフォルダ内で使用可能  
そのファルダ内でパターンに一致するファイル名の前半と後半を入れ替える  
使い方は以下  
```
$ cd ~/rename_dir
~/rename_dir $ ls
rename_extend.sh testkkk_tmp1.txt testkkk_tmp2.txt testkkk_tmp3.txt
~/rename_dir $ bash rename_extend.sh testkkk
~/rename_dir $ ls
rename_extend.sh tmp1_testkkk.txt tmp2_testkkk.txt tmp3_testkkk.txt
```


# git用スクリプトディレクトリ(for_git)
gitでファイルの更新日管理したいという変なことをしたい場合に使うスクリプト


# video(ffmpeg)用スクリプトディレクトリ(for_video)
ffmpegを使った処理をしたいときに使うスクリプトをまとめたもの
