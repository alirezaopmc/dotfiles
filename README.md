# dotfiles
## Setup

Auto installation:
```bash
chmod +x setup.sh
./setup.sh
```

Manutal installation:
```bash
git clone https://github.com/alirezaopmc/dotfiles.git
cd dotfiles
mkdir -p ~/.config/nvim
ln -s nvim ~/.config/nvim
ln -s wezterm ~/.config/wezterm
ln -s tmux/.tmux.conf ~
ln -s zsh/.zshrc ~
ln -s bash/.bashrc
```
