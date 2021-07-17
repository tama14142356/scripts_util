# video(ffmpeg)用スクリプトディレクトリ(for_video)
ffmpegを使った処理をしたいときに使うスクリプトをまとめたもの

## cat_video.sh
mylist.txt内に書かれたパスにある動画をその順番に結合する。  
ただし、結合する動画は全て同じ形式である必要があります。

### 使い方
1. mylist.txt と cat_video.shを同一ディレクトリ内に配置
1. mylist.txtの中身を結合したい動画のパスに書き換える（~などは使えません。絶対パスを入力してください）
1. 以下を実行

    ```
    $ ls
    mylist.txt cat_video.sh
    $ bash cat_video.sh
    $ ls
    mylist.txt cat_video.sh output.mp4
    ```

1. `output.mp4`が結合された動画なので、これが作成されていれば完了
