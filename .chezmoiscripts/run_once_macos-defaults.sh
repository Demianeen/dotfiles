#!/bin/bash
# macOS System Defaults - Migrated from nix-darwin

echo "Applying macOS defaults..."

# NSGlobalDomain
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.0
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 0

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock tilesize -int 56

# Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Restart affected apps
killall Dock
killall Finder

echo "macOS defaults applied!"
