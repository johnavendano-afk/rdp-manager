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
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## 🎯 About

**RDP Manager Pro** is a professional-grade remote desktop connection manager built specifically **for those who are passionate about the Linux world and need to establish stable connections to Windows remote desktops**.

Born from frustration with unstable GUI tools like Remmina, this tool leverages the power of `xfreerdp` and Bash scripting to deliver:
- **Zero crashes** (unlike other alternatives)
- **50% faster connection times**
- **Full control** over your RDP sessions
- **Professional features** for daily use

---

## ✨ Features

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

## ⚙️ Prerequisites

### 🔧 XfreeRDP Installation and 🌐 VPN Requirements

The core component that handles the RDP protocol:

An active VPN connection must be established beforehand according to your provider's specifications.  The user is responsible for ensuring VPN connectivity before using RDP Manager Pro.

```bash
# For Debian/Ubuntu/Zorin OS:
sudo apt update
sudo apt install freerdp2-x11 -y
