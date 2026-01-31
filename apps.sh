#!/bin/bash

# Enable multilib if it's not already enabled
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo "Enabling multilib repository..."
    echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy
fi

# --- Application Manifest ---
MY_PACKAGES=(
   "7zip" "proton-vpn-gtk-app" "discord" "spotify-launcher" "fcitx5" "fcitx5-configtool" "fcitx5-mozc" "fzf" "nautilus" "noto-fonts" "noto-fonts-cjk" "qt6ct" "vlc" "mpv" "qbittorrent" 
)

MY_AUR_PACKAGES=(
    "anki-bin"
    
    # Add more here (e.g., "visual-studio-code-bin")
)

echo "--- Starting Application Installation ---"

# Install Official Packages
sudo pacman -S --noconfirm "${MY_PACKAGES[@]}"

# Install AUR Packages (Assumes yay is already installed)
if command -v yay &> /dev/null; then
    if [ ${#MY_AUR_PACKAGES[@]} -gt 0 ]; then
        yay -S --noconfirm "${MY_AUR_PACKAGES[@]}"
    fi
else
    echo "Warning: yay not found. Skipping AUR packages."
fi

echo "--- Application Installation Complete ---"
