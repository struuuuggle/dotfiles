# dotfiles

## installation
```
make install
```

## システム環境設定にて

GUIでの操作が必要な設定のみ記載。`defaults` コマンドで自動化できるものは `make defaults` に移動済み。

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

- アクセシビリティ
ポインタコントロール > マウスとトラックパッド > マウスオプション > スクロールの速さ: 最速に設定
ディスプレイ > カーソル > カーソルのサイズ: 1.5メモリ分大きくする

### 設定ファイルをインポートするアプリケーション
- karabiner-elements

- Rectangle

- Vimium
Options > Backup and Restore > Retore
`~/dotfiles/.config/vimium/vimium-options.json`をアップロード
