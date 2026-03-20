# 🚀 RDP Manager Pro v2.0

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue)](https://ubuntu.com/)
[![Protocol](https://img.shields.io/badge/Protocol-RDP-green)](https://www.freerdp.com/)
[![Shell](https://img.shields.io/badge/Shell-Bash-orange)](https://www.gnu.org/software/bash/)
[![Version](https://img.shields.io/badge/Version-2.0-brightgreen)](https://github.com/johnavendano-afk/rdp-manager)

> **Professional Remote Desktop Connection Manager for Linux**  
> Built with passion for the Linux community 🐧

---

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Main Menu](#main-menu)
- [Configuration](#configuration)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## 🧠 About

**RDP Manager Pro** is a professional-grade remote desktop connection manager built specifically **for Linux users who need stable, fast, and reliable connections to Windows remote desktops**.

Born from the need to maintain a full Linux development environment while working on projects that require Windows Remote Desktop, this tool leverages the power of `xfreerdp` and Bash scripting to deliver:

- ✅ **Zero crashes** — unlike unstable GUI alternatives like Remmina
- ⚡ **Faster connection times** — lightweight, terminal-based and direct
- 🎛️ **Full control** over every aspect of your RDP sessions
- 🛠️ **Professional features** ready for daily production use

Compatible with: **Zorin OS, Ubuntu, Linux Mint, Debian**

---

## ✨ Features

| Feature | Description |
|--------|-------------|
| 🆕 **Create Connections** | Save and manage multiple RDP connection profiles |
| 📋 **List Connections** | View all your saved connections at a glance |
| 🔌 **Quick Connect** | Connect to any saved remote desktop instantly |
| 🖱️ **Desktop Shortcuts** | Generate one-click `.desktop` launchers |
| 📤 **Export Connections** | Share your config with your team (no passwords included) |
| 💾 **Backup & Restore** | Compress and restore all your configurations |
| 🔧 **Auto Setup** | Installs all dependencies automatically on first run |
| 📚 **Session Logs** | Every connection is logged automatically for debugging |
| ❌ **Delete Connections** | Clean up profiles you no longer need |

---

## 📦 Prerequisites

### 1. xfreerdp

The core component that handles the RDP protocol:

```bash
# For Debian / Ubuntu / Zorin OS / Linux Mint:
sudo apt update
sudo apt install freerdp2-x11 -y
```

> 💡 **Note:** On first run, RDP Manager Pro will automatically install all required dependencies: `freerdp2-x11`, `netcat-openbsd`, `zenity`, and `xclip`.

### 2. VPN Connection

> ⚠️ **Important:** An active VPN connection must be established **before** using RDP Manager Pro, according to your provider's specifications. The user is responsible for ensuring VPN connectivity.

---

## 🔧 Installation

### Method 1: Quick Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/johnavendano-afk/rdp-manager.git
cd rdp-manager

# Make the script executable
chmod +x rdp-manager-pro.sh

# Run the manager (auto-setup on first run)
./rdp-manager-pro.sh
```

### Method 2: Global Installation

```bash
# Install system-wide
sudo cp rdp-manager-pro.sh /usr/local/bin/rdp-manager
sudo chmod +x /usr/local/bin/rdp-manager

# Now you can run from anywhere
rdp-manager
```

---

## 🚀 Quick Start

**1. Launch RDP Manager Pro:**

```bash
./rdp-manager-pro.sh
```

On **first run**, the setup wizard will automatically install all dependencies and configure the system command `rdp-connect`.

**2. Create your first connection — Option `1`:**

- Enter a connection name (e.g., `Work`, `Server`)
- Enter the server IP or hostname
- Enter your username (e.g., `user@domain.com` or `DOMAIN\user`)
- Choose a security protocol (TLS recommended)
- Choose a resolution or fullscreen
- Enable/disable Clipboard, Drive sharing, and Audio

**3. Connect — Option `3`:**

- Choose your saved connection from the list
- The session opens automatically and is logged

---

## 🖥 Main Menu

When you run the script, you will see the following interactive menu:

```
╔════════════════════════════════════════╗
║     RDP MANAGER PRO v2.0               ║
║     Professional RDP Connection Manager║
╚════════════════════════════════════════╝
     Created by John Avendaño & Community
     https://github.com/johnavendano-afk/rdp-manager

1)  Create New Connection
2)  List All Connections
3)  Connect to Remote Desktop
4)  Create Desktop Shortcut
5)  Export Connections (for sharing)
6)  Backup/Restore
7)  Setup/Reinstall
8)  View Logs
9)  Delete Connection
0)  Exit
```

---

## ⚙ Configuration

### Connection Profiles

All profiles are stored in `~/.config/rdp-manager/` as `.conf` files:

```bash
# Example: ~/.config/rdp-manager/Work.conf

SERVER="192.168.1.100"
USERNAME="john@company.com"
DOMAIN="COMPANY"
PROTOCOL="tls"

FULLSCREEN="true"
WIDTH=""
HEIGHT=""

ENABLE_CLIPBOARD="true"
ENABLE_DRIVES="true"
ENABLE_AUDIO="true"
```

### Security Protocols

| Option | Protocol | Description |
|--------|----------|-------------|
| 1 | `tls` | TLS — **Recommended** |
| 2 | `nla` | Network Level Authentication |
| 3 | `negotiate` | Auto-negotiate |
| 4 | `rdp` | Legacy RDP |

### File Structure

```
~/.config/rdp-manager/               # Connection profiles (.conf)
~/.local/share/rdp-manager/
    logs/                            # Session logs (auto-generated)
    backups/                         # Backup archives (.tar.gz)
~/.local/share/icons/rdp-manager/    # Custom icons for shortcuts
```

### Custom Icons for Desktop Shortcuts

1. Place your icon files (`.png`) in: `~/.local/share/icons/rdp-manager/`
2. Edit the generated `.desktop` file on your Desktop
3. Update the `Icon=` line to point to your custom icon path

---

## 💡 Usage Examples

### Launch the main menu

```bash
./rdp-manager-pro.sh
```

### Connect directly from terminal (after setup)

```bash
rdp-connect "Work"
```

### Direct xfreerdp command

```bash
xfreerdp /v:192.168.1.100 /u:'user@domain.com' /sec:tls /cert-ignore /f
```

### Desktop Shortcut — example `.desktop` file

```ini
[Desktop Entry]
Version=1.0
Name=Work (RDP)
Comment=Connect to remote desktop
Exec=rdp-connect "Work"
Icon=/home/YOUR_USER/.local/share/icons/rdp-manager/default.png
Terminal=true
Type=Application
Categories=Network;
```

> 💡 Replace `YOUR_USER` with your actual Linux username.

---

## 🛠 Troubleshooting

### Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| `Permission denied` | Run `chmod +x rdp-manager-pro.sh` |
| `Command not found` | Use `./rdp-manager-pro.sh` instead of just the filename |
| `rdp-connect: not found` | Run option `7` (Setup/Reinstall) from the main menu |
| `Connection refused` | Verify VPN is active and the server is reachable |
| `Authentication failed` | Check username format: `DOMAIN\user` or `user@domain.com` |
| Connection drops immediately | Switch protocol to `tls` when creating the connection profile |
| Slow performance | The script already applies `/network:auto /gdi:hw /dynamic-resolution` automatically |
| Cannot copy/paste | Enable clipboard option when creating or editing the connection profile |

### Debug Mode

```bash
# Run with full debug output and save to log
xfreerdp /v:SERVER /u:USER /p:PASS +log-level:DEBUG 2>&1 | tee debug.log
```

### Logs Location

All connection logs are automatically stored in:

```
~/.local/share/rdp-manager/logs/
```

Each log file is named by timestamp and connection name, e.g.: `20240315_143022_Work.log`

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how to get involved:

1. **Fork** the repository
2. **Create** your feature branch:
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit** your changes:
   ```bash
   git commit -m 'Add AmazingFeature'
   ```
4. **Push** to the branch:
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open** a Pull Request 🎉

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for full details.

```
MIT License — Copyright (c) 2026 John Avendaño & Community
```

Free to use, modify, and distribute with attribution.

---

## 👤 Author

**John Avendaño & Community**

- 🐙 GitHub: [@johnavendano-afk](https://github.com/johnavendano-afk)
- 💼 LinkedIn: [John Avendaño](https://www.linkedin.com/in/johnavendano)

---

## ⭐ Support

If you find this project useful, please consider:

- Giving it a **star on GitHub** ⭐
- **Sharing it** with the Linux community
- **Contributing** with code, bug reports, or documentation

---

<p align="center">
  Made with ❤️ for the Linux community
</p>
