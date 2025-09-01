#!/bin/bash

# Test cleanup function
INSTALL_DIR="$HOME/.nova-shield"

# Create test directory
mkdir -p "$INSTALL_DIR/test"

echo "Created test directory: $INSTALL_DIR"
ls -la "$INSTALL_DIR"

# Test cleanup function
cleanup() {
    echo "🧹 Cleaning previous installations..."
    pkill -f 'nova|codex' 2>/dev/null || true
    npm uninstall -g nova-shield 2>/dev/null || true
    
    # Force remove the installation directory
    if [ -d "$INSTALL_DIR" ]; then
        echo "🗑️  Removing existing Nova Shield directory..."
        rm -rf "$INSTALL_DIR"
    fi
    
    # Double-check and force remove if still exists
    if [ -d "$INSTALL_DIR" ]; then
        echo "🔧 Force removing directory..."
        sudo rm -rf "$INSTALL_DIR" 2>/dev/null || rm -rf "$INSTALL_DIR"
    fi
    
    echo "✅ Cleanup complete"
}

cleanup

echo "After cleanup:"
ls -la "$INSTALL_DIR" 2>/dev/null || echo "Directory removed successfully"

