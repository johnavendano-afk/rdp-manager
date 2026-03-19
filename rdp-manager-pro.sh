#!/bin/bash
# ============================================================================
# RDP MANAGER PRO - Professional Remote Desktop Connection Manager for Linux
# ============================================================================
# Author: John Avendaño & Community
# Version: 2.0
# License: MIT
# Description: A complete RDP connection manager using xfreerdp
# Compatible with: Zorin OS, Ubuntu, Linux Mint, Debian
# ============================================================================

# ---------------------------- CONFIGURATION --------------------------------
CONFIG_DIR="$HOME/.config/rdp-manager"
LOG_DIR="$HOME/.local/share/rdp-manager/logs"
ICON_DIR="$HOME/.local/share/icons/rdp-manager"
BACKUP_DIR="$HOME/.local/share/rdp-manager/backups"
mkdir -p "$CONFIG_DIR" "$LOG_DIR" "$ICON_DIR" "$BACKUP_DIR"

# Colors for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# ---------------------------- INITIAL SETUP ---------------------------------
setup_system() {
    echo -e "${CYAN}🔧 Setting up RDP Manager Pro...${NC}"
    
    # Install dependencies
    sudo apt update
    sudo apt install -y freerdp2-x11 netcat-openbsd zenity xclip
    
    # Create desktop entries directory if not exists
    mkdir -p "$HOME/.local/share/applications"
    
    # Install main command
    sudo tee /usr/local/bin/rdp-connect > /dev/null << 'EOF'
#!/bin/bash
# RDP Connect - Universal connection script
CONFIG_DIR="$HOME/.config/rdp-manager"
NAME="$1"

if [ -z "$NAME" ] || [ ! -f "$CONFIG_DIR/$NAME.conf" ]; then
    echo "❌ Error: Connection '$NAME' not found"
    echo "Available connections:"
    ls -1 "$CONFIG_DIR"/*.conf 2>/dev/null | sed 's/.*\///; s/\.conf//'
    exit 1
fi

source "$CONFIG_DIR/$NAME.conf"

# Build command
CMD="xfreerdp /v:$SERVER /u:'$USERNAME'"

if [ ! -z "$DOMAIN" ]; then
    CMD="$CMD /d:'$DOMAIN'"
fi

# Security protocol (default: TLS)
if [ -z "$PROTOCOL" ]; then
    PROTOCOL="tls"
fi
CMD="$CMD /sec:$PROTOCOL"

# Resolution
if [ "$FULLSCREEN" = "true" ]; then
    CMD="$CMD /f"
else
    CMD="$CMD /size:${WIDTH}x${HEIGHT}"
fi

# Additional features
CMD="$CMD /cert-ignore /dynamic-resolution /network:auto +fonts /floatbar /gdi:hw"

if [ "$ENABLE_CLIPBOARD" = "true" ]; then
    CMD="$CMD /clipboard"
fi

if [ "$ENABLE_DRIVES" = "true" ]; then
    CMD="$CMD /drive:home,$HOME"
fi

if [ "$ENABLE_AUDIO" = "true" ]; then
    CMD="$CMD /audio-mode:1"
fi

# Log file
LOG_FILE="$HOME/.local/share/rdp-manager/logs/$(date +%Y%m%d_%H%M%S)_$NAME.log"

# Execute
echo "🚀 Connecting to $NAME ($SERVER)..."
echo "📝 Log: $LOG_FILE"
eval "$CMD" 2>&1 | tee "$LOG_FILE"
EOF

    sudo chmod +x /usr/local/bin/rdp-connect
    echo -e "${GREEN}✅ Setup complete!${NC}"
}

# ---------------------------- CONNECTION MANAGEMENT ------------------------
create_connection() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║     CREATE NEW RDP CONNECTION          ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${YELLOW}📌 Connection Name:${NC} (e.g., Work, Server, Remote Desktop)"
    read -p "> " NAME
    NAME=$(echo "$NAME" | tr ' ' '_')
    
    echo -e "${YELLOW}🌐 Server Address:${NC} (IP or hostname)"
    read -p "> " SERVER
    
    echo -e "${YELLOW}👤 Username:${NC} (e.g., user@domain.com or DOMAIN\\user)"
    read -p "> " USERNAME
    
    echo -e "${YELLOW}🏢 Domain:${NC} (press Enter if none)"
    read -p "> " DOMAIN
    
    echo -e "${YELLOW}🔒 Security Protocol:${NC}"
    echo "   1) TLS (recommended)"
    echo "   2) NLA"
    echo "   3) Negotiate (auto)"
    echo "   4) RDP (legacy)"
    read -p "> " PROTO_OPT
    
    case $PROTO_OPT in
        1) PROTOCOL="tls" ;;
        2) PROTOCOL="nla" ;;
        3) PROTOCOL="negotiate" ;;
        4) PROTOCOL="rdp" ;;
        *) PROTOCOL="tls" ;;
    esac
    
    echo -e "${YELLOW}🖥️  Resolution:${NC}"
    echo "   1) Fullscreen (recommended)"
    echo "   2) 1920x1080"
    echo "   3) 1366x768"
    echo "   4) 1280x720"
    echo "   5) Custom"
    read -p "> " RES_OPT
    
    case $RES_OPT in
        1) FULLSCREEN="true"; WIDTH=""; HEIGHT="" ;;
        2) FULLSCREEN="false"; WIDTH="1920"; HEIGHT="1080" ;;
        3) FULLSCREEN="false"; WIDTH="1366"; HEIGHT="768" ;;
        4) FULLSCREEN="false"; WIDTH="1280"; HEIGHT="720" ;;
        5) 
            FULLSCREEN="false"
            read -p "   Width: " WIDTH
            read -p "   Height: " HEIGHT
            ;;
    esac
    
    echo -e "${YELLOW}📋 Enable features:${NC}"
    echo -e "   Clipboard? (y/n): \c"
    read -p "" CLIP
    [ "$CLIP" = "y" ] && ENABLE_CLIPBOARD="true" || ENABLE_CLIPBOARD="false"
    
    echo -e "   Drive sharing? (y/n): \c"
    read -p "" DRIVES
    [ "$DRIVES" = "y" ] && ENABLE_DRIVES="true" || ENABLE_DRIVES="false"
    
    echo -e "   Audio? (y/n): \c"
    read -p "" AUDIO
    [ "$AUDIO" = "y" ] && ENABLE_AUDIO="true" || ENABLE_AUDIO="false"
    
    # Save configuration
    cat > "$CONFIG_DIR/$NAME.conf" << EOF
# RDP Connection: $NAME
# Created: $(date)
# Server Configuration
SERVER="$SERVER"
USERNAME="$USERNAME"
DOMAIN="$DOMAIN"
PROTOCOL="$PROTOCOL"

# Display Settings
FULLSCREEN="$FULLSCREEN"
WIDTH="$WIDTH"
HEIGHT="$HEIGHT"

# Features
ENABLE_CLIPBOARD="$ENABLE_CLIPBOARD"
ENABLE_DRIVES="$ENABLE_DRIVES"
ENABLE_AUDIO="$ENABLE_AUDIO"
EOF
    
    echo -e "${GREEN}✅ Connection '$NAME' created successfully!${NC}"
    
    # Ask for desktop shortcut
    echo -e "${YELLOW}🖱️  Create desktop shortcut? (y/n):${NC}"
    read -p "> " SHORTCUT
    if [ "$SHORTCUT" = "y" ]; then
        create_shortcut "$NAME"
    fi
    
    sleep 2
}

list_connections() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        CONNECTIONS LIST                ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    if [ ! "$(ls -A $CONFIG_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}📭 No connections found. Create one first.${NC}"
    else
        printf "${WHITE}%-25s %-20s %-25s${NC}\n" "NAME" "SERVER" "USER"
        printf "${WHITE}%-25s %-20s %-25s${NC}\n" "----" "------" "----"
        
        for conf in "$CONFIG_DIR"/*.conf; do
            if [ -f "$conf" ]; then
                NAME=$(basename "$conf" .conf)
                source "$conf"
                printf "%-25s %-20s %-25s\n" "$NAME" "$SERVER" "$USERNAME"
            fi
        done
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

create_shortcut() {
    local NAME=$1
    
    if [ -z "$NAME" ]; then
        list_connections
        echo -e "${YELLOW}Enter connection name:${NC}"
        read NAME
    fi
    
    if [ ! -f "$CONFIG_DIR/$NAME.conf" ]; then
        echo -e "${RED}❌ Connection not found${NC}"
        sleep 2
        return
    fi
    
    # Create desktop shortcut
    cat > "$HOME/Escritorio/$NAME.desktop" << EOF
[Desktop Entry]
Version=1.0
Name=$NAME (RDP)
Comment=Connect to remote desktop
Exec=rdp-connect "$NAME"
Icon=$ICON_DIR/default.png
Terminal=true
Type=Application
Categories=Network;
StartupNotify=true
EOF
    
    chmod +x "$HOME/Escritorio/$NAME.desktop"
    
    # If default icon doesn't exist, create it
    if [ ! -f "$ICON_DIR/default.png" ]; then
        # Create a simple text file as placeholder
        echo "Place your icons in: $ICON_DIR" > "$ICON_DIR/README.txt"
    fi
    
    echo -e "${GREEN}✅ Shortcut created: ~/Escritorio/$NAME.desktop${NC}"
    echo -e "${YELLOW}💡 Tip: Change the icon by editing the 'Icon=' line in the file${NC}"
    sleep 2
}

connect() {
    clear
    list_connections
    
    if [ "$(ls -A $CONFIG_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}🔌 Enter connection name to connect:${NC}"
        read NAME
        
        if [ -f "$CONFIG_DIR/$NAME.conf" ]; then
            rdp-connect "$NAME"
        else
            echo -e "${RED}❌ Connection not found${NC}"
            sleep 2
        fi
    else
        sleep 2
    fi
}

backup_restore() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        BACKUP & RESTORE                ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo "1) Create backup"
    echo "2) Restore from backup"
    echo "3) Back to main menu"
    read -p "> " OPT
    
    case $OPT in
        1)
            BACKUP_FILE="$BACKUP_DIR/rdp_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
            tar -czf "$BACKUP_FILE" -C "$CONFIG_DIR" .
            echo -e "${GREEN}✅ Backup created: $BACKUP_FILE${NC}"
            ;;
        2)
            echo "Available backups:"
            ls -1 "$BACKUP_DIR"/*.tar.gz 2>/dev/null | sed 's/.*\///'
            if [ $? -eq 0 ]; then
                echo "Enter backup filename:"
                read FILE
                if [ -f "$BACKUP_DIR/$FILE" ]; then
                    tar -xzf "$BACKUP_DIR/$FILE" -C "$CONFIG_DIR"
                    echo -e "${GREEN}✅ Restore complete${NC}"
                fi
            fi
            ;;
    esac
    sleep 2
}

export_public() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        EXPORT FOR SHARING              ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    EXPORT_FILE="$HOME/rdp-connections-export.txt"
    
    cat > "$EXPORT_FILE" << EOF
# RDP Manager Pro - Connection Export
# Created: $(date)
# ============================================

EOF
    
    for conf in "$CONFIG_DIR"/*.conf; do
        if [ -f "$conf" ]; then
            cat "$conf" >> "$EXPORT_FILE"
            echo -e "\n# --------------------------------------------\n" >> "$EXPORT_FILE"
        fi
    done
    
    echo -e "${GREEN}✅ Export created: $EXPORT_FILE${NC}"
    echo -e "${YELLOW}📋 File contains connection details (passwords NOT included)${NC}"
    
    # Copy to clipboard if xclip is available
    if command -v xclip &> /dev/null; then
        cat "$EXPORT_FILE" | xclip -selection clipboard
        echo -e "${GREEN}📋 Copied to clipboard!${NC}"
    fi
    
    sleep 3
}

# ---------------------------- MAIN MENU ------------------------------------
main_menu() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║     RDP MANAGER PRO v2.0               ║${NC}"
    echo -e "${CYAN}║     Professional RDP Connection Mgr    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo -e "${WHITE}     Created by John Avendaño & Community${NC}"
    echo -e "${YELLOW}     https://github.com/johnavendano-afk/rdp-manager${NC}"
    echo ""
    echo -e "${GREEN}1)${NC} 🆕  Create New Connection"
    echo -e "${GREEN}2)${NC} 📋  List All Connections"
    echo -e "${GREEN}3)${NC} 🔌  Connect to Remote Desktop"
    echo -e "${GREEN}4)${NC} 🖱️   Create Desktop Shortcut"
    echo -e "${GREEN}5)${NC} 📤  Export Connections (for sharing)"
    echo -e "${GREEN}6)${NC} 💾  Backup/Restore"
    echo -e "${GREEN}7)${NC} 🔧  Setup/Reinstall"
    echo -e "${GREEN}8)${NC} 📚  View Logs"
    echo -e "${GREEN}9)${NC} ❌  Delete Connection"
    echo -e "${GREEN}0)${NC} 🚪  Exit"
    echo ""
    echo -e "${YELLOW}Select an option:${NC} "
}

view_logs() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║        CONNECTION LOGS                 ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    if [ ! "$(ls -A $LOG_DIR 2>/dev/null)" ]; then
        echo -e "${YELLOW}📭 No logs found.${NC}"
    else
        ls -lh "$LOG_DIR" | tail -n 20
        echo ""
        echo -e "${YELLOW}View specific log? (enter filename or 'q' to quit):${NC}"
        read LOG_FILE
        if [ "$LOG_FILE" != "q" ] && [ -f "$LOG_DIR/$LOG_FILE" ]; then
            less "$LOG_DIR/$LOG_FILE"
        fi
    fi
    read -p "Press Enter to continue..."
}

delete_connection() {
    list_connections
    
    if [ "$(ls -A $CONFIG_DIR 2>/dev/null)" ]; then
        echo -e "${RED}⚠️  Enter connection name to DELETE:${NC}"
        read NAME
        
        if [ -f "$CONFIG_DIR/$NAME.conf" ]; then
            echo -e "${RED}Are you sure? This cannot be undone! (y/n):${NC}"
            read CONFIRM
            if [ "$CONFIRM" = "y" ]; then
                rm "$CONFIG_DIR/$NAME.conf"
                rm "$HOME/Escritorio/$NAME.desktop" 2>/dev/null
                echo -e "${GREEN}✅ Connection deleted${NC}"
            fi
        else
            echo -e "${RED}❌ Connection not found${NC}"
        fi
    fi
    sleep 2
}

# ---------------------------- MAIN LOOP ------------------------------------
# Check if first run
if [ ! -f "$HOME/.config/rdp-manager/.installed" ]; then
    setup_system
    touch "$HOME/.config/rdp-manager/.installed"
fi

while true; do
    main_menu
    read OPTION
    
    case $OPTION in
        1) create_connection ;;
        2) list_connections ;;
        3) connect ;;
        4) create_shortcut ;;
        5) export_public ;;
        6) backup_restore ;;
        7) setup_system ;;
        8) view_logs ;;
        9) delete_connection ;;
        0) 
            echo -e "${GREEN}👋 Thanks for using RDP Manager Pro!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option${NC}"
            sleep 1
            ;;
    esac
done

