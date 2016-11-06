GITHUB_USERNAME=carsonk
GITHUB_REPO=git@github.com:carsonk/dotfiles.git

# Necessary applications for this script.
sudo apt-get install -y git vim zsh

# Let's do the things that require prompts up front.
ssh-keygen -f $HOME/.ssh/id_rsa

# Install oh-my-zsh and switch to zsh shell.
echo "[*] Installing oh-my-zsh."
sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
csh -s `which zsh`

# Install zplug.
echo "[*] Installing zplug."
curl -sL zplug.sh/installer | zsh

# Install ssh-keyreg and run.
echo "[*] Running ssh-keyreg to add key to github account."
sudo sh -c "curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg && chmod +x /usr/local/bin/ssh-keyreg"
ssh-keyreg -u $GITHUB_USERNAME --path id_rsa.pub github

# Configure dot repo.
echo "[*] Configuring dotfiles repo."
echo ".cfg" >> .gitignore
git clone --bare $GITHUB_REPO $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Make backup of initial dotfiles that might be overwritten.
mkdir -p .config-backup && \
config checkout
if [$? = 0]; then
    echo "[*] Checkout out config success."
else
    echo "[*] Backing up existing dot files."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config --local status.showUntrackedFiles no

echo "[*] Pulling down Vim Pathogen."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim
git submodule add https://github.com/flazz/vim-colorschemes.git bundle/colorschemes

# Install applications.
echo "[*] Installing apt-get applications."
sudo apt-get install -y python3 python3-pip bpython3 python-pip
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip

echo "[*] Complete."
