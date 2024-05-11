.DEFAULT_GOAL := help


.PHONY: all
all: bootstrap homebrew shell vscode onepassword ssh osx git tools post ## Do everything
	@echo "Done!"

########################################################################
#                              Bootstrap                               #
########################################################################

.PHONY: bootstrap
bootstrap: bootstrap-xcode-tools bootstrap-rosetta ## Bootstrap
	@echo "Bootstrap done!"

.PHONY: bootstrap-xcode-tools
bootstrap-xcode-tools:
	@xcode-select --install || true

.PHONY: bootstrap-rosetta
bootstrap-rosetta:
	@if ! /usr/bin/pgrep -q oahd; then \
		echo "A" | /usr/sbin/softwareupdate --install-rosetta; \
	fi

########################################################################
#                               Homebrew                               #
########################################################################

.PHONY: homebrew
homebrew: homebrew-install homebrew-symlinks homebrew-bundle-install ## Setup homebrew
	@echo "Homebrew setup!"

.PHONY: homebrew-install
homebrew-install:
	@if [ $$(uname) = "Darwin" ] && [ "$(shell which brew)" = "" ]; then \
		NONINTERACTIVE=1 /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		(echo; echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"') >> $(HOME)/.zprofile; \
		echo "Installed Homebrew."; \
	fi

.PHONY: homebrew-symlinks
homebrew-symlinks:
	@ln -sf $(PWD)/Brewfile $(HOME)/Brewfile
	@ln -sf $(PWD)/Brewfile.lock.json $(HOME)/Brewfile.lock.json

.PHONY: homebrew-bundle-dump
homebrew-bundle-dump:
	@/opt/homebrew/bin/brew bundle dump --force --file=$(HOME)/Brewfile

.PHONY: homebrew-bundle-install
homebrew-bundle-install:
	@/opt/homebrew/bin/brew bundle install --file=$(HOME)/Brewfile

########################################################################
#                                 Shell                                #
########################################################################

.PHONY: shell
shell: shell-oh-my-zsh shell-oh-my-zsh-plugins shell-symlinks ## Setup shell
	@echo "Shell setup!"

.PHONY: shell-oh-my-zsh
shell-oh-my-zsh:
	@if [ ! -d $(HOME)/.oh-my-zsh ]; then \
		/bin/sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
	fi

.PHONY: shell-oh-my-zsh-plugins
shell-oh-my-zsh-plugins:
	@if [ ! -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then \
		git clone https://github.com/zsh-users/zsh-autosuggestions $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	else \
		cd $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git fetch && git pull; \
	fi
	@if [ ! -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then \
		git clone https://github.com/zsh-users/zsh-syntax-highlighting $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; \
	else \
		cd $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git fetch && git pull; \
	fi
	@if [ ! -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then \
		git clone https://github.com/zsh-users/zsh-history-substring-search $(HOME)/.oh-my-zsh/custom/plugins/zsh-history-substring-search; \
	else \
		cd $(HOME)/.oh-my-zsh/custom/plugins/zsh-history-substring-search && git fetch && git pull; \
	fi
	@if [ ! -d $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k ]; then \
		git clone https://github.com/romkatv/powerlevel10k $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k; \
	else \
		cd $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k && git fetch && git pull; \
	fi

.PHONY: shell-symlinks
shell-symlinks:
	@ln -sf $(PWD)/.zlogin $(HOME)/.zlogin
	@ln -sf $(PWD)/.zshrc $(HOME)/.zshrc
	@ln -sf $(PWD)/.p10k.zsh $(HOME)/.p10k.zsh
	@ln -sf $(PWD)/com.googlecode.iterm2.plist $(HOME)/com.googlecode.iterm2.plist
	@ln -sf $(PWD)/.inputrc $(HOME)/.inputrc
	@ln -sf $(PWD)/.aliases $(HOME)/.aliases
	@ln -sf $(PWD)/.gitignore $(HOME)/.gitignore

########################################################################
#                               1Password                              #
########################################################################

.PHONY: onepassword
onepassword: onepassword-symlinks ## Setup 1password ssh-agent
	@echo "onepassword setup!"

.PHONY: onepassword-symlinks
onepassword-symlinks:
	@mkdir -p $(HOME)/.1password
	@ln -sf $(HOME)/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock $(HOME)/.1password/agent.sock
########################################################################
#                                vscode                                #
########################################################################

.PHONY: vscode
vscode: ## Setup vscode
	@echo "vscode setup!"

.PHONY: vscode-symlinks
vscode-symlinks:
	@ln -sf $(shell pwd)/.vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	@ln -sf $(shell pwd)/.vscode/keybindings.json $(HOME)/Library/Application\ Support/Code/User/keybindings.json

########################################################################
#                                 ssh                                  #
########################################################################

.PHONY: ssh
ssh: ssh-symlinks ## Setup SSH
	@echo "SSH setup!"

.PHONY: ssh-symlinks
ssh-symlinks:
	@ln -sf $(PWD)/.ssh/ $(HOME)
	@chmod 700 $(HOME)/.ssh
	@chmod 600 $(HOME)/.ssh/*

########################################################################
#                                 osx                                  #
########################################################################

.PHONY: osx
osx: osx-symlinks osx-setup osx-dock ## Setup osx
	@echo "OSX setup!"

.PHONY: osx-symlinks
osx-symlinks:
	@ln -sf $(PWD)/.osx $(HOME)/.osx
	@ln -sf $(PWD)/wallpaper.jpg $(HOME)/wallpaper.jpg

.PHONY: osx-setup
osx-setup:
	@sudo $(HOME)/.osx

.PHONY: osx-dock
osx-dock:
	@/opt/homebrew/bin/dockutil --remove all

########################################################################
#                                 git                                  #
########################################################################

.PHONY: git
git: git-symlinks ## Setup git
	@echo "Git setup!"

.PHONY: git-symlinks
git-symlinks:
	@ln -sf $(PWD)/.gitconfig $(HOME)/.gitconfig

########################################################################
#                                 tools                                #
########################################################################

.PHONY: tools
tools: tools-symlinks ## Setup other tools
	@echo "Tools setup!"

.PHONY: tools-symlinks
tools-symlinks:
	@ln -sf $(PWD)/.vimrc $(HOME)/.vimrc

########################################################################
#                                 post                                 #
########################################################################

.PHONY: post
post: ## Post install tasks
	@git remote set-url origin git@github.com:y0sh1dk/dotfiles.git


########################################################################
#                                  help                                #
########################################################################

help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
