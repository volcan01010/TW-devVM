#! /bin/bash
# Install default software prior for thinkWhere development VM, prior to
# packaging for use.

cd ~

#  Add links to the shared directories:
ln -s /media/sf_dev ${HOME}/dev
ln -s /media/sf_dotfiles ${HOME}/dotfiles
ln -s /media/sf_T_DRIVE ${HOME}/T
ln -s /media/sf_X_DRIVE ${HOME}/X
ln -s /media/sf_Y_DRIVE ${HOME}/Y

# Make new users members of _vboxsf_ automatically
echo "ADD_EXTRA_GROUPS=1" | sudo tee -a  /etc/adduser.conf
echo 'EXTRA_GROUPS="vboxsf"' | sudo tee -a  /etc/adduser.conf

# Add directory to the path
mkdir bin
echo "export PATH=${HOME}/bin:${PATH}" >> .bashrc


## Add additional repositories
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 3FF5FFCAD71472C4
sudo touch /etc/apt/sources.list.d/qgis-ubuntugis.list
echo "deb http://qgis.org/ubuntugis trusty main" | \
    sudo tee -a  /etc/apt/sources.list.d/qgis-ubuntugis.list 
wget --quiet -O - postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable 
sudo apt-add-repository -y ppa:georepublic/pgrouting 
sudo apt-add-repository -y ppa:andrei-pozolotin/maven3 
sudo apt-add-repository -y ppa:openjdk-r/ppa 
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
gitg \
inkscape \
keepass2 \
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
python-flake8 \
python-pip \
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

# Install Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f -y
cd ~

# Update and install python packages using pip
sudo pip install --upgrade \
ipython[all] \
qtconsole \
pandas \
virtualenv \
pyzmq

# Get nice VIM settings
cd ~
git clone --recursive http://github.com/volcan01010/dotfiles-vim .vim

# Downgrade to 3.1.0 for working with QGIS IPython console
sudo pip install ipython[all]==3.1.0 --upgrade

# Copy all the files that you want all users to have to the /etc/skel directory.
cd ~
sudo cp bin dev dotfiles TW_devVM X Y T Desktop .bashrc .qgis2 .config .vim /etc/skel -R
sudo cp --parents .local/share/umake/ide /etc/skel -R
sudo rm -rf /etc/skel/.mozilla
