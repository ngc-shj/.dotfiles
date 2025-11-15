# Dotfiles

A comprehensive dotfiles setup for managing development environment configurations across multiple platforms (macOS, Linux, WSL). This repository includes configurations for shells (Zsh, Bash), editors (Neovim), terminal multiplexers (tmux), and various development tools.

## Features

- Cross-platform support (macOS, Linux, WSL)
- XDG Base Directory specification compliant
- Modular configuration structure
- Automated setup scripts
- Package management via Homebrew
- Stow-based dotfile management

### Tools & Applications

- **Shell**: 
  - Zsh (primary)
  - Bash (fallback)
  - Custom prompt using Purification theme
  - Extensive shell completion configuration

- **Development Tools**:
  - Neovim with Solarized theme
  - tmux
  - Git (with platform-specific configurations)
  - Various programming language environments (Go, Python, Ruby, Java, etc.)

- **Package Management**:
  - Homebrew for both CLI and GUI applications
  - Separate Brewfiles for different categories:
    - Core utilities
    - CLI development tools
    - GUI applications
    - General applications

## Quick Start

```bash
# Clone the repository
git clone https://github.com/ngc-shj/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# (Optional) Create a feature branch for customizations
git checkout -b feature/my-customizations

# Run the setup script - automatically detects macOS/Linux/WSL
zsh scripts/setup.zsh
```

The setup script will:
- Detect your operating system automatically
- Install Homebrew if not present (macOS/Linux/WSL)
- Install packages from categorized Brewfiles
- Deploy dotfiles using GNU Stow
- Configure shell environment, Git, Neovim, and other tools

**Note**: If `stow` is not installed, the setup script will install it via Homebrew.

## Directory Structure

```
.dotfiles/
├── brewfiles/          # Homebrew bundle files
├── scripts/           # Setup and installation scripts
│   ├── common/       # Cross-platform scripts
│   ├── macos/        # macOS specific scripts
│   └── wsl/          # WSL specific scripts
└── stow/             # Stowable configuration files
    ├── bash/         # Bash configuration
    ├── home/         # Home directory files
    └── xdg_config/   # XDG compliant configurations
        ├── bash/     # Bash additional configs
        ├── git/      # Git configuration
        ├── nvim/     # Neovim configuration
        ├── tmux/     # tmux configuration
        └── zsh/      # Zsh configuration
```

## Configuration Details

### Zsh Configuration
- Uses XDG Base Directory specification
- Modular configuration with separate files for:
  - Environment variables
  - Aliases
  - Completion
  - Key bindings
  - History settings
  - Platform-specific settings

### Neovim Configuration
- Solarized color scheme
- Vim-plug for plugin management
- Custom key mappings and settings

### Git Configuration
- Platform-specific configurations
- Multiple account support
- Includes configurations for:
  - GitHub
  - Hugging Face

### SSH Configuration
- Organized configuration structure
- Support for multiple environments
- Includes configurations for:
  - Local networks
  - Remote servers
  - Port forwarding

### WSL-specific Features
- SSH agent forwarding setup
- Windows interop configurations
- Custom path management

## Requirements

- Git
- Zsh
- GNU Stow
- Homebrew (will be installed by setup script if missing)

## OS Support

- macOS
- Linux
- Windows Subsystem for Linux (WSL)

## Troubleshooting

### Setup Script Issues

**Problem**: `stow` command not found during setup
```bash
# Solution: Install stow manually first
brew install stow
```

**Problem**: Permission denied errors
```bash
# Solution: Ensure you have write permissions to ~ and ~/.config
ls -la ~ ~/.config
```

### Shell Configuration Issues

**Problem**: Changes not taking effect
```bash
# Solution: Reload shell configuration
source ~/.zshenv  # or restart your terminal
```

**Problem**: PATH not set correctly in GUI applications (macOS)
- This is expected - GUI apps launched from Finder use login shell
- The env.d/ structure ensures PATH is available in all contexts
- If issues persist, try: `killall Dock` to restart GUI

### WSL-Specific Issues

**Problem**: SSH agent forwarding not working
```bash
# Check if npiperelay is properly configured
ls -la ~/.ssh/agent.sock
# Re-run WSL setup if needed
zsh ~/.dotfiles/scripts/wsl/npiperelay-setup.sh
```

**Problem**: Windows paths not accessible
- Ensure WSL interop is enabled: `/proc/sys/fs/binfmt_misc/WSLInterop`
- Check `wsl.conf` settings

### Platform Detection

**Problem**: Wrong platform detected
```bash
# Check detection logic
echo $OSTYPE
cat /proc/version  # Linux/WSL only
# Manually run platform-specific setup if needed
zsh ~/.dotfiles/scripts/macos/dev-gui-setup.sh  # macOS example
```

For more help, please [open an issue](https://github.com/ngc-shj/.dotfiles/issues).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
