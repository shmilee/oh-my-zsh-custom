ZSH_CUSTOM := $(HOME)/.oh-my-zsh/custom
# INSTALL place

LOCATION := default
plugins := cp extract screen history-substring-search git
ZSH := $(HOME)/.oh-my-zsh
FIX_FPATH := no
MYAPP := $(HOME)/myapp

OS   := $(shell uname)
HOST := $(shell hostname)
HOSTID := $(shell hostid)

ifneq (,$(sort $(foreach hid, 68794c32 68794e32 68794d32 0819ce06, \
      $(findstring ${hid}, $(HOSTID)))))
	LOCATION := th1a
	plugins += th-1a
	ZSH := $(MYAPP)/share/oh-my-zsh
endif

ifneq (,$(findstring c084590bc, $(shell cat /etc/machine-id 2>/dev/null)))
	LOCATION := TH-3F
	plugins += th-3
endif
ifeq ($(HOST),manager-ib)
	LOCATION := kylin
	plugins += ifts-kylin
	ZSH := $(MYAPP)/share/oh-my-zsh
	FIX_FPATH := yes
	FPATH := $(shell find $(MYAPP)/share/zsh/functions/* -type d)
endif

ifneq (,$(findstring 06fdf68b, $(shell cat /etc/machine-id 2>/dev/null)))
	LOCATION := kylin2
	plugins += ifts-kylin2
endif

ifeq ($(HOST),ZION)
	LOCATION := zion
	plugins += ifts-zion
	ZSH := $(MYAPP)/share/oh-my-zsh
endif

# my computer & archlinux
ifneq (,$(findstring arch-,$(HOST)))
	LOCATION := arch
	plugins += sudo archlinux command-not-found systemadmin systemd systemd-more
	ZSH := /usr/share/oh-my-zsh
endif

ifeq ($(OS),Darwin)
	LOCATION := MacOSX
	plugins += sudo brew brew-cask
endif

$(LOCATION):
	@echo
	@echo 'Location   : $(USER)@$(HOST)'
	@echo 'ZSH        : $(ZSH)'
	@echo 'ZSH_CUSTOM : $(ZSH_CUSTOM)'
	@echo 'Plugins    : $(plugins)'
	@echo
	@sed -e 's|##ZSH##|$(ZSH)|' -e 's|##ZSH_CUSTOM##|$(ZSH_CUSTOM)|' \
		-e 's|##PLUGINS##|$(plugins)|' myzshrc > zshrc.$(LOCATION)
	@if [[ $(FIX_FPATH) == yes ]]; then \
		sed -i -e 's|^##FIX_FPATH##|fpath=($(FPATH) $$fpath)|' zshrc.$(LOCATION); \
	fi
	@if [[ x"$(LOCATION)" == x"TH-3F" ]]; then \
		sed -i -e 's|^compinit$$|compinit -i|' zshrc.$(LOCATION); \
	fi
install: pre
	@cd custom/; find . -type d -exec install -dvm755 {} $(ZSH_CUSTOM)/{} \;
	@cd custom/; find . -type f \( -name '*.zsh' -or -name '*.zsh-theme' \) \
		-exec install -vm644 {} $(ZSH_CUSTOM)/{} \;
	@if [ -a $(HOME)/.zshrc ]; then \
		mv -v $(HOME)/.zshrc $(HOME)/.zshrc.bk; \
	fi
	install -m644 zshrc.$(LOCATION) $(HOME)/.zshrc

pre:
	@if [ ! -d $(ZSH) ]; then \
		git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $(ZSH); \
	else \
		echo 'ZSH        : $(ZSH)'; \
	fi
	@echo 'default shell is $(shell echo $$SHELL)'

clean:
	-rm zshrc.*

.PHONY: install clean
