default_target: help

help:
	@echo "config        - Set up the .config configuration"
	@echo "git           - Set up the gitignore"
	@echo "bindings      - Link and configure key bindigns"

config:
	@ln -s ${PWD}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim
	@ln -s ${PWD}/.config/i3/config ${HOME}/.config/i3/config
	@ln -s ${PWD}/.config/i3/xrandr_i3.sh ${HOME}/.config/i3/xrandr_i3.sh
	@ln -s ${PWD}/.config/rofi ${HOME}/.config/rofi
	@ln -s ${PWD}/.config/polybar ${HOME}/.config/polybar
	@ln -s ${PWD}/.config/dunst/dunstrc ${HOME}/.config/dunst/dunstrc
	@ln -s ${PWD}/.config/terminator/config ${HOME}/.config/terminator/config
	@ln -s ${PWD}/.zshrc ${HOME}/.zshrc

git:
	@ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global
	@ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig

bindings:
	@ln -s ${PWD}/.Xmodmap ${HOME}/.Xmodmap
	@xmodmap ${HOME}/.Xmodmap

