#! /bin/bash
# Install default software prior for thinkWhere development VM, prior to
# packaging for use.

cd ~

#  Add links to the shared directories:
ln -s /media/sf_dev ${HOME}/dev
ln -s /media/sf_T_DRIVE ${HOME}/T

# Make new users members of _vboxsf_ automatically
echo "ADD_EXTRA_GROUPS=1" | sudo tee -a  /etc/adduser.conf
echo 'EXTRA_GROUPS="vboxsf"' | sudo tee -a  /etc/adduser.conf

# Add directory to the path
mkdir bin
echo "export PATH=${HOME}/bin:${PATH}" >> .bashrc


## Add additional repositories
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 3FF5FFCAD71472C4
sudo touch /etc/apt/sources.list.d/qgis-ubuntugis.list
echo "deb http://qgis.org/ubuntugis xenial main" | \
    sudo tee -a  /etc/apt/sources.list.d/qgis-ubuntugis.list 
sudo apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable 
sudo apt-add-repository -y ppa:ubuntu-desktop/ubuntu-make 

# Update package list
sudo apt-get update

# Install packages - General
sudo apt-get install -y \
build-essential \
exuberant-ctags \
fonts-droid \
fonts-freefont-otf \
fonts-freefont-ttf \
fonts-liberation \
fonts-linuxlibertine \
fonts-lmodern \
gedit \
gedit-plugins \
gftp \
gimp \
git \
gitg \
hamster-indicator \
inkscape \
libcurl3 \
libzmq-dev \
maven3 \
meld \
mint-meta-codecs \
openjdk-7-jdk \
openjdk-8-jdk \
pep8 \
pgadmin3 \
postgresql-client \
python-dev \
python3-dev \
python-flake8 \
python-pip \
python-future \
r-base \
skype \
spyder \
sqlite3 \
sqliteman \
subversion \
ttf-mscorefonts-installer \
ubuntu-make \
unison \
vim-gtk \ 
virtualbox-guest-dkms \
virtualenv \
xclip

# install packages - GIS
sudo apt-get install -y \
qgis \
grass \
gmt \
gmt-doc \
gmt-doc \
gmt-gshhs-full \
gmt-gshhs-high \
gmt-gshhs-low \
qgis-plugin-grass \
python-qgis \
gdal-bin \
gpsbabel \
gpsprune \
proj-bin \
proj-data \
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

# Install pycharm with umake
umake ide pycharm-professional

# Copy all the files that you want all users to have to the /etc/skel directory.
#cd ~
#sudo cp bin dev Y T Desktop .bashrc .qgis2 .config .vim /etc/skel -R
#sudo cp --parents .local/share/umake/ide /etc/skel -R
#sudo rm -rf /etc/skel/.mozilla

