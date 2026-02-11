default_target: help

help:
	@echo "all           - Set up all configurations"
	@echo "bindings      - Link and configure key bindigns"
	@echo "dunst         - Set up dunst configuration"
	@echo "fish          - Set up fish configuration"
	@echo "git           - Set up the gitignore"
	@echo "hypr          - Set up Hyprland configuration"
	@echo "i3            - Set up i3 configuration"
	@echo "picom         - Set up picom configuration"
	@echo "polybar       - Set up polybar configuration"
	@echo "rofi          - Set up rofi configuration"
	@echo "spotifyd      - Set up spotifyd configuration"
	@echo "sway          - Set up sway configuration"
	@echo "terminator    - Set up terminator configuration"
	@echo "vim           - Set up Neovim configuration"

all:
	bindings
	dunst
	fish
	git
	hypr
	i3
	picom
	polybar
	rofi
	sway
	terminator
	vim

bindings:
	rm -f ${HOME}/.Xmodmap
	ln -s ${PWD}/.Xmodmap ${HOME}/.Xmodmap
	xmodmap ${HOME}/.Xmodmap

dunst:
	mkdir -p ${HOME}/.config/dunst
	rm -f ${HOME}/.config/dunst/dunstrc
	ln -s ${PWD}/.config/dunst/dunstrc ${HOME}/.config/dunst/dunstrc

fish:
	rm -rf ${HOME}/.config/fish
	ln -s ${PWD}/.config/fish ${HOME}/.config/fish

git:
	rm -f ${HOME}/.gitignore_global
	ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global
	rm -f ${HOME}/.gitconfig
	ln -s ${PWD}/.gitconfig ${HOME}/.gitconfig

i3:
	rm -f ${HOME}/.config/i3/config
	ln -s ${PWD}/.config/i3/config ${HOME}/.config/i3/config

sway:
	rm -f ${HOME}/.config/sway/config
	mkdir -p ${HOME}/.config/sway
	ln -s ${PWD}/.config/sway/config ${HOME}/.config/sway/config

hypr:
	rm -rf ${HOME}/.config/hypr
	ln -s ${PWD}/.config/hypr ${HOME}/.config

waybar:
	rm -rf ${HOME}/.config/waybar
	ln -s ${PWD}/.config/waybar ${HOME}/.config/waybar

picom:
	mkdir -p ${HOME}/.config/picom
	rm -f ${HOME}/.config/picom/picom.conf
	ln -s ${PWD}/.config/picom/picom.conf ${HOME}/.config/picom/picom.conf

polybar:
	rm -rf ${HOME}/.config/polybar
	ln -s ${PWD}/.config/polybar ${HOME}/.config/polybar

rofi:
	rm -rf ${HOME}/.config/rofi
	ln -s ${PWD}/.config/rofi ${HOME}/.config/rofi

spotifyd:
	rm -f ${HOME}/.config/spotifyd
	ln -s ${PWD}/.config/spotifyd ${HOME}/.config/spotifyd

terminator:
	mkdir -p ${HOME}/.config/terminator
	rm -f ${HOME}/.config/terminator/config
	ln -s ${PWD}/.config/terminator/config ${HOME}/.config/terminator/config

vim:
	mkdir -p ${HOME}/.config/nvim
	rm -f ${HOME}/.config/nvim/init.vim
	ln -s ${PWD}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim

