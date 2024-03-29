#!/usr/bin/bash

# Setup Git
git config --global user.email "poh.zijie@gmail.com"
git config --global user.name "zjpoh"

# Copy RCs
cp condarc $HOME/.condarc
cp inputrc $HOME/.inputrc
cp vimrc_pixelbook $HOME/.vimrc

# Install vim with clipboard
sudo apt install vim-gtk -y
# Install vim plug - Run :PlugInstall

__has_conda=$(which conda)
if [ -z $__has_conda ]; then
    echo Conda not found
    echo Install miniconda

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda

    # Set up to auto init conda
    echo >> ~/.bashrc
    echo "# >>> conda initialize >>>" >> ~/.bashrc
    echo "# !! Contents within this block are managed by 'conda init' !!" >> ~/.bashrc
    echo "__conda_setup=\"\$('/home/$USER/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)\"" >> ~/.bashrc
    echo "if [ \$? -eq 0 ]; then" >> ~/.bashrc
    echo "    eval \"\$__conda_setup\"" >> ~/.bashrc
    echo "else" >> ~/.bashrc
    echo "    if [ -f \"/home/$USER/miniconda/etc/profile.d/conda.sh\" ]; then" >> ~/.bashrc
    echo "	. \"/home/$USER/miniconda/etc/profile.d/conda.sh\"" >> ~/.bashrc
    echo "    else" >> ~/.bashrc
    echo "	export PATH=\"/home/$USER/miniconda/bin:\$PATH\"" >> ~/.bashrc
    echo "    fi" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "unset __conda_setup" >> ~/.bashrc
else
    echo Conda found at $__has_conda
fi

# Create conda environment
source ~/.bashrc
conda create -n py39 python=3.9 jupyter jupyterlab numpy pandas scikit-learn matplotlib scipy -y


