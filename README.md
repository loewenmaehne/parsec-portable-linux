# Parsec Portable Linux (No-Root / No-Sudo) 🎮

A lightweight, automated bash script to install and run the [Parsec](https://parsec.app/) game streaming client on restricted Linux machines where you do not have `sudo`, `apt`, or root privileges.

## 🧐 Why this exists
Normally, Parsec requires root privileges to install via a `.deb` package. If you try to manually unpack the binary and run it, it will silently exit because it expects configuration files in `/usr/share/parsec/skel`—a directory you can't create without root.

## 🪄 How it works
This script follows Linux best practices to get you running without admin rights:
1. **Universal Extraction:** Uses `ar` and `tar` to extract the official `.deb` package, making the script **distro-agnostic** (works on Ubuntu, Fedora, Arch, etc.).
2. **XDG Compliance:** Installs the app into `~/.local/share/parsec-portable` to keep your home directory clean.
3. **The Magic Fix:** Manually bootstraps the required `skel` config files into `~/.parsec` so the app launches successfully.
4. **Desktop Integration:** Automatically creates a Desktop Entry so Parsec appears in your **Application Menu** with the official icon.

## 🚀 How to use it

### Option 1: Quick Run (One-Liner)
Download and launch Parsec instantly:
```bash
curl -sO [https://raw.githubusercontent.com/loewenmaehne/parsec-portable-linux/main/parsec-portable.sh](https://raw.githubusercontent.com/loewenmaehne/parsec-portable-linux/main/parsec-portable.sh) && chmod +x parsec-portable.sh && ./parsec-portable.sh
