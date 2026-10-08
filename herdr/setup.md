# herdr セットアップメモ

AIコーディングエージェント向けのターミナル多重化ツール。動作確認バージョンは 0.9.3。

## 導入手順

1. `brew install herdr`（homebrew-core の formula。tap の追加は不要）
2. `herdr integration status` で Claude Code 連携が `current` になっていることを確認する。連携の実体は `~/.claude/hooks/herdr-agent-state.sh`（herdr が管理し、更新で上書きされる）。
3. 下記の設定を `~/.config/herdr/config.toml` に追記し、`herdr config check` で検証して `herdr server reload-config` で反映する。

## サイドバーの表示設定

既定では、エージェント行が `workspace` / `tab` / `agent` で構成される。同じフォルダの同じ tab に複数の Claude Code を並べると、すべて同じ表示になり見分けがつかない。端末タイトル（Claude Code の `/rename` で付けた名前）を表示すると区別できる。

```toml
[ui.sidebar.agents]
rows = [
  ["state_icon", "workspace"],
  ["terminal_title_stripped"],
]
```

- `herdr agent rename` による手動の付け直しは不要になる（`agent` トークンの表示名は `/rename` に追従しないため）。
- `/rename` していないセッションは、自動命名のタイトルが出る。起動後に `/rename` で名前を付ける。
- キー名と許容値は herdr 0.9.3 の Configuration ページに基づく。更新で変わる可能性がある。

## 使い方の方針

- 用途は並行セッションの状態確認（承認待ち・完了の見落とし防止）。操作は分割・移動・デタッチ・ヘルプの4キーに絞る（プリフィックスは Ctrl+B）。
- 複数のセッションが同じファイル群を同一の作業ツリーで扱う運用では、git worktree による分割は使わない。
- `herdr agent prompt` / `wait` による複数エージェントの自動連携は、必要になるまで導入しない。

## 注意

- Claude Code の Hook がグローバル（`~/.claude/`）に入る。
- 設定ファイルの変更前は `config.toml` をバックアップしておく。
