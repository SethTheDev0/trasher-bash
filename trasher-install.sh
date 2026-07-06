#!/usr/bin/env bash

# Get the exact directory where this install script is located
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin/trasher-bash"
BASHRC="$HOME/.bashrc"

echo "Creating folder: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

echo "Copying scripts into place..."
cp "$REPO_DIR/trasher-view" "$REPO_DIR/trasher-remove" "$REPO_DIR/trasher-recover" "$TARGET_DIR/"

echo "Granting execution permissions (chmod +x)..."
chmod +x "$TARGET_DIR"/*

echo "Injecting aliases into ~/.bashrc..."
# Check if the aliases are already present to avoid duplicating them on multiple runs
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
echo "Installation complete!"
echo "Run this last command to activate the changes in your current terminal window:"
echo "source ~/.bashrc"
