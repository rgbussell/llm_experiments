#!/bin/bash
# Install LM Studio on Linux
set -e
# lm studio can dowload from the site, but I need to install libfuse dependency

LM_STUDIO_URL="https://installers.lmstudio.ai/linux/x64/0.3.18-3/LM-Studio-0.3.18-3-x64.AppImage"
LM_STUDIO_FILE=~/Downloads/LM-Studio-0.3.18-3-x64.AppImage
DESKTOP_ENTRY="/usr/share/applications/lmstudio.desktop"


echo "Installing LM Studio from $LM_STUDIO_URL to $LM_STUDIO_FILE"
echo "Expecting file to be downloaded to $LM_STUDIO_FILE"
echo "desktop entry will be created at $DESKTOP_ENTRY"

# Check if the script is run as root
#if [ "$(id -u)" -ne 0 ]; then
#    echo "This script must be run as root. Use sudo."
#    exit 1
#fi

# Install libfuse
if ! command -v fusermount &> /dev/null; then
    echo "Installing libfuse..."
    apt-get update
    apt-get install -y libfuse2
else
    echo "libfuse is already installed."
fi
# Download LM Studio


if [ ! -f "$LM_STUDIO_FILE" ]; then
    echo "Downloading LM Studio..."
    wget "$LM_STUDIO_URL" -O "$LM_STUDIO_FILE"
else
    echo "LM Studio file already exists."
fi

# Make the AppImage executable
chmod +x "$LM_STUDIO_FILE"

# Move the AppImage to /opt
if [ ! -d /opt/lmstudio ]; then
    echo "Creating directory /opt/lmstudio..."
    sudo mkdir -p /opt/lmstudio
fi
sudo mv "$LM_STUDIO_FILE" /opt/lmstudio/
sudo chmod +x /opt/lmstudio/$(basename "$LM_STUDIO_FILE")

# Create a symlink in /usr/local/bin
if [ ! -L /usr/local/bin/lmstudio ]; then
    echo "Creating symlink /usr/local/bin/lmstudio..."
    sudo ln -s /opt/lmstudio/$(basename "$LM_STUDIO_FILE") /usr/local/bin/lmstudio
    sudo chmod +x /usr/local/bin/lmstudio
else
    echo "Symlink /usr/local/bin/lmstudio already exists."
fi

# Notify the user
echo "LM Studio has been installed successfully."

# Clean up
#rm -f "$LM_STUDIO_FILE"

# Notify the user to run LM Studio
echo "You can now run LM Studio by typing 'lmstudio' in your terminal or by launching it from your applications menu."
# End of script