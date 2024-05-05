#!/bin/bash
echo ""
echo "##############################################################"
echo "This configuration is tested for Neovim version: 9.5"
echo "##############################################################"
echo ""
NVIM_VER=v0.9.5
SCRIPT_LOCATION=${PWD}

# NVIM Version Check 
CURRENT_NVIM_VER=$(nvim --version | head -1 | awk '{print $2}')
if [[ "${CURRENT_NVIM_VER}" != "${NVIM_VER}" ]]; then
  echo "This script is tested only on Neovim v0.9.5 and will only work for this verion."
  exit 1
fi

# Create Local Opt for User
if [[ -d "${HOME}/opt" ]]; then
  cd ${HOME}/opt
else
  mkdir -p ${HOME}/opt/
  cd ${HOME}/opt
fi

# Download Nvim Binary
if [[ -f "${HOME}/opt/bin/nvim" && "${CURRENT_NVIM_VER}" != "${NVIM_VER}" ]]; then
  echo ""
  echo "-------------------------------------------------"
  echo "Downloading latest nvim binary..."
  echo "-------------------------------------------------"
  mkdir -p ${HOME}/staging_dir
  cd ${HOME}/staging_dir
  wget --no-check-certificate https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux64.tar.gz
  
  # Untar Nvim tarball
  echo ""
  echo "-------------------------------------------------"
  echo "Untarring nvim-linux64.tar.gz..."
  echo "-------------------------------------------------"
  tar -zxvf nvim-linux64.tar.gz
  rsync -av nvim-linux64/ ${HOME}/opt/
  cd ${HOME}
  rm -rf staging_dir
fi

# Install NvChad and Copy Custom configs
if [[ -f "${HOME}/opt/bin/git" ]]; then
  echo ""
  echo "-------------------------------------------------"
  echo "Downloading and installing NvChad..."
  echo "-------------------------------------------------"
  git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth=1
  if [[ $? -eq 0 ]]; then
      echo ""
      echo "-------------------------------------------------"
      echo "Copying nvim lua configs for python..."
      echo "-------------------------------------------------"
      rsync -av ${SCRIPT_LOCATION}/config/nvim ${HOME}/.config/
  else
    echo "Git clone of NvChad failed..."
    exit 1
  fi
else
  echo "Git command missing... Install git..."
fi

