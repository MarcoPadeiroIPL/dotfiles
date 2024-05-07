#!/bin/bash
stow_stuff() {
    stow alacritty
    echo -e "\t$HOME/.config/alacritty -> $(pwd)/alacritty/.config/alacritty"

    stow dwm
    echo -e "\t$HOME/.config/dwm -> $(pwd)/dwm/.config/dwm"

    stow nvim
    echo -e "\t$HOME/.config/nvim -> $(pwd)/nvim/.config/nvim"

    stow tmux
    echo -e "\t$HOME/.config/tmux -> $(pwd)/tmux/.config/tmux"

    echo 'ZDOTDIR=$HOME/.config/zsh' > ~/.zshenv
    stow zsh
    echo -e "\t$HOME/.config/zsh -> $(pwd)/zsh/.config/zsh"
}

configure_zsh() {
    ZDOTDIR="$HOME/.config/zsh"
    echo -e "\tCloning zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions $ZDOTDIR/plugins/zsh-completions > /dev/null 2>&1
    echo -e "\tCloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZDOTDIR/plugins/zsh-syntax-highlighting > /dev/null 2>&1
    echo -e "\tCloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions > /dev/null 2>&1
    echo -e "\tCloning powerlevel10k..."
    git clone https://github.com/romkatv/powerlevel10k $ZDOTDIR/themes/powerlevel10k > /dev/null 2>&1

    mkdir -p $ZDOTDIR/plugins/git $ZDOTDIR/plugins/z
    echo -e "\tCloning git plugin..."
    curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh -o $ZDOTDIR/plugins/git/git.plugin.zsh > /dev/null 2>&1
    echo -e "\tCloning z plugin..."
    curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/z/z.plugin.zsh -o $ZDOTDIR/plugins/z/z.plugin.zsh > /dev/null 2>&1
}

configure_tmux() {
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm > /dev/null 2>&1
}

configure_dwm() {
    cd dwm/.config/dwm
    echo -e "\tCloning..."
    git init > /dev/null 2>&1
    git remote add origin https://git.suckless.org/dwm > /dev/null 2>&1
    git pull origin main > /dev/null 2>&1

    echo -e "\tCompiling..."
    make PREFIX=$HOME/.local/ install > /dev/null 2>&1
    cd - > /dev/null
}

install_fonts() {
    mkdir -p $HOME/.local/share/fonts/ttf
    echo -e "\tCloning Hack Nerd Font..."
    wget -O /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip > /dev/null 2>&1
    echo -e "\tCloning Iosevka Nerd Font..."
    wget -O /tmp/Iosevka.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip > /dev/null 2>&1
    echo -e "\tCloning JetBrains Nerd Font..."
    wget -O /tmp/JetbrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip > /dev/null 2>&1

    echo -e "\tExtracting Hack Nerd Font..."
    unzip /tmp/Hack.zip -d $HOME/.local/share/fonts/ttf/Hack > /dev/null 2>&1
    echo -e "\tExtracting Iosevka Nerd Font..."
    unzip /tmp/Iosevka.zip -d $HOME/.local/share/fonts/ttf/Iosevka > /dev/null 2>&1
    echo -e "\tExtracting JetBrains Nerd Font..."
    unzip /tmp/JetBraingsMono.zip -d $HOME/.local/share/fonts/ttf/JetBrainsMono > /dev/null 2>&1
}

echo ":: Creating symm links..."
stow_stuff

echo ":: Configuring zsh..."
configure_zsh

echo ":: Configuring dwm..."
configure_dwm

echo ":: Installing nerd fonts..."
install_fonts
