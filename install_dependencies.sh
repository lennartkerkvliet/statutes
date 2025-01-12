set -o errexit
set -o nounset
set -o pipefail

# Detect Netlify environment
if [ -n "${DEPLOY_URL:-}" ]; then
  NETLIFY_BUILD_BASE="/opt/buildhome"
else
  NETLIFY_BUILD_BASE="$PWD/buildhome"
fi

NETLIFY_CACHE_DIR="$NETLIFY_BUILD_BASE/cache"
TEXLIVE_DIR="$NETLIFY_CACHE_DIR/texlive"
TEXLIVE_BIN="$TEXLIVE_DIR/2024/bin/x86_64-linux"

INSTALL_TL_URL="http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
INSTALL_TL_SUCCESS="$NETLIFY_CACHE_DIR/install-tl-success"

TEXLIVEONFLY="$TEXLIVE_DIR/2024/texmf-dist/scripts/texliveonfly/texliveonfly.py"

TEXLIVE_PROFILE="\
selected_scheme scheme-small
TEXMFCONFIG \$TEXMFSYSCONFIG
TEXMFHOME \$TEXMFLOCAL
TEXMFVAR \$TEXMFSYSVAR
binary_x86_64-linux 1
collection-basic 1
collection-latex 1
collection-xetex 1
collection-fontsrecommended 1
instopt_adjustpath 1
instopt_portable 1
TEXDIR $TEXLIVE_DIR/2024
TEXMFLOCAL $TEXLIVE_DIR/texmf-local
TEXMFSYSCONFIG $TEXLIVE_DIR/2024/texmf-config
TEXMFSYSVAR $TEXLIVE_DIR/2024/texmf-var
"

# Install TeX Live if not already installed
if [ ! -e "$INSTALL_TL_SUCCESS" ]; then
  echo "[$0] Installing TeX Live..."

  mkdir -p "$NETLIFY_CACHE_DIR"
  curl -L "$INSTALL_TL_URL" -o "$NETLIFY_CACHE_DIR/install-tl-unx.tar.gz"
  tar xf "$NETLIFY_CACHE_DIR/install-tl-unx.tar.gz" -C "$NETLIFY_CACHE_DIR"
  
  INSTALL_TL_DIR=$(find "$NETLIFY_CACHE_DIR" -maxdepth 1 -type d -name 'install-tl-*' | head -n 1)
  echo "$TEXLIVE_PROFILE" > "$NETLIFY_CACHE_DIR/texlive.profile"

  "$INSTALL_TL_DIR/install-tl" --profile="$NETLIFY_CACHE_DIR/texlive.profile"
  "$TEXLIVE_BIN/tlmgr" install texliveonfly

  # Install additional packages
  "$TEXLIVE_BIN/tlmgr" install xetex fontspec FiraSans FiraMono

  echo "[$0] TeX Live installation completed."
  touch "$INSTALL_TL_SUCCESS"
else
  echo "[$0] Found existing TeX Live installation."
fi

# Add TeX Live to PATH
export PATH="$TEXLIVE_BIN:$PATH"