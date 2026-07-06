#!/usr/bin/env bash

# Get the directory where this install script is located
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin/trasher-bash"
BASHRC="$HOME/.bashrc"

echo "Creating installation directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# Dynamically find the scripts anywhere inside the repo folder and copy them to TARGET_DIR
for script in trasher-view trasher-remove trasher-recover; do
    echo "Searching for $script"
    found_path=$(find "$REPO_DIR" -type f -name "$script" -print -quit)
    
    if [ -n "$found_path" ]; then
        echo "Source: $found_path"
        cp "$found_path" "$TARGET_DIR/"
        echo "Target: $TARGET_DIR/$script"
    else
        echo "Error: Could not find $script anywhere inside $REPO_DIR"
    fi
done

echo "Granting execution permissions for $script"
chmod +x "$TARGET_DIR"/* 2>/dev/null

echo "Injecting aliases into ~/.bashrc..."
if ! grep -q "Custom Trasher Suite Aliases" "$BASHRC"; then
    cat << 'EOF' >> "$BASHRC"

# Custom Trasher Suite Aliases
alias trasher-view="$HOME/.local/bin/trasher-bash/trasher-view"
alias trasher-remove="$HOME/.local/bin/trasher-bash/trasher-remove"
alias trasher-recover="$HOME/.local/bin/trasher-bash/trasher-recover"
EOF
    echo "Trasher aliases applied to ~/.bashrc"
else
    echo "Trasher aliases already detected in ~/.bashrc, skipping injection."
fi

echo ""
echo "Trasher installation complete"
echo "Run this last command to activate the changes in your current terminal window:"
echo "source ~/.bashrc"
