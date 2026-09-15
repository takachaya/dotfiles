#!/usr/bin/env bash
# Claude Code statusline
# 表示: モデル名 / カレントディレクトリ basename (gitブランチ) / コンテキスト残量（%） / レート制限使用率（5h・週次） / セッション経過時間
set -euo pipefail

input="$(cat)"

model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // "?"')
dirname=$(basename "$dir")

# gitブランチ（gitリポジトリでない場合は非表示。ロック取得を避けるため --no-optional-locks）
branch=$(git -C "$dir" --no-optional-locks branch --show-current 2>/dev/null || true)
branch_part=""
if [ -n "$branch" ]; then
  branch_part=" (${branch})"
fi

# コンテキスト残量（フィールドが無い/nullな古いバージョンではフォールバックして非表示）
remaining=$(printf '%s' "$input" | jq -r '.context_window.remaining_percentage // empty' 2>/dev/null || true)

ctx=""
if [ -n "$remaining" ]; then
  pct=$(printf '%.0f' "$remaining")
  mark=""
  if [ "$pct" -le 15 ]; then
    mark="🔴 "
  elif [ "$pct" -le 30 ]; then
    mark="⚠️ "
  fi
  ctx=" | ctx残${mark}${pct}%"
fi

# レート制限使用率（5時間・週次。サブスクリプションでAPI応答後のみ存在）
five=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null || true)
week=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' 2>/dev/null || true)

rate=""
if [ -n "$five" ] || [ -n "$week" ]; then
  rate=" |"
  if [ -n "$five" ]; then
    rate="${rate} 5h:$(printf '%.0f' "$five")%"
  fi
  if [ -n "$week" ]; then
    rate="${rate} 7d:$(printf '%.0f' "$week")%"
  fi
fi

# セッション経過時間（transcriptファイルの作成時刻＝セッション開始時刻とみなす）
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // empty')

elapsed=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  start_epoch=$(stat -f %B "$transcript" 2>/dev/null || true)
  if [ -n "$start_epoch" ] && [ "$start_epoch" -gt 0 ] 2>/dev/null; then
    now_epoch=$(date +%s)
    diff=$(( now_epoch - start_epoch ))
    if [ "$diff" -lt 0 ]; then
      diff=0
    fi
    h=$(( diff / 3600 ))
    m=$(( (diff % 3600) / 60 ))
    if [ "$h" -gt 0 ]; then
      elapsed=" | ⏱ ${h}h${m}m"
    else
      elapsed=" | ⏱ ${m}m"
    fi
  fi
fi

printf '\033[2m%s | %s%s%s%s%s\033[0m' "$model" "$dirname" "$branch_part" "$ctx" "$rate" "$elapsed"
