#!/bin/bash
# Install script dotfiles

function configureZSH {
    echo "Configuring zsh..."
    cd $HOME/dotfiles-temp

    # Deleting old config files
    echo "  Backing up old config files..."
    [ -f $HOME/.zshrc ] && mkdir -p $HOME/old-dotfiles/zsh && mv $HOME/.zshrc $HOME/old-dotfiles/zsh/zshrc 
    [ -f $HOME/.oh-my-zsh ] && mkdir -p $HOME/old-dotfiles/zsh && mv $HOME/.oh-my-zsh $HOME/old-dotfiles/zsh/oh-my-zsh
    #[ -f $HOME/.p10k.zsh ] && mkdir -p $HOME/old-dotfiles/zsh && mv $HOME/.p10k.zsh $HOME/old-dotfiles/zsh/p10k.zsh

    # Installing oh-my-zsh
    echo "  Installing oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh &> /dev/null 


    # Installing oh-my-zsh plugins
    echo "  Installing Auto-Suggestions..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone git@github.com:zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &> /dev/null
    
    echo "  Installing Syntax-Hightlighting..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &> /dev/null
    
    echo "  Installing Completions..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone git@github.com:zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions &> /dev/null
    
    echo "  Installing powerlevel10k..."
    rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth=1 git@github.com:romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k &> /dev/null

    echo "  Moving config files to the right place..."
    mv zsh/zshrc $HOME/.zshrc
    #mv zsh/p10k.zsh $HOME/.p10k.zsh

}

function configureNeovim {
    echo "Configuring neovim..."
    cd $HOME/dotfiles-temp

    # Deleting old config files
    [ -d $HOME/.config/nvim ] && echo "  Backing up old config files..." && mkdir -p $HOME/old-dotfiles && mv $HOME/.config/nvim $HOME/old-dotfiles

    echo "  Installing Packer..."
    rm -rf $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim &> /dev/null

    echo "  Moving files to the right path..."
    mv nvim $HOME/.config/
    
    echo "  Syncing packages..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function configureAlacritty {
    echo "Configuring alacritty..."
    cd $HOME/dotfiles-temp

    # Deleting old config files
    [ -f $HOME/.alacritty.yml ] && echo "  Backing up old config files... " && mkdir -p $HOME/old-dotfiles && mkdir -p $HOME/old-dotfiles/alacritty && mv $HOME/.alacritty.yml $HOME/old-dotfiles/alacritty/

    mv alacritty/config $HOME/.alacritty.yml
}

function configurei3 {
    echo "Configuring i3..."
    cd $HOME/dotfiles-temp

    # Deleting old config files
    [ -d $HOME/.config/i3 ] && echo "  Backing up old config files..." && mkdir -p $HOME/old-dotfiles && mv $HOME/.config/i3 $HOME/old-dotfiles

    mv i3 $HOME/.config/
}

function configurei3bar {
    echo "Configuring i3status..."
    cd $HOME/dotfiles-temp

    [ -d $HOME/.config/i3status ] && echo "  Backing up old config files..." && mkdir -p $HOME/old-dotfiles && mv $HOME/.config/i3status $HOME/old-dotfiles
    mv i3status $HOME/.config/
}


echo "Configuration of dotfiles..."
read -p "Do you want this script to automaticaly install the required packages? [Y/n]: " packages
read -p "Do you want this script to automaticaly configure the programs? [Y/n]: " configure

if [ "$packages" == "Y" ] || [ "$packages" == "y" ] || [ "$packages" == "" ]; then
    echo "  Installing required packages..."
    curl -sS https://raw.githubusercontent.com/MarcoPadeiroIPL/dotfiles/master/pkglist.txt -o pkglist.txt
    sudo pacman -S --needed - < pkglist.txt
    rm -rf pkglist.txt
fi

if [ "$configure" == "Y" ] || [ "$configure" == "y" ] || [ "$configure" == "" ]; then
    rm -rf $HOME/old-dotfiles
    rm -rf $HOME/dotfiles-temp
    echo -e "\nDownloading dotfiles from repository..."
    git clone git@github.com:MarcoPadeiroIPL/dotfiles.git $HOME/dotfiles-temp &> /dev/null
    cd $HOME/dotfiles-temp

    configureZSH
    configureNeovim
    configureAlacritty
    configurei3
    configurei3bar

    echo "Cleaning up..."
    rm -rf $HOME/dotfiles-temp

    if [ $(echo $SHELL) != "/bin/zsh" ]; then
        read -p "Make zsh default shell? [Y/n]" defaultshell

        if [ "$defaultshell" == "Y" ] || [ "$defaultshell" == "y" ] || [ "$defaultshell" == "" ]; then
            chsh -s /bin/zsh
        fi
    fi

    echo -e "\nDone!"
    echo "You may need to restart your X session for some changes to take effect."
    echo "Your old config files are backed up in \"$HOME/old-dotfiles\""

fi

