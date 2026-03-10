#!/bin/sh

# ==============================================================================
# Parsec Portable Linux (No-Root / No-Sudo)
# Repository: https://github.com/loewenmaehne/parsec-portable-linux
# ==============================================================================

PARSEC_DIR="$HOME/.local/share/parsec-portable"
PARSEC_CONFIG="$HOME/.parsec"
PARSEC_BIN="$PARSEC_DIR/usr/bin/parsecd"
DESKTOP_ENTRY="$HOME/.local/share/applications/parsec-portable.desktop"

echo "🚀 Checking for Parsec..."

if [ -x "$PARSEC_BIN" ]; then
    echo "✅ Parsec is already installed!"
else
    echo "⚠️ Starting portable setup..."
    mkdir -p "$PARSEC_DIR" "$PARSEC_CONFIG"
    cd "$PARSEC_DIR" || exit

    echo "⬇️ Downloading..."
    URL="https://builds.parsecgaming.com/package/parsec-linux.deb"
    if command -v wget >/dev/null; then wget -qO p.deb "$URL"; else curl -sL -o p.deb "$URL"; fi

    echo "📦 Extracting..."
    ar x p.deb && tar -xf data.tar.*
    rm -f control.tar.* debian-binary p.deb data.tar.*

    echo "🔧 Patching config..."
    cp -r ./usr/share/parsec/skel/* "$PARSEC_CONFIG/" 2>/dev/null
fi

# Create Desktop Entry (Standard Linux App Integration)
if [ ! -f "$DESKTOP_ENTRY" ]; then
    echo "🖥️ Integrating with App Menu..."
    mkdir -p "$HOME/.local/share/applications"
    cat <<EOF > "$DESKTOP_ENTRY"
[Desktop Entry]
Name=Parsec Portable
Exec=$PARSEC_BIN
Icon=$PARSEC_DIR/usr/share/icons/hicolor/512x512/apps/parsecd.png
Terminal=false
Type=Application
Categories=Network;RemoteAccess;
EOF
fi

echo "🎮 Launching Parsec..."
"$PARSEC_BIN" > /dev/null 2>&1 &
