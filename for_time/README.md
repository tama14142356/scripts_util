# for_time
時間計測に関連するスクリプト  

## time_bash.sh
時間計測のテンプレートファイル  
`# iroiro`の部分に測定したい処理を書けばその処理全体の時間が出力できる。

## change_humantime.sh
上記のようにして取得した秒数を人間が読みやすい表記に変更するスクリプト  
使い方と出力例  

```
$ bash change_humantime.sh 10
0 h 0 m 10 s
$ bash change_humantime.sh 81870
22 h 44 m 30 s
```
