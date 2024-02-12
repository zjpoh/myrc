#!/usr/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install git

# Setup ssh for github
touch ~/.ssh/config
echo "Host github.com" >> ~/.ssh/config
echo "    HostName github.com" >> ~/.ssh/config
echo "    User git" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config

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

# Install conda
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

echo 'PS1="\e[1;32m\u@\h\e[m:\e[1;35m\w\e[m\$ "' >> ~/.bashrc

echo "if [ -f ~/.bash_aliases ]; then" >> ~/.bashrc
echo ". ~/.bash_aliases" >> ~/.bashrc
echo "fi" >> ~/.bashrc

# Install LaTeX
cd ~
mkdir temp
cd temp
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-*
sudo perl ./install-tl --no-interaction
echo 'export PATH=/usr/local/texlive/2023/bin/x86_64-linux/:$PATH' >> ~/.bashrc
