#!/bin/bash

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Updating and upgrading existing packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing essential dependencies: python3-pip, git..."
sudo apt install -y python3-pip git

echo "Checking and installing OWASP ZAP..."
if ! command_exists zaproxy; then
    sudo apt install -y zaproxy
fi

echo "Checking and installing mitmproxy2swagger..."
if ! command_exists mitmproxy2swagger; then
    sudo pip3 install mitmproxy2swagger
fi

echo "Checking and installing Git..."
if ! command_exists git; then
    sudo apt-get install -y git
fi

echo "Checking and installing Docker..."
if ! command_exists docker; then
    sudo apt-get install -y docker.io docker-compose
fi

echo "Checking and installing Go..."
if ! command_exists go; then
    sudo apt install -y golang-go
fi

echo "Installing The JSON Web Token Toolkit v2..."
sudo mkdir -p /opt
cd /opt
sudo git clone https://github.com/ticarpi/jwt_tool
cd jwt_tool
sudo python3 -m pip install termcolor cprint pycryptodomex requests

echo "Making an alias for jwt_tool.py..."
sudo chmod +x jwt_tool.py
sudo ln -s /opt/jwt_tool/jwt_tool.py /usr/bin/jwt_tool

echo "Installing Kiterunner..."
cd /opt
sudo git clone https://github.com/assetnote/kiterunner.git
cd kiterunner
sudo make build
sudo ln -s /opt/kiterunner/dist/kr /usr/bin/kr

echo "Installing Arjun..."
pip install arjun

echo "Installing Hacking-APIs..."
sudo wget -c https://github.com/hAPI-hacker/Hacking-APIs/archive/refs/heads/main.zip -O HackingAPIs.zip \
&& sudo unzip HackingAPIs.zip \
&& sudo rm -f HackingAPIs.zip

echo "Installation completed successfully!"
