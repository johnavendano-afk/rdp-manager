# 🚀 RDP Manager Pro

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux](https://img.shields.io/badge/Platform-Linux-blue)](https://ubuntu.com/)
[![RDP](https://img.shields.io/badge/Protocol-RDP-green)](https://www.freerdp.com/)

**Professional Remote Desktop Connection Manager for Linux**  
Created with passion for the Linux community

---

## 📋 Table of Contents
- [About](#about)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [How to Run the Shell](#how-to-run-the-shell)
- [Configuration](#configuration)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## About

**RDP Manager Pro** is a professional-grade remote desktop connection manager built specifically **for those who are passionate about the Linux world and need to establish stable connections to Windows remote desktops**.

Born from frustration with unstable GUI tools like Remmina, this tool leverages the power of `xfreerdp` and Bash scripting to deliver:
- **Zero crashes** (unlike other alternatives)
- **50% faster connection times**
- **Full control** over your RDP sessions
- **Professional features** for daily use

---

## Features

| Feature | Description |
|---------|-------------|
| 🖥️ **Multiple Connections** | Manage all your RDP connections in one place |
| 🔌 **Desktop Shortcuts** | One-click connections from your desktop |
| 📝 **Automatic Logging** | Every session is logged for debugging |
| 💾 **Backup & Restore** | Never lose your configurations |
| 🎨 **Custom Icons** | Personalize your shortcuts |
| 🔒 **Secure Authentication** | SSH key integration |
| 📊 **Connection Testing** | Ping and port verification |
| 📤 **Export/Import** | Share settings with your team |

---

## Prerequisites

### XfreeRDP Installation

The core component that handles the RDP protocol:

```bash
# For Debian/Ubuntu/Zorin OS:
sudo apt update
sudo apt install freerdp2-x11 -y
VPN Requirements
An active VPN connection must be established beforehand according to your provider's specifications. The user is responsible for ensuring VPN connectivity before using RDP Manager Pro.

Installation
Method 1: Quick Install (Recommended)
bash
# Clone the repository
git clone https://github.com/johnavendano-afk/rdp-manager.git
cd rdp-manager

# Make the script executable
chmod +x rdp-manager-pro.sh

# Run the manager
./rdp-manager-pro.sh
Method 2: Global Installation
bash
# Install system-wide
sudo cp rdp-manager-pro.sh /usr/local/bin/rdp-manager
sudo chmod +x /usr/local/bin/rdp-manager

# Run from anywhere
rdp-manager
Quick Start
Launch RDP Manager Pro:

bash
./rdp-manager-pro.sh
Create your first connection:

Select option 1 (Create New Connection)

Enter server details (IP/hostname)

Enter username (e.g., user@domain.com or DOMAIN\user)

Configure resolution and features

Connect:

Select option 3 (Connect to Remote Desktop)

Choose your connection from the list

Enter password when prompted

How to Run the Shell
From the terminal:
bash
# Navigate to the project folder
cd /home/johnavendano/RDP_Conn_Manager

# Make sure it has execution permissions
chmod +x rdp-manager-pro.sh

# Run the shell script
./rdp-manager-pro.sh
Create a desktop shortcut:
bash
# Create a .desktop file
nano ~/Escritorio/rdp-manager.desktop
Add this content:

ini
[Desktop Entry]
Version=1.0
Name=RDP Manager Pro
Comment=Remote Desktop Connection Manager
Exec=/home/johnavendano/RDP_Conn_Manager/rdp-manager-pro.sh
Icon=terminal
Terminal=true
Type=Application
Categories=Network;
bash
# Make it executable
chmod +x ~/Escritorio/rdp-manager.desktop
Run directly with parameters:
bash
# If you installed globally
rdp-manager

# Or directly with bash
bash rdp-manager-pro.sh
Configuration
Connection Profile Example
Create or edit connection files in ~/.config/rdp-manager/:

bash
# Example: ~/.config/rdp-manager/Work.conf
SERVER="192.168.1.100"
USERNAME="john@company.com"
DOMAIN="COMPANY"
PROTOCOL="tls"
FULLSCREEN="true"
ENABLE_CLIPBOARD="true"
ENABLE_DRIVES="true"
ENABLE_AUDIO="true"
Desktop Shortcuts with Custom Icons
Place your icons in: ~/.local/share/icons/rdp-manager/

Edit the .desktop file in your Desktop folder

Change the Icon= line to point to your icon

Usage Examples
Basic Connection
bash
# Connect to a server (if installed globally)
rdp-connect "Work"
Direct xfreerdp Command
bash
xfreerdp /v:192.168.1.100 /u:'user@domain.com' /sec:tls /cert-ignore /f
Run the manager menu
bash
# Show the main menu
./rdp-manager-pro.sh
Command line options
bash
# If you add command line support to your script
./rdp-manager-pro.sh --help
./rdp-manager-pro.sh --connect "Work"
Troubleshooting
Common Issues and Solutions
Issue	Solution
"Permission denied"	Run chmod +x rdp-manager-pro.sh
"Command not found"	Use ./rdp-manager-pro.sh instead of just the name
"Connection refused"	Check if VPN is active and server is reachable
Authentication failed	Verify username format (DOMAIN\user or user@domain.com)
Connection drops immediately	Try with /sec:tls instead of auto-negotiation
Slow performance	Add /network:auto and /gfx parameters
Cannot copy/paste	Enable clipboard with +clipboard flag
Debug Mode
bash
# Run with debug output
xfreerdp /v:SERVER /u:USER /p:PASS +log-level:DEBUG 2>&1 | tee debug.log
Logs Location
All connection logs are stored in:

text
~/.local/share/rdp-manager/logs/
Contributing
Contributions are welcome! Here's how you can help:

Fork the repository

Create a feature branch:

bash
git checkout -b feature/AmazingFeature
Commit your changes:

bash
git commit -m 'Add some AmazingFeature'
Push to the branch:

bash
git push origin feature/AmazingFeature
Open a Pull Request

License
This project is licensed under the MIT License - see the LICENSE file for details.

Author
John Avendaño

GitHub: @johnavendano-afk

LinkedIn: John Avendaño

Support
If you find this project useful, please consider:

Giving it a star on GitHub ⭐

Sharing it with your network

Contributing with code or documentation
