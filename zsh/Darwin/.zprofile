# .zprofile

########################################
# Login-only setup

if [[ `uname -m` == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v brew 1>/dev/null 2>&1; then
  export OPENSSL_ROOT=$(brew --prefix openssl)
  export LDFLAGS="-L$OPENSSL_ROOT/lib"
  export CPPFLAGS="-I$OPENSSL_ROOT/include"
  export PKG_CONFIG_PATH="$OPENSSL_ROOT/lib/pkgconfig"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_ROOT"
  path=($OPENSSL_ROOT/bin $path)
fi

if command -v rbenv 1>/dev/null 2>&1; then
  path=($HOME/.rbenv/shims $path)
  eval "$(rbenv init --no-rehash -)"
fi
