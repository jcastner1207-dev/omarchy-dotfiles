#!/bin/bash

# Omarchy hook: Display notification when Hyprland reload succeeds/fails
# Called from: ~/.config/hypr/bindings.lua via Super+Shift+R

hyprctl reload 2>&1 | while IFS= read -r line; do
    case "$line" in
        ok*) 
            omarchy-notification-send "Hyprland" "Config reloaded successfully" &
            ;;
        error*|fail*|cannot*)
            omarchy-notification-send "Hyprland" "Failed to reload: $line" &
            ;;
    esac
done
