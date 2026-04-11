# .zshenv

########################################

# Locale and environment
export LANG=ja_JP.UTF-8
export EDITOR='emacsclient -nw'

########################################
# PATH
export MINT_PATH="$HOME/.mint"
export MINT_LINK_PATH="$MINT_PATH/bin"

export GOPATH="$HOME/go"

path=(
  # X11
  /usr/X11/bin(N-/)
  # GNU coreutils
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  # Local binaries (stack, scripts, etc.)
  $HOME/.local/bin(N-/)
  # Rust
  $HOME/.cargo/bin(N-/)
  # Homebrew sbin
  /usr/local/sbin(N-/)
  # Homebrew (Apple Silicon)
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  # Standard system paths (from /etc/paths)
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
  # Java
  $JAVA_HOME/bin(N-/)
  # Go
  $GOPATH/bin(N-/)
  # Mint
  $MINT_LINK_PATH(N-/)
  # Docker
  $HOME/.docker/bin(N-/)
)

# Homebrew completions
fpath=(
  /opt/homebrew/share/zsh/site-functions(N-/)
  $fpath
)

# Deduplicate path arrays
typeset -U path cdpath fpath manpath

#############################################
