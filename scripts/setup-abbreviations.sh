#!/usr/bin/env zsh
# Setup zsh-abbr abbreviations from Arch Linux
# Source zsh-abbr first
source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-abbr/zsh-abbr.zsh || true

# BASIC STUFF
abbr --quiet --session e="exit"
abbr --quiet --session v="$EDITOR"
abbr --quiet --session c="clear"
abbr --quiet --session g="git"
abbr --quiet --session d="docker"
abbr --quiet --session dc="docker compose"
abbr --quiet --session k="kubectl"

# PYTHON VIRTUAL ENV
abbr --quiet --session av=". .venv/bin/activate"
abbr --quiet --session us="uv sync"

# GITHUB & GIT
abbr --quiet --session init="pre-commit install && cz init"
abbr --quiet --session ga="git add -A"
abbr --quiet --session gs="git status"
abbr --quiet --session gd="git diff"
abbr --quiet --session gl="git log --oneline -10"
abbr --quiet --session gg="git add . && git commit -m"
abbr --quiet --session gp="git push"
abbr --quiet --session gpl="git pull"
abbr --quiet --session gcb="git checkout -b"
abbr --quiet --session gc="git checkout"
abbr --quiet --session pcr="pre-commit run --all-files"
abbr --quiet --session pcu="pre-commit autoupdate"
abbr --quiet --session pt="uv run coverage run -m pytest -o log_cli=true -vvv tests && uv run coverage report && uv run coverage html"

# FANCY NEW TOOLS
abbr --quiet --session ff="fastfetch"
abbr --quiet --session ls="eza -1 -a --icons --group-directories-first"
abbr --quiet --session l="eza -lah --icons --group-directories-first"
abbr --quiet --session ll="eza -lah --icons --group-directories-first"
abbr --quiet --session lt="eza --tree --level 2"
abbr --quiet --session lg="eza -lah --git --icons --group-directories-first"
abbr --quiet --session cat="bat"

# AI TOOLS
abbr --quiet --session oc="opencode"

# DOCKER COMPOSE ABBREVIATIONS
abbr --quiet --session dcb="docker compose build"
abbr --quiet --session dcu="docker compose up"
abbr --quiet --session dcub="docker compose up --build"
abbr --quiet --session dd="docker compose up --build -d"
abbr --quiet --session dl="docker compose logs -f -t"
abbr --quiet --session tt="tilt down; tilt up"

# KUBERNETES ABBREVIATIONS
abbr --quiet --session kgp="kubectl get pods"

# OTHER TOOLS
abbr --quiet --session nvitop="uvx nvitop"
