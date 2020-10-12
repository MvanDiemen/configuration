default_target: help

help:
	@echo "config        - Set up the .config configuration"
	@echo "git           - Set up the gitignore"
	@echo "bindings      - Link and configure key bindigns"

config:
	@mkdir -p ${HOME}/.config/nvim
	@ln -s ${PWD}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim
	@ln -s ${PWD}/.config/i3/config ${HOME}/.config/i3/config
	@ln -s ${PWD}/.config/i3/xrandr_i3.sh ${HOME}/.config/i3/xrandr_i3.sh
	@ln -s ${PWD}/.config/rofi ${HOME}/.config/rofi
	@ln -s ${PWD}/.config/polybar ${HOME}/.config/polybar
	@mkdir -p ${HOME}/.config/dunst
	@ln -s ${PWD}/.config/dunst/dunstrc ${HOME}/.config/dunst/dunstrc
	@mkdir -p ${HOME}/.config/terminator
	@ln -s ${PWD}/.config/terminator/config ${HOME}/.config/terminator/config
	@mkdir -p ${HOME}/.config/picom
	@ln -s ${PWD}/.config/picom/picom.conf ${HOME}/.config/picom/picom.conf
	@ln -s ${PWD}/.zshrc ${HOME}/.zshrc
	@ln -s ${PWD}/.config/fish ${HOME}/.config/fish


git:
	@ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global
	@ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig

bindings:
	@ln -s ${PWD}/.Xmodmap ${HOME}/.Xmodmap
	@xmodmap ${HOME}/.Xmodmap
