# Y0sh1dk's Dotfiles

My dotfiles :)

Heavily inspired by: https://github.com/geerlingguy/dotfiles

## Files

The following files are included in this repository:

- `.aliases`: This file contains aliases for frequently used commands.

- `.functions`: This file contains functions

- `.gitconfig`: This file contains settings for the Git version control system, such as user name and email, aliases, and color output.

- `.inputrc`: The .inputrc file is a configuration file for the Readline library, used by various command-line interfaces, which allows users to customize keyboard shortcuts, input mappings, and command-line editing behavior.

- `.osx`: This file contains OSX configurations

- `.p10k.zsh`: This file contains p10k theme customisations.

- `.vimrc`: A vimrc is a configuration file used by the Vim text editor to customize its behavior and appearance.

- `.zlogin`: The .zlogin file is a shell script executed by the Zsh shell upon login, allowing users to set environment variables and run other initialization commands.

- `.zshrc`: The .zshrc file is a configuration file for the Zsh shell, which allows users to customize shell options, define aliases and functions, and set up key bindings and prompts.

- `com.googlecode.iterm2.plist`: The com.googlecode.iterm2.plist file is a preference file used by the iTerm2 terminal emulator on macOS to store user preferences, profiles, and other settings.

## Installation

To use these dotfiles, clone this repository to your home directory:

```
$ git clone https://github.com/Y0sh1dk/dotfiles.git ~/.dotfiles
```

Then, create symbolic links from the home directory to the dotfiles:

```
$ ln -s ~/.dotfiles/.aliases ~/.aliases
$ ln -s ~/.dotfiles/.functions ~/.functions
$ ln -s ~/.dotfiles/gitconfig ~/.gitconfig
$ ln -s ~/.dotfiles/.inputrc ~/.inputrc
$ ln -s ~/.dotfiles/.osx ~/.osx
$ ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
$ ln -s ~/.dotfiles/.vimrc ~/.vimrc
$ ln -s ~/.dotfiles/.zlogin ~/.zlogin
$ ln -s ~/.dotfiles/.zshrc ~/.zshrc
$ ln -s ~/.dotfiles/com.googlecode.iterm2.plist ~/com.googlecode.iterm2.plist
```

Restart your shell to apply the changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
