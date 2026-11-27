# dotfiles

My Arch Linux + Sway setup. Gruvbox Material everywhere, Comic Mono, and a pile of small scripts that glue the workflow together.

Only the core of the workflow lives here: the window manager, bar, launcher, terminal, shell and the scripts I bind to keys. App-specific configs (browsers and so on) stay out. My Neovim config has [its own repo](https://github.com/tejassharma-ts/nvim).

## What's inside

| Path | What it does |
|---|---|
| `.config/sway` | Window manager: keybinds, gaps, zen mode, night light, window picker |
| `.config/waybar` | Status bar with scripts for wifi, bluetooth, battery, volume, brightness and theme switching |
| `.config/rofi` | Launcher plus power, wifi and bluetooth menus |
| `.config/wofi` | Alternate menus for the bar and wallpapers |
| `.config/dunst` | Notifications |
| `.config/swaylock` | Lock screen |
| `.config/kitty` | Terminal, with tab/split keybinds under `ctrl+s` |
| `.config/tmux`, `.config/zellij` | Terminal multiplexers |
| `.zshrc`, `.p10k.zsh`, `.config/zsh` | Shell, prompt, git helpers and per-repo git account switching |
| `.config/fzf`, `.config/yazi`, `.config/lazygit`, `.config/git` | CLI tools |
| `.config/gtk-3.0`, `.config/gtk-4.0`, `.config/xsettingsd` | GTK theme and cursor |
| `.config/systemd/user` | Battery-low alert, and a sound that plays when the charger is plugged in |
| `.local/bin` | Scripts: screenshots, audio output switch, project launcher, wallpaper picker, clipboard history and more |

## Install

The repo mirrors `$HOME`, so [GNU Stow](https://www.gnu.org/software/stow/) can symlink everything into place.

```bash
sudo pacman -S stow
git clone https://github.com/tejassharma-ts/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --no-folding .
```

Stow refuses to overwrite existing files, so back up or remove any configs it complains about first.

Then enable the user services:

```bash
systemctl --user enable --now battery-low-notify.timer charger-arigato.service
```

## Dependencies

- **Desktop:** `sway` `swaylock` `waybar` `rofi` `wofi` `dunst` `swww` `wlsunset` `grim` `slurp` `wl-clipboard` `cliphist`
- **Terminal:** `kitty` `tmux` `zellij` `zsh` with [oh-my-zsh](https://ohmyz.sh), `zsh-autosuggestions` and `zsh-syntax-highlighting`
- **Tools:** `fzf` `yazi` `lazygit` `jq` `libnotify` `brightnessctl` `playerctl` `pipewire-pulse` `networkmanager` `bluez-utils`
- **Fonts and theme:** Comic Mono, JetBrainsMono Nerd Font, Noto Sans CJK, Simp1e-Gruvbox-Dark cursor

For tmux plugins, install [TPM](https://github.com/tmux-plugins/tpm) and press `prefix + I`.
