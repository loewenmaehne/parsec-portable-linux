#!/bin/sh

# ==============================================================================
# Parsec Portable Launcher for Restricted Linux Environments
# Repository: https://github.com/loewenmaehne/parsec-portable-linux
# ==============================================================================

# Define our directories and files
PARSEC_DIR="$HOME/parsec-local"
PARSEC_CONFIG="$HOME/.parsec"
PARSEC_BIN="$PARSEC_DIR/usr/bin/parsecd"

echo "🚀 Checking for Parsec..."

# Check if the Parsec binary already exists and is executable
if [ -x "$PARSEC_BIN" ]; then
    echo "✅ Parsec is already installed!"
    echo "🎮 Launching Parsec..."
    "$PARSEC_BIN" &
    exit 0
fi

# If it doesn't exist, proceed with the portable setup
echo "⚠️ Parsec not found. Starting portable setup..."

mkdir -p "$PARSEC_DIR"
mkdir -p "$PARSEC_CONFIG"
cd "$PARSEC_DIR" || exit

echo "⬇️ Downloading Parsec..."
if command -v wget >/dev/null 2>&1; then
    wget -qO parsec-linux.deb https://builds.parsecgaming.com/package/parsec-linux.deb
elif command -v curl >/dev/null 2>&1; then
    curl -sL -o parsec-linux.deb https://builds.parsecgaming.com/package/parsec-linux.deb
else
    echo "❌ Error: Neither wget nor curl is installed."
    exit 1
fi

echo "📦 Extracting package..."
dpkg -x parsec-linux.deb .

# The Magic Fix: Copy the skeleton config files so Parsec doesn't panic and exit
echo "🔧 Applying the skeleton config fix..."
cp -r ./usr/share/parsec/skel/* "$PARSEC_CONFIG/" 2>/dev/null

# Clean up the .deb file
rm parsec-linux.deb

echo "✅ Setup complete!"
echo "🎮 Launching Parsec..."

# Launch in the background
"$PARSEC_BIN" &
