# for_process 
プロセス管理、容量管理等に関連する雑多な処理群

## get_size_dir.sh
1. 指定したディレクトリ配下3階層下までのなかでの容量を計算  
1. 表示されるのは、その中で容量が大きい順に10番目までを表示

## test_loop.sh
ただループを回すテストスクリプト  
現段階で10s毎に`qstat`コマンドを実行している
## update.sh
ubuntuにおけるtexとubuntuの更新コマンド

## python関連
### remove_pip_cache.sh
pip のcacheを削除するコマンド
### remove_pycache_dir.sh
pythonのコンパイルファイルを削除するコマンド

## プロセス管理
### 依存関係
実行するのに同一ディレクトリ内に必要なスクリプトを示す。
- port_forward.sh: なし
- pgrep_name.sh: なし（大元）
- kill_process_from_name.sh: pgrep_name.sh
- kill_port_forwarding_process.sh: kill_process_from_name.sh
- open_browser_all.sh: pgrep_name.sh
- watch_gpu.sh: port_forward.sh
- ps_aux_ssh.sh: なし

### port_forward.sh
ローカルのポート番号、リモートのポート番号、サーバ名を指定してポートフォワーディングする。

### pgrep_name.sh
指定された文字が入っているコマンド名またはプロセス名に対応する全てのpidを返す。

### kill_process_from_name.sh
指定された文字が入っているコマンド名またはプロセス名に対応するプロセス全てに対して`kill`コマンドを実行する。

### kill_port_forwarding_process.sh
ポートフォワーディングしているプロセス全てに対して`kill`コマンドを実行する。

### open_browser_all.sh
ポートフォワーディングしているプロセスで開いているポート全てに対応するブラウザを開く。

### watch_gpu.sh
ローカル、リモートどちらのポート番号も1080でポートフォワーディングするスクリプト

### ps_aux_ssh.sh
sshに関連するプロセスを表示
