# Ambiente dell'utente

## Lingua
L'utente scrive in italiano. Rispondi in italiano. Codice, commenti nel codice e messaggi di commit restano in inglese.

## Uso dei subagent (risparmio token)
Per esplorazione codebase, lettura file, pattern matching, ricerca di import/usi, raccolta contesto: delega SEMPRE a un subagent (Explore o general-purpose) specificando esplicitamente il parametro `model`. Default: `model: "sonnet"`. Usa `model: "haiku"` se il task è abbastanza semplice che Haiku è sufficiente (es. lettura di un singolo file noto, grep puntuale, lookup banali di un import). Riserva il main thread (Opus) per decisioni architetturali, scrittura/modifica di componenti e sintesi finale. Il subagent restituisce solo il riassunto, non inquina il contesto principale con output grezzo di Grep/Read/Glob.

**IMPORTANTE**: specificare il parametro `model` è obbligatorio, non un suggerimento. In sessioni precedenti l'agente ha ignorato questa istruzione e lanciato subagent senza `model`, facendoli ereditare Opus e vanificando il risparmio token. Non farlo: rispetta questa regola anche quando sembra più rapido saltarla.

## Dotfiles
- Gestiti con **yadm** (non è un repo git in `~`). Configurazioni sotto `~/.config/`.
- Neovim: LazyVim in `~/.config/nvim/`, con `lua/colorscheme-choice.lua` come selettore di colorscheme.
- Tmux: `~/.tmux.conf` + `~/.config/tmux/`, con `theme-choice.tmux` come selettore di tema.

## Cambio tema (tmux + nvim)
Entrambi i selettori hanno un elenco di righe tutte commentate tranne UNA (quella attiva). Per cambiare tema:
1. In `~/.config/tmux/theme-choice.tmux`: commenta la riga `source-file ...` attuale, decommenta quella desiderata.
2. In `~/.config/nvim/lua/colorscheme-choice.lua`: commenta la riga `vim.cmd.colorscheme(...)` attuale, decommenta quella desiderata.
3. Ricarica tmux: `tmux source-file ~/.tmux.conf`.

Coppie di temi consigliate (tmux ↔ nvim):
- `iterm2-muted` ↔ `iterm2-dark-background`
- `claude-desktop` ↔ `claude-desktop`
- `kanagawa-dragon` ↔ `kanagawa-dragon`
- `solarized-osaka` ↔ `solarized-osaka`
- `everforest` ↔ `everforest`

Il colorscheme `claude-desktop` di Neovim arriva dal plugin `daaanny90/claude-desktop.nvim` (vedi `lua/plugins/colorscheme.lua`).
