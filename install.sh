#!/bin/sh

__update()
{
  sudo apt-get update
}

__upgrade()
{
  sudo apt-get upgrade
}

__install_neovim()
{
  # Install necessary tools
  sudo apt-get install fuse libfuse2 git python3-pip ack-grep -y

  # Install
  wget \
    --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
    --output-document nvim
  chmod +x nvim
  sudo chown root:root nvim
  sudo mv nvim /usr/bin

  # Install vim-plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Configure
  mkdir -p ~/.config/nvim
  cp ./cfgs/init.vim ~/.config/
}

__install_zsh()
{
  # Install ZSH
  sudo apt-get install zsh

  # Install OMZ
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Install auto-suggestion
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # Install z
  git clone https://github.com/agkozak/zsh-z \
    $ZSH_CUSTOM/plugins/zsh-z

  # Configure
  cp ./cfgs/zsh/.zshrc ~/.zshrc
}

__install_batcat()
{
  # Install bat
  sudo apt-get install bat

  # Link
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
}

__install_tmux()
{
  # Install
  sudo apt-get install tmux

  # Configure
  cp ./cfgs/tmux/.tmux.conf ~/.tmux.conf
}

__install_tmate()
{
  # Install
  sudo apt-get install tmate

  # Configure
  cp ./cfgs/tmate/.tmate.conf ~/.tmate.conf
}

__install_docker()
{
  # Uninstall old versions
  sudo apt-get remove docker docker-engine docker.io containerd runc

  # Setup repository
  sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

  echo "Receiving a GPG error when running apt-get update?
  Your default umask may not be set correctly, causing the public key file for the repo to not be detected. Run the following command and then try to update your repo again: sudo chmod a+r /etc/apt/keyrings/docker.gpg."
  
  # Post install
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker

  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service
}

# $1 package_name
install()
{
  package_name=$1

  __update
  __install_$package_name
}

packages=(
  neovim
  zsh
  batcat
  tmux
  tmate
  docker
)

if [ $1 = "all"]; then
  for $package in "${packages[@]}"
  do
    install $package
  done
else
  install $1
fi

