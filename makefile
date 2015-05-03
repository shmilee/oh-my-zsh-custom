ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom
# INSTALL place

LOCATION := default
plugins := cp extract screen history-substring-search
ZSH := $(HOME)/.oh-my-zsh
FIX_FPATH := no
MYAPP := $(HOME)/myapp

HOST := $(shell hostname)
kylinplugin = git ifts-kylin
zionplugin = git ifts-zion
th1aplugin = git th-1a
archplugin = archlinux command-not-found git ifts-me
admin = sudo systemadmin systemd

ifeq ($(HOST),manager-ib)
	LOCATION := kylin
	plugins += $(kylinplugin)
	ZSH := $(MYAPP)/share/oh-my-zsh
	FIX_FPATH := yes
	FPATH := $(shell find $(MYAPP)/share/zsh/functions/* -type d)
endif

ifeq ($(HOST),ZION)
	LOCATION := zion
	plugins += $(zionplugin)
	ZSH := $(MYAPP)/share/oh-my-zsh
endif

ifeq ($(HOST),ln3)
	LOCATION := th1a
	plugins += $(th1aplugin)
	ZSH := $(MYAPP)/share/oh-my-zsh
endif

# my computer & archlinux
ifeq ($(USER),shmilee)
	LOCATION := arch
	plugins += $(admin) $(archplugin)
	ZSH := /usr/share/oh-my-zsh
endif

$(LOCATION):
	@echo
	@echo 'Location   : $(USER)@$(HOST)'
	@echo 'ZSH        : $(ZSH)'
	@echo 'ZSH_CUSTOM : $(ZSH_CUSTOM)'
	@echo 'Plugins    : $(plugins)'
	@echo
	sed -e 's|##ZSH##|$(ZSH)|' -e 's|##ZSH_CUSTOM##|$(ZSH_CUSTOM)|' \
		-e 's|##PLUGINS##|$(plugins)|' myzshrc > zshrc.$(LOCATION)
	if [[ $(FIX_FPATH) == yes ]]; then \
		sed -i -e 's|^##FIX_FPATH##|fpath=($(FPATH) $$fpath)|' zshrc.$(LOCATION); \
	fi

install:
	cd custom/; find . -type f \( -name '*.zsh' -or -name '*.zsh-theme' \) \
		-exec install -Dvm644 {} $(ZSH_CUSTOM)/{} \;
	if [ -a $(HOME)/.zshrc ]; then \
		mv $(HOME)/.zshrc $(HOME)/.zshrc.bk; \
	fi
	install -m644 zshrc.$(LOCATION) $(HOME)/.zshrc

pre:
	if [ ! -d $(ZSH) ]; then \
		git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $(ZSH); \
	fi
	@echo 'default shell is $(shell echo $$SHELL)'

clean:
	-rm zshrc.*

.PHONY: install clean
