#! /bin/bash
# Install default software prior for thinkWhere development VM, prior to
# packaging for use.


cd ~

## Add additional repositories
wget -O - http://qgis.org/downloads/qgis-2016.gpg.key | gpg --import
gpg --fingerprint 073D307A618E5811
gpg --export --armor 073D307A618E5811 | sudo apt-key add -

sudo touch /etc/apt/sources.list.d/qgis-ubuntugis.list
echo "deb http://qgis.org/ubuntugis xenial main" | \
    sudo tee -a  /etc/apt/sources.list.d/qgis-ubuntugis.list 
sudo apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable 

# Note that Partner repositories must be enabled to get Skype

# another repo for pycharm
sudo add-apt-repository ppa:mystic-mirage/pycharm

# Update package list
sudo apt-get update

# Install packages - General
sudo apt-get install -y \
build-essential \
exuberant-ctags \
gdebi \
gedit \
gedit-plugins \
gftp \
gimp \
git \
gitg \
hamster-indicator \
inkscape \
libcurl3 \
meld \
openjdk-8-jdk \
pep8 \
pgadmin3 \
postgresql-client \
pycharm \
python-dev \
python3-dev \
python-flake8 \
python-pip \
python-future \
r-base \
skype \
sqliteman \
ttf-mscorefonts-installer \
vim-gtk \
virtualenv \
xclip

exit 0

# install packages - GIS
sudo apt-get install -y \
qgis \
grass \
qgis-plugin-grass \
python-qgis \
gdal-bin \
python-mpltoolkits.basemap \
spatialite-gui

# Install packages - QGIS plugin development
sudo apt-get install -y \
python-qt4-sql \
pyqt4-dev-tools \
qt4-designer


# Consider installing keepassx from source here
echo KEEEEEEEEEEEPPPPPAAAAAAAAAAASSSSS
sudo apt-get install \
build-essential \
cmake \
qtbase5-dev \
libqt5x11extras5-dev \
qttools5-dev \
qttools5-dev-tools \
libgcrypt20-dev \
zlib1g-dev

mkdir src
cd src
git clone https://github.com/keepassx/keepassx
cd keepassx
mkdir build
cd build
cmake ..
make
sudo make install

# Get nice VIM settings
cd ~
git clone --recursive http://github.com/volcan01010/dotfiles-vim .vim
