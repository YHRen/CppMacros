# Macros C++

for online coding competition.

## unison 
### light
* jrnl, `~/.jrnl_config`
* vimwiki, setup in vimrc
* taskwarrior, setup in zshrc, TASKRC variable 

### heavy
* Calibre
* zotero storage folder

### Install

#### i3wm
```
apt install i3 i3blocks
ln -s github/yhren/CppMacros/i3_config .config/i3/config
git clone https://github.com/vivien/i3blocks-contrib ~/.config/i3blocks
ln -s github/yhren/CppMacros/i3blocks_config ~/.config/i3blocks/config
```

#### NeoVim
```
apt install neovim
ln -s ~/github/yhren/CppMacros/vimrc .vimrc
git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
ln -s ~/github/yhren/CppMacros/init.vim ~/.config/nvim/init.vim
ln -s ~/github/yhren/CppMacros/vim_snippets ~/.config/nvim/Ultisnips
pip3 install --user pynvim
```

#### Zsh
```
apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -s github/yhren/CppMacros/zshrc .zshrc
```

#### alacritty
```
mkdir ~/.config/alacritty/
ln -s alacritty.yml ~/.config/alacritty/alacritty.yml
```

#### Git
```
apt install git
git config --global core.excludesfile ~/github/yhren/CppMacros/gitignore
```

#### Anaconda3
download from `https://www.anaconda.com/distribution/`


#### GNOME Terminal
```
bash -c  "$(wget -qO- https://git.io/vQgMr)"
```

#### Useful programs
```
sudo apt install clang-format
```
