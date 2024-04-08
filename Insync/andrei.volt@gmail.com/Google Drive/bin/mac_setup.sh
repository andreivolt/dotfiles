#!/usr/bin/env bash

disable-auto-brightness() {
  sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor -bool false
}

disable-boot-sound() {
  sudo nvram SystemAudioVolume=%80
}

enable-boot-sound() {
  sudo nvram -d SystemAudioVolume
}

osascript -e 'tell application "System Events" to delete login item "Steam"'

enable-scroll-to-expose-app() {
  defaults write com.apple.dock "scroll-to-open" -bool "true" && killall Dock
}

show-full-url-in-safari() {
  defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true" && killall Safari
}

set-finder-sidebar-icon-size-large() {
  defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "3" && killall Finder
}

open-application-when-dragging-files-over-dock-icon() {
  defaults write com.apple.dock "enable-spring-load-actions-on-all-items" -bool "false" && killall Dock
}

enable-dragging-with-draglock() {
  defaults write com.apple.AppleMultitouchTrackpad "DragLock" -bool "true"
}

enable-full-keyboard-access-for-controls() {
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
}

map-caps-lock-to-escape() {
  hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'
}

automatically-dim-keyboard-backlight() {
  defaults write com.apple.BezelServices kDimTime -int 5
}

ln -fs ~/Google\ Drive/My\ Drive drive
ln -fs ~/drive/bin ~/bin

defaultbrowser thorium

black-wallpaper() {
  osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
}

enable-sshd() {
  sudo /usr/bin/sed -i '' \
      -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
      -e 's/#KbdInteractiveAuthentication yes/KbdInteractiveAuthentication no/' \
      /etc/ssh/sshd_config

  sudo systemsetup -setremotelogin on
}
