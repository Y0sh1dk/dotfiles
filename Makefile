.DEFAULT_GOAL := help


.PHONY: all
all: brew-install create-symlinks ## Do everything
	@echo "Done!"

########################################################################
#                                 Brew                                 #
########################################################################

.PHONY: brew-dump
brew-dump: ## Dump brew packages
	@brew bundle dump --force --file=$(HOME)/Brewfile

.PHONY: brew-install
brew-install: ## Install brew packages
	@brew bundle install --file=$(HOME)/Brewfile

########################################################################
#                               1Password                              #
########################################################################

.PHONY: onepassword
onepassword: ## Setup 1password ssh-agent
	@mkdir -p $(HOME)/.1password
	@ln -sf $(HOME)/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock $(HOME)/.1password/agent.sock

########################################################################
#                               symlinks                               #
########################################################################

.PHONY: create-symlinks
create-symlinks: ## Create symlinks
	@echo "Creating symlinks..."
	@ln -sf $(PWD)/.aliases $(HOME)/.aliases
	@ln -sf $(PWD)/.gitconfig $(HOME)/.gitconfig
	@ln -sf $(PWD)/.gitignore $(HOME)/.gitignore
	@ln -sf $(PWD)/.inputrc $(HOME)/.inputrc
	@ln -sf $(PWD)/.osx $(HOME)/.osx
	@ln -sf $(PWD)/.p10k.zsh $(HOME)/.p10k.zsh
	@ln -sf $(PWD)/.vimrc $(HOME)/.vimrc
	@ln -sf $(PWD)/.zlogin $(HOME)/.zlogin
	@ln -sf $(PWD)/.zshrc $(HOME)/.zshrc
	@ln -sf $(PWD)/Brewfile $(HOME)/Brewfile
	@ln -sf $(PWD)/Brewfile.lock.json $(HOME)/Brewfile.lock.json
	@ln -sf $(PWD)/com.googlecode.iterm2.plist $(HOME)/com.googlecode.iterm2.plist
	@ln -sf $(PWD)/wallpaper.jpg $(HOME)/wallpaper.jpg
	@ln -sf $(PWD)/.ssh/ $(HOME)
	@chmod 700 $(HOME)/.ssh
	@chmod 600 $(HOME)/.ssh/*

	@ln -sf $(PWD)/.vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	@ln -sf $(PWD)/.vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json
	@ln -sf $(PWD)/.vscode/snippets/ $(HOME)/Library/Application\ Support/Code/User
	@echo "Symlinks created!"

help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
