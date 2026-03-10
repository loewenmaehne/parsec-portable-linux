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

    echo "🖼️ Installing icon..."
    mkdir -p "$HOME/.local/share/icons/hicolor/256x256/apps"
    cp "$PARSEC_DIR/usr/share/icons/hicolor/256x256/apps/parsecd.png" \
        "$HOME/.local/share/icons/hicolor/256x256/apps/parsecd.png"
    command -v gtk-update-icon-cache >/dev/null && \
        gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
fi

# Create Desktop Entry (Standard Linux App Integration)
if [ ! -f "$DESKTOP_ENTRY" ]; then
    echo "🖥️ Integrating with App Menu..."
    mkdir -p "$HOME/.local/share/applications"
    cat <<EOF > "$DESKTOP_ENTRY"
[Desktop Entry]
Name=Parsec
Exec=$PARSEC_BIN
Icon=parsecd
Terminal=false
Type=Application
Categories=Network;RemoteAccess;
StartupWMClass=parsecd
EOF
fi

echo "🎮 Launching Parsec..."
"$PARSEC_BIN" > /dev/null 2>&1 &
