sudo apt update

#######
# ZSH #
#######

# Install zsh
sudo apt install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install z
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

# Copy dotfiles
cp .zshrc ~/.zshrc

########
# TMUX #
########

# Install tmux
sudo apt install tmux

# Copy dotfiles
cp .tmux.conf ~/.tmux.conf

#########
# TMATE #
#########

# Install tmate
sudo apt install tmate

# Copy dotfiles
cp .tmate.conf ~/.tmate.conf

#########
# VIMRC #
#########

# Install vim
sudo apt install vim

# Initialize vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/vimplug-plugins

# Copy dotfiles
cp .vimrc ~/.vimrc
cp .vimrc.plug ~/.vimrc.plug
echo "Don't forget to run :PlugInstall"
