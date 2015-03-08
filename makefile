ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom
# INSTALL place

archplugin = archlinux command-not-found git history-substring-search
admin = sudo systemadmin systemd
#ifts: ifts-kylin ifts-me ifts-zion

LOCATION := default
plugins := cp extract screen
ZSH := $(HOME)/.oh-my-zsh
ADD_PATH :=
ADD_LD :=

HOST := $(shell hostname)

ifeq ($(HOST),manager-ib)
	LOCATION := kylin
	plugins += ifts-kylin
	ADD_PATH := ~/myapp/bin:
	ADD_LD := ~/myapp/lib:
endif

ifeq ($(HOST),ZION)
	LOCATION := zion
	plugins += ifts-zion
	ADD_PATH := ~/myapp/bin:
	ADD_LD := ~/myapp/lib:
endif

# my computer & archlinux
ifeq ($(USER),shmilee)
	LOCATION := arch
	plugins += $(archplugin) $(admin) ifts-me
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
		-e 's|##PLUGINS##|$(plugins)|' -e 's|##ADD_PATH##|$(ADD_PATH)|'\
		-e 's|##ADD_LD##|$(ADD_LD)|' myzshrc > zshrc.$(LOCATION)

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
