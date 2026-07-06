#!/usr/bin/env bash

# Get the directory where this install script is located
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin/trasher-bash"
BASHRC="$HOME/.bashrc"

echo "Creating installation directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

echo "Locating and copying scripts automatically..."
# Dynamically find the scripts anywhere inside the repo folder and copy them to TARGET_DIR
for script in trasher-view trasher-remove trasher-recover; do
    found_path=$(find "$REPO_DIR" -type f -name "$script" -print -quit)
    if [ -n "$found_path" ]; then
        cp "$found_path" "$TARGET_DIR/"
        echo "Copied $script"
    else
        echo "Error: Could not find $script inside $REPO_DIR"
    fi
done

echo "Granting execution permissions (chmod +x)..."
chmod +x "$TARGET_DIR"/* 2>/dev/null

echo "Injecting aliases into ~/.bashrc..."
if ! grep -q "Custom Trasher Suite Aliases" "$BASHRC"; then
    cat << 'EOF' >> "$BASHRC"

# Custom Trasher Suite Aliases
alias trasher-view="$HOME/.local/bin/trasher-bash/trasher-view"
alias trasher-remove="$HOME/.local/bin/trasher-bash/trasher-remove"
alias trasher-recover="$HOME/.local/bin/trasher-bash/trasher-recover"
EOF
    echo "Aliases added successfully to ~/.bashrc"
else
    echo "Aliases already detected in ~/.bashrc, skipping injection."
fi

echo ""
echo "✨nstallation complete!"
echo "Run this last command to activate the changes in your current terminal window:"
echo "   source ~/.bashrc"
