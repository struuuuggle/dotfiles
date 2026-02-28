# Repository Guidelines

## Project Structure & Module Organization
- `zsh/`, `bash/`, `vim/`, `tmux/`, `git/`, `ghostty/`, `rectangle/` hold tool-specific configs.
- `zsh/Darwin/.zshrc` and `zsh/Linux/.zshrc` are platform-specific entry points.
- `Makefile` provides setup automation; `Brewfile` is Homebrew bundle.
- `README.md` contains OS-level setup notes.

## Build, Test, and Development Commands
- `make` shows available targets.
- `make symlink` creates symlinks into `$HOME` (e.g., `~/.zshrc`, `~/.vimrc`) and sets git config entries.
- `make macos` installs Homebrew (if needed) and packages from `Brewfile` (macOS only).
- `make debian` installs minimum zsh-related tools via Debian packages (Linux only).
- `make zsh-autosuggestions` installs the plugin into `~/.zsh/`.
- `make compile-emacs` byte-compiles Emacs configs.
- `make reinstall-emacs` reinstalls `emacs-plus` (macOS only).

## Coding Style & Naming Conventions
- Keep configs minimal and readable; match existing formatting in each file.
- Shell configs generally use 2-space indentation; Makefile recipes require tabs.
- Name new config directories by tool (e.g., `ghostty/`, `tmux/`).

## Testing Guidelines
- No automated tests currently. Validate changes by running the relevant tool
  (e.g., start a new shell for `.zshrc`, open Ghostty for `ghostty/config`).

## Commit & Pull Request Guidelines
- Recent history mixes conventional prefixes (`feat:`, `refactor:`, `chore:`) and short imperative summaries.
  Prefer conventional prefixes when possible and keep messages concise.
- PRs (if used) should include: a short summary, affected paths, and how you verified the change
  (e.g., `make symlink`, “opened Ghostty to confirm theme”).

## Configuration & Symlinks
- This repo is designed to be symlinked into `$HOME`. Prefer adding new configs here
  and extending `make symlink` to wire them up (example: `ghostty/config`).
