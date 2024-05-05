#!/bin/bash
echo ""
echo "##############################################################"
echo "This configuration is tested for Neovim version: 9.5"
echo "##############################################################"
echo ""
NVIM_VER=9.5
if [[ -d "${HOME}/opt" ]]; then
  cd ${HOME}/opt
else
  mkdir -p ${HOME}/opt/
  cd ${HOME}/opt
fi

echo "Downloading latest nvim binary..."
mkdir ${HOME}/staging_dir
cd ${HOME}/staging_dir
wget https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux64.tar.gz
tar -zxvf nvim-linux64.tar.gz
rsync -av nvim-linux64/ ${HOME}/opt/
cd ${HOME}
rm -rf staging_dir

if [[ -f "{HOME}/opt/bin/git" ]]; then
  echo "Downloading and installing NvChad..."
  git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth=1

  echo "Copying nvim lua configs for python..."
  rsync ./config/nvim ${HOME}/.config/nvim
  return 0
else
  echo "Git command missing... Install git..."
  return 1
fi

