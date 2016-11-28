#!/bin/bash

USER=$1
HOME=/home/$USER

if [[ ! -d $HOME ]]; then
    echo "User does not have a home directory."
    exit
fi

GITHUB_USERNAME=carsonk
GITHUB_REPO=git@github.com:carsonk/dotfiles.git

echo "Home is $HOME"

runu="sudo -u $USER"

# Necessary applications for this script.
sudo apt-get install -y git vim zsh csh

# Let's do the things that require prompts up front.
$runu mkdir $HOME/.ssh
$runu ssh-keygen -f $HOME/.ssh/id_rsa

# Install oh-my-zsh and switch to zsh shell.
echo "[*] Installing oh-my-zsh."
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | $runu zsh
chsh -s /bin/zsh $USER

# Install zplug.
echo "[*] Installing zplug."
$runu curl -sL zplug.sh/installer | $runu zsh

# Install ssh-keyreg and run.
echo "[*] Running ssh-keyreg to add key to github account."
sudo sh -c "curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg && chmod +x /usr/local/bin/ssh-keyreg"
$runu ssh-keyreg -u $GITHUB_USERNAME --path id_rsa.pub github

# Configure dot repo.
echo "[*] Configuring dotfiles repo."
$runu touch .gitignore
echo ".cfg" >> .gitignore
$runu git clone --bare $GITHUB_REPO $HOME/.cfg
config="$runu /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
# Make backup of initial dotfiles that might be overwritten.
$runu mkdir -p .config-backup && \
$config checkout
if [ $? = 0 ]; then
    echo "[*] Checkout out config success."
else
    echo "[*] Backing up existing dot files."
    $config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} $runu mv {} .config-backup/{}
fi;
$config checkout
$config config --local status.showUntrackedFiles no

echo "[*] Pulling down Vim Pathogen."
$runu mkdir -p ~/.vim/autoload ~/.vim/bundle && \
$runu curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim
$runu git init
$runu git submodule add https://github.com/flazz/vim-colorschemes.git bundle/colorschemes

# In case someone doesn't get the message.
chown $USER:$USER $HOME/*

# Install applications.
echo "[*] Installing apt-get applications."
apt-get install -y python3 python3-pip bpython3 python-pip sqlite3 mysql
apt-get install -y ack ag npm
pip install --upgrade pip
pip3 install --upgrade pip

echo "[*] Installing node stuff."
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs
npm install -g bower

echo "[*] Theme shit."
add-apt-repository -y ppa:noobslab/themes
add-apt-repository -y ppa:noobslab/icons
apt-get update
apt-get install -y unity-tweak-tool flatabulous-theme ultra-flat-icons

echo "[*] Spotify."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
apt-get update
apt-get install -y spotify-client

echo "[*] Stuff we're gonna need for Android Studio."
apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

echo "[*] Installing chrome."
apt-get install -y libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome*.deb
if [ $? -eq 0 ]; then
    echo "[*] Installed chrome succesfully."
else
    echo "[*] Attempting to install Chrome deps."
    apt install -f
    dpkg -i google-chrome*.deb
fi        

echo "[*] Installing Atom."
add-apt-repository -y ppa:webupd8team/atom
apt-get update
apt-get install -y atom

echo "[*] Complete. Reboot to complete."

