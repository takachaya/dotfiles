# CHANGELOG

## 2026-09-15

### claude/statusline-command.sh（新規・移動）

- `~/.claude/statusline-command.sh` はグローバル設定直下の実体で他環境への移植性がなかった。dotfilesへ実体を移し、`~/.claude/`側はsymlinkにすることで新環境ではclone+symlinkのみで再現できるようにした。

### claude/CLAUDE.md

- **追加**：Skill（`.claude/skills/`）・Hook（`.claude/hooks/`）の新設・改修は他の正本更新と分けて単独コミットする運用（`skill: <対象名> <変更内容>`形式。後日`git filter-repo`等での抽出を容易にするため）
- **追加**：意見・希望・疑問形の発話には編集せず意見を返して止まる運用（解釈確認への肯定は編集承認とみなさない）
  - いずれもwork-logのCLAUDE.mdで運用実績があり、個人の汎用ルールとして2026-07-15に昇格判断済み（2026-08-26に例外範囲を明確化）

### claude/de-ai-writing.md

- **追加**：硬い専門語まがいの言い回し（「〜では捕まらない」等）を平易な言葉へ言い換えるチェック項目（2026-08-06 指摘）
- **追加**：対になる短い項目での無自覚な類語言い換えを避けるチェック項目（2026-09-03 指摘）
  - それぞれに対応するBefore/After事例を追加

## 2026-08-17

### Brewfile（新規）

- 会社支給Mac（Mac17,3）の Homebrew 構成を書き出し。tap 1・formula 7・cask 26・mas 6・npm 1。VSCode 拡張は対象外（`--no-vscode`）。
  - App Store アプリを含めるため `mas` を新規インストール（formula 7件目）。

### README.md

- **追加**：構成表に `Brewfile` の行、セットアップ手順に `brew bundle`、「Brewfile の更新」セクション（再 dump コマンドと差分確認方法）

## 2026-07-03

### claude/CLAUDE.md

- **追加**：「進め方」に判断材料の文書化提示ルール（判断を仰ぐ前に問い・事実・有利不利・推奨を一時ファイルに固めて提示し、判断後は正本に統合して削除）
  - 理由：work-log プロジェクトメモリで確立・確認済みの挙動を T1（個人横断）へ昇格。挙動昇格パイプラインのパイロット第1号（work-log decisions 2026-07-03）。

## 2026-07-02

### claude/de-ai-writing.md（新規）

- 文章生成のAIっぽさ回避ハーネス（構成・語彙・トーン・リズムのチェックリスト＋Before/After）
  - 理由：work-log メモリ writing-style-no-decoration を統合し、全プロジェクト横断の正本として dotfiles に集約。

### claude/CLAUDE.md

- **追加**：「出力スタイル」から de-ai-writing.md を `@import` 参照（まとまった文章を書くときの自己チェック）

### claude/skills/（新規）

- `exec-summary` / `handoff` の2スキルを追加。`~/.claude/skills/` から symlink して使用。
  - 理由：過去プロンプト全履歴の分析から頻出パターンをスキル化（work-log daily 2026-07-02）。プロジェクト非依存のため dotfiles を実体とする。

## 2026-06-17

### claude/CLAUDE.md

- **追加**：「進め方」に再利用可能なClaude Code機能の機構照合ルール（スキル / スラッシュコマンド / フック / CLAUDE.mdルール / サブエージェントを要件で照合してから提案）
- **追加**：「指示・ルールの置き場所（CLAUDE.md肥大化対策）」セクション（常駐はCLAUDE.md・タスク限定はスキル・path-scopedは`.claude/rules/`・強制はHook、`@import`はコンテキスト削減にならない）
  - 出典：work-log memo 2026-06-17（文字起こし取り込みスキル構築）

## 日付未記録（2026-06-11〜24の間）

### claude/CLAUDE.md

- **追加**：「インボックス管理」セクション（スコープ外の気づきは `~/Documents/Projects/_inbox.md` に追記して作業を続ける）
  - 追記日は未記録。2026-06-24 の work-log 決定（pull型吸い上げ）時点で既存習慣として言及されている。

## 2026-06-11

### claude/CLAUDE.md

- **追加**：「ローカルへのファイル作成・編集など安全な操作は、確認なく自発的に実行する」
  - 理由：セットアップ手順案内中にスクリプトファイルを自発的に作成しなかったため。説明だけでなく実行まで行う方針に統一。
