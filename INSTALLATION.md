# Nova Shield Installation Guide

## 🚀 Two Installation Methods

Nova Shield offers two installation methods to suit different user needs:

### 🎯 **Method 1: Binary Installer (Recommended for Non-Developers)**

**Perfect for users who want a quick, simple installation with zero dependencies.**

```bash
curl -fsSL https://raw.githubusercontent.com/thenovaai/nova-shield-ai/main/install-nova-binary.sh | bash
```

**✨ Benefits:**
- **Zero Dependencies** - No Node.js, Rust, or other tools needed
- **Lightning Fast** - Downloads pre-built binary (seconds)
- **Works for Everyone** - No technical knowledge required
- **Automatic PATH Setup** - No manual configuration needed

**🎯 Best for:**
- Non-developers
- Quick testing
- Production environments
- Users who want simplicity

### 🔧 **Method 2: Full Installer (For Developers)**

**For developers who want to build from source or need the full development environment.**

```bash
curl -fsSL https://raw.githubusercontent.com/thenovaai/nova-shield-ai/main/install-nova.sh | bash
```

**✨ Benefits:**
- **Full Development Setup** - Includes Node.js, Rust, and build tools
- **Source Build** - Compiles from source code
- **Development Ready** - Perfect for contributors and developers
- **Latest Features** - Always gets the most recent code

**🎯 Best for:**
- Developers
- Contributors
- Users who want to modify the code
- Development environments

## 📦 Binary Releases

We provide pre-compiled binaries for easy installation:

### Supported Platforms:
- **macOS (Intel):** `nova-x86_64-apple-darwin`
- **macOS (Apple Silicon):** `nova-aarch64-apple-darwin`
- **Linux (x86_64):** `nova-x86_64-unknown-linux-gnu`
- **Linux (ARM64):** `nova-aarch64-unknown-linux-gnu`

### Download Locations:
- **GitHub Releases:** https://github.com/thenovaai/nova-shield-ai/releases
- **Binary Installer:** Automatically downloads the correct binary for your platform

## 🎯 Quick Start

After installation:

```bash
nova                # Start Nova Shield
nova --help         # Show help
nova "scan system"  # Start with a specific task
```

## 🛠️ Troubleshooting

### Common Issues:

**"nova command not found"**
- Restart your terminal
- Run: `source ~/.zshrc` (or `~/.bashrc`)
- Check PATH: `echo $PATH`

**"Binary not available for platform"**
- Try the full installer instead
- Check if your platform is supported

### Support:
- **GitHub Issues:** https://github.com/thenovaai/nova-shield-ai/issues

## 🎉 Success!

Once installed, Nova Shield will be ready to help you with:
- 🔍 System security scanning
- 🦠 Malware detection
- 🛠️ Security hardening
- 💻 Code security review
- 🌐 Network monitoring

Happy securing! 🛡️
