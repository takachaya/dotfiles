# dotfiles

個人の開発環境設定ファイル。

## 構成

| パス | 内容 | symlink先 |
|---|---|---|
| `Brewfile` | Homebrew でインストール済みのパッケージ一覧（tap / formula / cask / mas / npm） | なし |
| `claude/CLAUDE.md` | Claude Code 個人設定 | `~/.claude/CLAUDE.md` |
| `claude/de-ai-writing.md` | 文章生成ハーネス（CLAUDE.md から `@import` 参照） | なし（symlink 不要） |
| `claude/statusline-command.sh` | ステータスライン表示スクリプト | `~/.claude/statusline-command.sh` |
| `claude/skills/adr-manager` | ADR（Architecture Decision Records）管理スキル | `~/.claude/skills/adr-manager` |
| `claude/skills/exec-summary` | Slack向けサマリー・報告文案スキル | `~/.claude/skills/exec-summary` |
| `claude/skills/grill-me` | grillingスキルの起動ショートカット | `~/.claude/skills/grill-me` |
| `claude/skills/grilling` | 計画・設計・提案を徹底的に質問して詰めるスキル | `~/.claude/skills/grilling` |
| `claude/skills/handoff` | セッション引き継ぎプロンプト生成スキル | `~/.claude/skills/handoff` |
| `claude/skills/tdd` | テスト駆動開発（Red-Green-Refactor）スキル | `~/.claude/skills/tdd` |
| `herdr/setup.md` | herdr（AIエージェント向けターミナル多重化ツール）の導入・設定メモ | なし |
| `git/ignore` | Git のグローバル除外設定 | `~/.config/git/ignore` |

## セットアップ

新しいマシンに移行する際は以下を実行：

```bash
# ghq の標準ルートに置く（ghq が未導入でも同じ場所になるよう git clone で指定）
DOT=~/ghq/github.com/takachaya/dotfiles
git clone https://github.com/takachaya/dotfiles.git $DOT

# Homebrew パッケージの復元（App Store アプリを含めるなら先に App Store へサインインしておく）
brew bundle --file=$DOT/Brewfile

# Claude Code 設定の symlink
mkdir -p ~/.claude/skills
ln -sf $DOT/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf $DOT/claude/statusline-command.sh ~/.claude/statusline-command.sh
for s in adr-manager exec-summary grill-me grilling handoff tdd; do
  ln -sfn $DOT/claude/skills/$s ~/.claude/skills/$s
done

# Git のグローバル除外設定の symlink
mkdir -p ~/.config/git
ln -sf $DOT/git/ignore ~/.config/git/ignore
```

※ `de-ai-writing.md` の `@import` は symlink 先の実体パス（`$DOT/claude/`）基準で解決されるため、個別の symlink は不要。

※ ステータスラインを表示するには、`~/.claude/settings.json` に次を追加する（settings.json はマシンごとの設定があるため dotfiles では管理しない）。

```json
"statusLine": {
  "type": "command",
  "command": "bash ~/.claude/statusline-command.sh"
}
```

## Brewfile の更新

現在のマシンの状態を書き出し直す：

```bash
cd ~/ghq/github.com/takachaya/dotfiles && brew bundle dump --no-vscode --force --file=Brewfile
```

- `--no-vscode`: VSCode 拡張は対象外（Settings Sync 側で管理）
- `--force`: 既存の Brewfile を上書き
- formula は依存を除いた「明示的にインストールしたもの」だけが載る

差分確認は `brew bundle check --no-upgrade --file=Brewfile`（`--no-upgrade` を外すと、未インストールではなく単に古いだけのものまで unmet として出る）。
