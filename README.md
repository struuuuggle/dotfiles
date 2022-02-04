# dotfiles

## installation
```
$ ./install.sh
```

## システム環境設定にて

- 一般
デフォルトのWebブラウザ: Google Chrome

- 言語と地域
週の始まりの曜日 > 月曜日

- 通知
Xcodeとシステム環境設定以外切る

- ディスプレイ
  - 解像度 > 変更 > スペースを拡大
  - Night Shift > スケジュール(カスタム/開始5:00/終了4:59)

- キーボード
  - 入力ソース > "\"キーで入力する文字: `\`
  - 音声入力 > ショートカット: オフ
  - ショートカット
      - LaunchpadとDock: 全て無効化
      - 入力ソース: 全て無効化
      - Spotlight: 全て無効化
      - アクセシビリティ: 全て無効化
      - アプリケーション > ヘルプメニューを表示: `shift + cmd + /`
      cmd + H, cmd + Mは別のショートカットに割り当てることで、無効化

- トラックパッド
基本的にすべてにチェックを入れる。
Mission ControlとアプリケーションExposeはチェックを入れない。
軌跡の速さを最速にする。

- マウス
副ボタンのクリックを「左側をクリック」に設定
軌跡の速さを最速にする。

- ユーザとログイン項目
常駐系アプリを追加しておく。

- アクセシビリティ
トラップオプション > ドラッグを有効にする > 3本指のドラッグ
ポインタコントロール > マウスとトラックパッド > マウスオプション > スクロールの速さ: 最速に設定
ディスプレイ > カーソル > カーソルのサイズ: 1.5メモリ分大きくする

### 設定ファイルをインポートするアプリケーション
- Alfred

- iTerm2

起動後、環境設定 > General > Preferences > "Load preferences from a custom folder or URL"にチェックを入れる。
`~/dotfiles/Library/Preferences/`を選択。

- karabiner-elements

- Rectangle

- Vimium
Options > Backup and Restore > Retore
`~/dotfiles/.config/vimium/vimium-options.json`をアップロード

## TODO
- [ ] GUIでポチポチする系の設定をdefaultコマンド経由で行う
- [ ] install.shとmap.shの処理を関数に切り分ける
