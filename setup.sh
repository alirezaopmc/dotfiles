#!/bin/bash

git pull
mkdir -p ~/.config/nvim

link_files=(
  "neovim ~/.config/nvim"
  "wezterm ~/.config/wezterm"
  "tmux/.tmux.conf ~/.tmux.conf"
  "zsh/.zshrc ~/.zshrc"
  "bash/.bashrc ~/.bashrc"
)

for entry in "${link_files[@]}"; do
  src=$(echo "$entry" | awk '{print $1}')
  dst=$(echo "$entry" | awk '{print $2}')

  src_path="$(pwd)/$src"
  dst_path="$(eval echo $dst)"

  if [ -e "$dst_path" ] || [ -L "$dst_path" ]; then
    echo "File exists: $dst_path"
    read -p "Overwrite with symlink to $src_path? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      rm -rf "$dst_path"
      ln -s "$src_path" "$dst_path"
      echo "Linked: $dst_path → $src_path"
    else
      echo "Skipped: $dst_path"
    fi
  else
    ln -s "$src_path" "$dst_path"
    echo "Linked: $dst_path → $src_path"
  fi
done
