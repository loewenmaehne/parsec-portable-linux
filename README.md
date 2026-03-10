# Parsec Portable Linux (No-Root / No-Sudo) 🎮

A lightweight, automated bash script to install and run the [Parsec](https://parsec.app/) game streaming client on restricted Linux machines (like school or work computers) where you do not have `sudo`, `apt`, or root privileges.

## 🧐 Why this exists
Normally, Parsec requires root privileges to install via a `.deb` package. If you try to manually unpack the `.deb` and run the binary without installing it globally, Parsec will silently crash and exit. 

This happens because the app looks for default configuration files in `/usr/share/parsec/skel` (which requires root to create). 

## 🪄 How it works
This script bypasses system restrictions by:
1. Downloading the official `.deb` package directly from Parsec's servers.
2. Unpacking the archive locally into your `~/parsec-local` directory.
3. **The Magic Fix:** Copying the required `skel` setup files into your local `~/.parsec` hidden folder so the app can successfully bootstrap itself.
4. Launching the app. 

It also checks if Parsec is already downloaded so you don't waste bandwidth re-downloading it every time you want to play.

## 🚀 How to use it

### Option 1: Quick Run (One-Liner)
You can download, make executable, and run the script in a single command from your terminal:

```bash
curl -sO [https://raw.githubusercontent.com/loewenmaehne/parsec-portable-linux/main/parsec-portable.sh](https://raw.githubusercontent.com/loewenmaehne/parsec-portable-linux/main/parsec-portable.sh) && chmod +x parsec-portable.sh && ./parsec-portable.sh
