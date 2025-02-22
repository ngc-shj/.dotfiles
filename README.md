# .dotfiles

This repository is for managing personal development environment configuration files (dotfiles). These configuration files include settings for various tools and applications.

## Directory Structure

- `stow/xdg_config/bash/profile.d/`: Bash profile configuration files
- Other configuration files and directories

## Installation

To create symbolic links of the repository contents in your home directory, use GNU Stow.

```bash
cd ~
git clone https://github.com/ngc-shj/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

zsh ~/.dotfiles/scripts/setup.zsh
```

## License

The contents of this repository are provided under the MITaaa License, unless otherwise noted.

