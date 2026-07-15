#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Shorten cwd to basename (mirrors robbyrussell %c)
dir=$(basename "$cwd")

# ANSI colors — matching robbyrussell exactly
# Arrow: bold green
ARROW="\033[1;32m➜\033[0m"
# Dir: cyan
DIR_COLOR="\033[0;36m"
RESET="\033[0m"
# git:(  bold blue
GIT_PREFIX="\033[1;34mgit:(\033[0m"
# branch name: red
BRANCH_COLOR="\033[0;31m"
# closing paren: bold blue
GIT_CLOSE="\033[1;34m)\033[0m"
# dirty mark: yellow
DIRTY_COLOR="\033[0;33m"
# extras (model, ctx): dim
DIM="\033[2m"

# Git branch info (skip optional locks to avoid blocking)
git_part=""
if git -C "$cwd" --no-optional-locks rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    if [ -n "$dirty" ]; then
      git_part="${GIT_PREFIX}${BRANCH_COLOR}${branch}${GIT_CLOSE} ${DIRTY_COLOR}✗${RESET}"
    else
      git_part="${GIT_PREFIX}${BRANCH_COLOR}${branch}${GIT_CLOSE}"
    fi
  fi
fi

# Context usage
context_part=""
if [ -n "$used" ] && [ "$used" != "null" ]; then
  used_int=$(printf "%.0f" "$used")
  context_part=" [ctx: ${used_int}%]"
fi

# Model part
model_part=""
if [ -n "$model" ] && [ "$model" != "null" ]; then
  model_part=" [$model]"
fi

# Compose output — mirroring robbyrussell: ➜  <dir> git:(<branch>) [model] [ctx]
if [ -n "$git_part" ]; then
  printf "${ARROW}  ${DIR_COLOR}%s${RESET} %b${DIM}%s%s${RESET}\n" \
    "$dir" "$git_part" "$model_part" "$context_part"
else
  printf "${ARROW}  ${DIR_COLOR}%s${RESET}${DIM}%s%s${RESET}\n" \
    "$dir" "$model_part" "$context_part"
fi
