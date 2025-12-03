#!/bin/bash

clear

# Colors
RED='\033[1;31m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Banner
echo -e "${CYAN}"
cat << "EOF"
  /$$$$$$  /$$      /$$          
 /$$__  $$| $$$    /$$$          
| $$  \__/| $$$$  /$$$$ /$$   /$$
|  $$$$$$ | $$ $$/$$ $$|  $$ /$$/
 \____  $$| $$  $$$| $$ \  $$$$/ 
 /$$  \ $$| $$\  $ | $$  >$$  $$ 
|  $$$$$$/| $$ \/  | $$ /$$/\  $$ 
 \______/ |__/     |__/|__/  \__/

----------------------------------
   MADE BY @its_sadaf_offacail
----------------------------------
EOF
# Confirmation prompt
read -p "Do you want to continue? (y/n): " choice
case "$choice" in
    y|Y ) echo "Starting installation...";;
    n|N ) echo "Installation cancelled."; exit 1;;
    * ) echo "Invalid choice. Exiting."; exit 1;;
esac

# Check root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo ./banner.sh"
    exit 1
fi

# Function: Loading animation
loading() {
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    echo -n "Processing "
    while kill -0 $pid 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\b${spinstr:$i:1}"
            sleep $delay
        done
    done
    echo -e "\b Done!"
}

# Update & upgrade
apt update && apt upgrade -y &
loading $!

# Install dependencies
apt install -y git unzip npm &
loading $!

# Clone project
git clone https://github.com/itsnaruto045-hub/HVMX.git &
loading $!

cd HVMX || exit

# Unzip panel design
unzip -o xxx.zip &
loading $!

# Node dependencies
npm install &
loading $!

# Build Next.js app
npm run build &
loading $!

# Start the panel
npm start
