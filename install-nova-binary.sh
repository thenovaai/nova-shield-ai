#!/bin/bash
set -euo pipefail

# Nova Shield - Super Simple Binary Installer for Everyone
# Usage: curl -fsSL https://raw.githubusercontent.com/thenovaai/nova-shield-ai/main/install-nova-binary.sh | bash

INSTALL_DIR="$HOME/.nova-shield"
BINARY_DIR="$HOME/.local/bin"
NOVA_BINARY="$BINARY_DIR/nova"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "🛡️ Installing Nova Shield - AI Cybersecurity Expert"
echo "=================================================="
echo ""

# Detect OS and architecture
detect_platform() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)
    
    case $ARCH in
        x86_64) ARCH="x86_64" ;;
        aarch64|arm64) ARCH="aarch64" ;;
        *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    
    case $OS in
        darwin) OS="apple-darwin" ;;
        linux) OS="unknown-linux-gnu" ;;
        *) echo "❌ Unsupported OS: $OS"; exit 1 ;;
    esac
    
    echo "${ARCH}-${OS}"
}

# Clean installation
cleanup() {
    echo "🧹 Cleaning previous installations..."
    pkill -f 'nova|codex' 2>/dev/null || true
    
    # Force remove the installation directory
    if [ -d "$INSTALL_DIR" ]; then
        echo "🗑️  Removing existing Nova Shield directory..."
        rm -rf "$INSTALL_DIR"
    fi
    
    echo "✅ Cleanup complete"
}

# Configure PATH automatically
configure_path() {
    echo "🔧 Configuring PATH automatically..."
    
    # Create binary directory
    mkdir -p "$BINARY_DIR"
    
    # Determine shell configuration file
    SHELL_CONFIG=""
    if [[ -n "$ZSH_VERSION" ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [[ -n "$BASH_VERSION" ]]; then
        SHELL_CONFIG="$HOME/.bashrc"
        if [[ ! -f "$SHELL_CONFIG" ]]; then
            SHELL_CONFIG="$HOME/.bash_profile"
        fi
    else
        SHELL_CONFIG="$HOME/.profile"
    fi
    
    # Create shell config if it doesn't exist
    if [[ ! -f "$SHELL_CONFIG" ]]; then
        touch "$SHELL_CONFIG"
    fi
    
    # Add PATH if not already present
    if ! grep -q "$BINARY_DIR" "$SHELL_CONFIG" 2>/dev/null; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Nova Shield PATH" >> "$SHELL_CONFIG"
        echo "export PATH=\"\$PATH:$BINARY_DIR\"" >> "$SHELL_CONFIG"
        echo "✅ Added Nova Shield to PATH in $SHELL_CONFIG"
    else
        echo "✅ Nova Shield PATH already configured"
    fi
    
    # Add to current session PATH
    export PATH="$PATH:$BINARY_DIR"
    echo "✅ PATH updated for current session"
}

# Download binary
download_binary() {
    PLATFORM=$(detect_platform)
    BINARY_NAME="nova-${PLATFORM}"
    DOWNLOAD_URL="https://github.com/thenovaai/nova-shield-ai/releases/latest/download/${BINARY_NAME}"
    
    echo "📥 Downloading Nova Shield binary for ${PLATFORM}..."
    echo "🔗 URL: $DOWNLOAD_URL"
    
    # Create directories
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$BINARY_DIR"
    
    # Download binary to temp location first
    TEMP_BINARY="/tmp/nova-${PLATFORM}"
    
    if curl -fsSL -o "$TEMP_BINARY" "$DOWNLOAD_URL"; then
        # Move to final location
        mv "$TEMP_BINARY" "$NOVA_BINARY"
        chmod +x "$NOVA_BINARY"
        echo "✅ Binary downloaded successfully"
        return 0
    else
        echo "❌ Failed to download binary"
        echo ""
        echo "🔄 No pre-built binary available for ${PLATFORM}"
        echo "💡 Try the full installer: curl -fsSL https://raw.githubusercontent.com/thenovaai/nova-shield-ai/main/install-nova.sh | bash"
        return 1
    fi
}

# Verify installation
verify() {
    echo "🧪 Verifying installation..."
    
    # Add to PATH for verification
    export PATH="$PATH:$BINARY_DIR"
    
    if command -v nova &> /dev/null; then
        echo "✅ Nova command available"
        echo "📍 Location: $(which nova)"
        
        # Test if nova works
        echo "🧪 Testing Nova command..."
        if nova --help &> /dev/null; then
            echo "✅ Nova command working correctly"
        else
            echo "❌ Nova command has issues"
            exit 1
        fi
    else
        echo "❌ Installation failed - nova command not found"
        echo ""
        echo "📝 Manual steps to complete installation:"
        echo "   export PATH=\"\$PATH:$BINARY_DIR\""
        echo "   nova --help"
        echo ""
        echo "Or restart your terminal and try again."
        exit 1
    fi
}

# Main flow
main() {
    echo "🚀 Starting Nova Shield binary installation..."
    echo "🎯 This installer downloads pre-compiled binaries"
    echo "📦 No Node.js, Rust, or other dependencies required!"
    echo ""
    
    # Clean up any existing installation first
    cleanup
    
    # Download binary
    if ! download_binary; then
        echo ""
        echo "❌ Binary installation failed"
        echo "💡 Try the full installer instead:"
        echo "   curl -fsSL https://raw.githubusercontent.com/thenovaai/nova-shield-ai/main/install-nova.sh | bash"
        exit 1
    fi
    
    # Configure PATH
    configure_path
    
    # Verify installation
    verify
    
    echo ""
    echo "🎉 Nova Shield Ready!"
    echo "==================="
    echo ""
    echo "🛡️ Your AI cybersecurity expert is ready!"
    echo ""
    echo "Quick start:"
    echo "  nova                # Start Nova Shield"
    echo "  nova --help         # Show help"
    echo ""
    echo "🔥 Get started: nova"
    echo ""
    echo "💡 Installation completed automatically!"
    echo "🔄 Restart your terminal or run: source ~/.zshrc (or ~/.bashrc)"
    echo ""
    echo "📦 This was a binary installation - no compilation required!"
}

main "$@"
