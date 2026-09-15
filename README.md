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

## セットアップ

新しいマシンに移行する際は以下を実行：

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Homebrew パッケージの復元（App Store アプリを含めるなら先に App Store へサインインしておく）
brew bundle --file=~/dotfiles/Brewfile

# Claude Code 設定の symlink
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/claude/statusline-command.sh ~/.claude/statusline-command.sh
for s in adr-manager exec-summary grill-me grilling handoff tdd; do
  ln -sf ~/dotfiles/claude/skills/$s ~/.claude/skills/$s
done
```

※ `de-ai-writing.md` の `@import` は symlink 先の実体パス（`~/dotfiles/claude/`）基準で解決されるため、個別の symlink は不要。

## Brewfile の更新

現在のマシンの状態を書き出し直す：

```bash
cd ~/dotfiles && brew bundle dump --no-vscode --force --file=Brewfile
```

- `--no-vscode`: VSCode 拡張は対象外（Settings Sync 側で管理）
- `--force`: 既存の Brewfile を上書き
- formula は依存を除いた「明示的にインストールしたもの」だけが載る

差分確認は `brew bundle check --no-upgrade --file=Brewfile`（`--no-upgrade` を外すと、未インストールではなく単に古いだけのものまで unmet として出る）。
