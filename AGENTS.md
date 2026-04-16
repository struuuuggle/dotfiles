# Repository Guidelines

## Project Structure & Module Organization
- `zsh/`, `bash/`, `vim/`, `tmux/`, `git/`, `ghostty/`, `rectangle/`, `.emacs.d/` hold tool-specific configs.
- `zsh/Darwin/.zshrc` and `zsh/Linux/.zshrc` are platform-specific entry points.
- `Makefile` provides setup automation; `Brewfile` is Homebrew bundle.
- `README.md` contains OS-level setup notes.

## Build, Test, and Development Commands
- `make` shows available targets.
- `make symlink` creates symlinks into `$HOME` (calls `git`, `zsh`, `bash`, `vim`, `.emacs.d`, `ghostty` targets).
- `make git` links `.gitconfig` and sets git config entries.
- `make zsh` links zsh configs and installs zsh-autosuggestions plugin.
- `make bash` links bash configs.
- `make vim` links `.vimrc`.
- `make .emacs.d` links Emacs config directory.
- `make ghostty` links Ghostty config (macOS only).
- `make macos` runs macOS setup tasks including `brew bundle` (macOS only).
- `make debian` installs minimum tools via Debian packages (Linux only).
- `make emacs-compile` builds `init.el` from `init.org` via org-babel tangle.
- `make emacs-restart` restarts Emacs daemon with latest config.
- `make emacs-reinstall` reinstalls `emacs-plus-app` (macOS only).
- `make brewfile` dumps current Homebrew state to `Brewfile`.

## Coding Style & Naming Conventions
- Keep configs minimal and readable; match existing formatting in each file.
- Shell configs generally use 2-space indentation; Makefile recipes require tabs.
- Name new config directories by tool (e.g., `ghostty/`, `tmux/`).

## Testing Guidelines
- No automated tests currently. Validate changes by running the relevant tool
  (e.g., start a new shell for `.zshrc`, open Ghostty for `ghostty/config`).

## Commit & Pull Request Guidelines
- Use conventional commit prefixes (`feat:`, `fix:`, `perf:`, `refactor:`, `style:`, `docs:`, `chore:`) and keep messages concise.
- PRs (if used) should include: a short summary, affected paths, and how you verified the change
  (e.g., `make symlink`, "opened Ghostty to confirm theme").

## Emacs Configuration
- `.emacs.d/init.el` is generated from `.emacs.d/init.org` (org-babel tangle).
- Always edit `init.org`; never edit `init.el` directly.
- `.emacs.d/early-init.el` handles early-stage startup settings (can be edited directly).
- Use `make emacs-compile` to regenerate `init.el`, and `make emacs-restart` to restart the Emacs daemon.

## Configuration & Symlinks
- This repo is designed to be symlinked into `$HOME`. Prefer adding new configs here
  and extending `make symlink` to wire them up (example: `ghostty/config`).
