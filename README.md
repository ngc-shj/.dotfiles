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

## Installation

1. Clone the repository:
```bash
git clone https://github.com/ngc-shj/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the setup script:
```bash
zsh ~/.dotfiles/scripts/setup.zsh
```

The setup script will:
- Install Homebrew if not present
- Install required packages and applications
- Configure development tools
- Set up dotfiles using GNU Stow

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.# Dotfiles

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

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Run the setup script:
```bash
zsh ~/.dotfiles/scripts/setup.zsh
```

The setup script will:
- Install Homebrew if not present
- Install required packages and applications
- Configure development tools
- Set up dotfiles using GNU Stow

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
