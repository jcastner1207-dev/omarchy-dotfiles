#!/bin/bash
# Omarchy terminal launcher wrapper - launches tmux on Super+Return (no command)

if [ -z "$*" ]; then
    # No command - launch tmux first
    if ! command -v tmux &>/dev/null; then
        echo "Error: tmux is not installed. Please install it." >&2
        exit 1
    fi
    
    # Create new session or attach to existing one named 'work'
    if ! tmux has-session -t work 2>/dev/null; then
        tmux new-session -d -s work "Omarchy Terminal"
    fi
    tmux attach -t work
    exit 0
fi

# Command provided - run it directly in terminal
exec xdg-terminal-exec "$@"
