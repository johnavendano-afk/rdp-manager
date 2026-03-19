# 🚀 RDP Manager Pro

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue)](https://ubuntu.com/)
[![Protocol](https://img.shields.io/badge/Protocol-RDP-green)](https://www.freerdp.com/)
[![Shell](https://img.shields.io/badge/Shell-Bash-orange)](https://www.gnu.org/software/bash/)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen)](https://github.com/johnavendano-afk/rdp-manager)

> **Professional Remote Desktop Connection Manager for Linux**  
> Built with passion for the Linux community 🐧

---

## 📋 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [How to Run](#-how-to-run)
- [Configuration](#-configuration)
- [Usage Examples](#-usage-examples)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## 🧠 About

**RDP Manager Pro** is a professional-grade remote desktop connection manager built specifically **for Linux users who need stable, fast, and reliable connections to Windows remote desktops**.

Born from frustration with unstable GUI tools like Remmina, this tool leverages the power of `xfreerdp` and Bash scripting to deliver:

- ✅ **Zero crashes** — unlike other GUI alternatives
- ⚡ **Faster connection times** — lightweight and direct
- 🎛️ **Full control** over your RDP sessions
- 🛠️ **Professional features** for daily production use

---

## ✨ Features

| Feature | Description |
|--------|-------------|
| 🖥️ **Multiple Connections** | Manage all your RDP connections in one place |
| 🔌 **Desktop Shortcuts** | One-click connections directly from your desktop |
| 📝 **Automatic Logging** | Every session is logged automatically for debugging |
| 💾 **Backup & Restore** | Never lose your saved configurations |
| 🎨 **Custom Icons** | Personalize your desktop shortcuts |
| 🔒 **Secure Authentication** | TLS and SSH key integration supported |
| 📊 **Connection Testing** | Built-in ping and port verification |
| 📤 **Export / Import** | Easily share settings with your team |

---

## 📦 Prerequisites

### 1. xfreerdp

The core component that handles the RDP protocol:

```bash
# For Debian / Ubuntu / Zorin OS:
sudo apt update
sudo apt install freerdp2-x11 -y
```

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

# Run the manager
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

**2. Create your first connection:**

- Select option `1` → **Create New Connection**
- Enter the server IP or hostname
- Enter your username (e.g., `user@domain.com` or `DOMAIN\user`)
- Configure resolution and optional features

**3. Connect:**

- Select option `3` → **Connect to Remote Desktop**
- Choose your saved connection from the list
- Enter your password when prompted

---

## 🖥️ How to Run

### From the terminal

```bash
# Navigate to the project folder
cd ~/RDP_Conn_Manager

# Ensure execution permissions
chmod +x rdp-manager-pro.sh

# Run the script
./rdp-manager-pro.sh
```

### Create a Desktop Shortcut

```bash
# Create the .desktop launcher file
nano ~/Desktop/rdp-manager.desktop
```

Paste the following content:

```ini
[Desktop Entry]
Version=1.0
Name=RDP Manager Pro
Comment=Remote Desktop Connection Manager
Exec=/home/YOUR_USER/RDP_Conn_Manager/rdp-manager-pro.sh
Icon=terminal
Terminal=true
Type=Application
Categories=Network;
```

> 💡 Replace `YOUR_USER` with your actual Linux username.

```bash
# Make the shortcut executable
chmod +x ~/Desktop/rdp-manager.desktop
```

### Run with Bash directly

```bash
bash rdp-manager-pro.sh
```

---

## ⚙️ Configuration

### Connection Profile Example

Connection files are stored in `~/.config/rdp-manager/`:

```bash
# Example: ~/.config/rdp-manager/Work.conf

SERVER="192.168.1.100"
USERNAME="john@company.com"
DOMAIN="COMPANY"
PROTOCOL="tls"
FULLSCREEN="true"
ENABLE_CLIPBOARD="true"
ENABLE_DRIVES="true"
ENABLE_AUDIO="true"
```

### Custom Icons for Desktop Shortcuts

1. Place your icon files in: `~/.local/share/icons/rdp-manager/`
2. Edit the `.desktop` file on your Desktop
3. Update the `Icon=` line to point to your custom icon path

---

## 💡 Usage Examples

### Launch the main menu

```bash
./rdp-manager-pro.sh
```

### Direct xfreerdp connection

```bash
xfreerdp /v:192.168.1.100 /u:'user@domain.com' /sec:tls /cert-ignore /f
```

### Command line options (if configured)

```bash
./rdp-manager-pro.sh --help
./rdp-manager-pro.sh --connect "Work"
```

---

## 🛠️ Troubleshooting

### Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| `Permission denied` | Run `chmod +x rdp-manager-pro.sh` |
| `Command not found` | Use `./rdp-manager-pro.sh` instead of just the name |
| `Connection refused` | Verify VPN is active and the server is reachable |
| `Authentication failed` | Check username format: `DOMAIN\user` or `user@domain.com` |
| Connection drops immediately | Try using `/sec:tls` instead of auto-negotiation |
| Slow performance | Add `/network:auto` and `/gfx` flags |
| Cannot copy/paste | Enable clipboard with `+clipboard` flag |

### Debug Mode

```bash
# Run with full debug output and save to log
xfreerdp /v:SERVER /u:USER /p:PASS +log-level:DEBUG 2>&1 | tee debug.log
```

### Logs Location

All connection logs are stored in:

```
~/.local/share/rdp-manager/logs/
```

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

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**John Avendaño**

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
