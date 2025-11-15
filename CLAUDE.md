# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Installation Commands

### Initial Setup
```bash
# Clone and run full setup
git clone https://github.com/ngc-shj/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
zsh scripts/setup.zsh
```

### Manual Stow Deployment
```bash
cd ~/.dotfiles/stow
stow -t ~ home
stow -t ~/.config xdg_config
```

### Package Management
```bash
# Install category-specific packages
brew bundle --file=brewfiles/core
brew bundle --file=brewfiles/dev-cli
brew bundle --file=brewfiles/dev-gui
brew bundle --file=brewfiles/applications
```

## Architecture Overview

This is a **cross-platform dotfiles repository** supporting macOS, Linux, and WSL with the following architectural principles:

### Core Design Patterns
- **XDG Base Directory compliance**: Configurations stored in `~/.config` rather than cluttering `~`
- **Stow-based management**: Uses GNU Stow for symlink deployment with two targets:
  - `stow/home/*` → `~/*` (home directory files)
  - `stow/xdg_config/*` → `~/.config/*` (XDG compliant configs)
- **Modular shell configuration**: Separated into `profile.d/` and `rc.d/` directories for maintainability
- **Platform detection**: Automatic OS detection with platform-specific configurations

### Directory Structure
```
scripts/
├── setup.zsh              # Main orchestration script
├── common/                # Cross-platform setup scripts
└── {macos,wsl}/          # Platform-specific scripts

brewfiles/                 # Package definitions by category
├── core                  # Essential utilities (zsh, stow, git)
├── dev-cli              # Development CLI tools
├── dev-gui              # Development GUI applications
└── applications         # General applications

stow/
├── home/                # Files deployed to ~
├── bash/                # Bash shell configurations
└── xdg_config/          # Files deployed to ~/.config
    ├── bash/            # Modular bash configs (profile.d, rc.d)
    ├── git/             # Git with multi-account support
    ├── nvim/            # Neovim configuration
    ├── npm/             # NPM configuration
    ├── tmux/            # tmux configuration
    └── zsh/             # Comprehensive Zsh setup
```

## Key Configuration Features

### Shell Environment (Zsh Primary, Bash Fallback)
- **Modular structure**: Environment variables, aliases, completions separated into logical files
- **Cross-shell compatibility**: Shared configurations between Zsh and Bash via `profile.d/` and `rc.d/`
- **Platform detection**: OS-specific PATH management and tool configurations
- **XDG compliance**: Uses `$XDG_CONFIG_HOME` and `$XDG_DATA_HOME`

### Git Multi-Account Setup
- **Conditional includes**: Uses `includeIf` for different Git remotes (GitHub, Hugging Face)
- **Platform-specific configs**: Different settings per OS
- **Integration with ghq**: Repository management tool for Go-style workspace organization

### Development Environment
- **Language toolchains**: Go, Python, Ruby, Java, Node.js with version managers
- **AWS development**: Comprehensive AWS CLI and tooling setup
- **Container development**: Docker CLI and Desktop support
- **AI/ML tools**: Recent additions include Amazon Q and LM Studio

## Platform-Specific Considerations

### macOS
- Homebrew as primary package manager
- Platform-specific PATH additions
- GUI application management

### WSL (Windows Subsystem for Linux)
- SSH agent forwarding configuration
- Windows interop settings
- Custom path management for Windows/Linux boundary

### Linux
- Distribution detection (RHEL, Ubuntu)
- Alternative package managers where needed

## Development Workflow

When modifying configurations:
1. Edit files in `stow/` directories
2. Test changes by re-running stow deployment
3. Platform-specific changes go in respective `scripts/{platform}/` directories
4. Package additions should be categorized in appropriate `brewfiles/` file

## Security Notes
- SSH configurations are gitignored (structure exists but configs excluded)
- Credential files explicitly excluded via comprehensive `.gitignore`
- No sensitive information should be committed to this repository