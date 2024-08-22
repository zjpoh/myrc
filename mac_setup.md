Copy inputrc

Brew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
PATH=/opt/homebrew/bin:$PATH
```

Install bash
```
brew install bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
```

Install vim and copy vimrc
```
brew install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Open vim and run `:PlugInstall`

Install conda and copy condarc
```
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
echo '. $HOME/miniconda3/etc/profile.d/conda.sh' >> ~/.bash_profile
conda activate base
```

Install LaTeX
