config:
	@ln -s ${PWD}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim
	@ln -s ${PWD}/.config/rofi ${HOME}/.config/rofi
	@ln -S ${PWD}/.config/polybar ${HOME}/.config/polybar

git:
	@ln -s ${PWD}/.gitignore_global ${HOME}/.gitignore_global
