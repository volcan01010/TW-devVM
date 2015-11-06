# Instructions and scripts for setting up a Linux development virtual machine
- - - - - - - -

### Setting up the vmdk image on your own machine

#### Installing the VM

+  Install Oracle VM VirtualBox Manager on your machine
+  Create the C:\dev, C:\dotfiles directories on your machine
+  Copy the TW_devVM directory into your VirtualBox VMs directory
+  Start the image

#### Accessing drives on your machine

By default, you should be able to see the C:\dev, C:\dotfiles, T:\, X:\ and Y:\
drives.  These are mounted in the /media directory e.g. as /media/sf_dev and
linked to the home directory.  The files are owned by _root_ and belong to the _vboxsf_
group.  As a member of the _vboxsf_ group, you should be able to access and
change the files.

Some programs have problems following symbolic links, or if you do not own the
files that you are working with.  In this case it is necessary to connect to
them in a different way:

+  Shut down the virtual machine
+  Share the folder (e.g. C:\Users....\plugins\Roadnet) in VirtualBox Manager,
   but _do not_ make it mount automatically
+  Start the virtual machine
+  Create a directory where you want to access the folder (e.g.
   /home/..../plugins/Roadnet)
+  Add the following command to the /etc/rc.local file, above exit 0:

     ```
     mount -t vboxsf -o rw,gid=1000,uid=1000 sharename /path/to/new/dir
     ```

+  After a reboot of the virtual machine, you should be able to access the
   files.

#### Install IDEs via umake

Eclipse (Luna) and Pycharm can be installed with the umake tool.

    umake ide eclipse
    umake ide pycharm

You can make them accessible from the command line by linking the executable
file into your ~/bin directory:

    ln -s /path/to/pycharm /home/username/bin


#### Install server apps

Server apps are not installed by default.  They can be installed with the
following commands:

```
# install packages - Web
sudo apt-get install apache2 tomcat7 tomcat7-admin

# add geoserver from WAR file
wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.4.0/geoserver-2.4.0-war.zip
unzip geoserver-2.4.0-war.zip geoserver.war
sudo mv geoserver.war /var/lib/tomcat7/webapps/

# install packages - Postgres
sudo apt-get install \
postgresql-9.4-postgis-2.1 \
postgresql-contrib \
postgresql-9.4-pgrouting
```

#### Other useful commands

+ Switch between installed java versions

    ```
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
    java -version
    ```

+ Pick your default editor

    ```
    sudo update-alternatives --config editor
    ```

- - - - - - - -

### Creating the vmdk image

+  Create new virtual machine with 16 Gb disk space called TW_devVM_vanilla
+  Share the C:\dev, C:\dotfiles, T:\, X:\ and Y:\ drives with it (automount,
   full access)
+  Use Linux Mint OEM image, so each user gets to set own preferences
+  Install Linux from the .iso file (username _oem_, password _TWAdm1n_)
+  Restart the virtual machine

#### Preparation of the software and settings

> Note that Linux Mint comes with the following installed:
>
> + virtualbox-guest-utils
> + virtualbox-guest-dkms
> + virtualbox-guest-x11
>
> These are used to communicate with VirtualBox and have to be install manually in some other distributions.

+  Clone the git repository with the installation scripts:

    ```
    git clone https://tw-johns@stash.luminis.net/scm/~tw-johns/tw_devvm.git TW_devVM
    ```

+  Move into the directory and run the setup script:

    ```
    cd TW_devVM
    bash dev_VM_setup.sh
    ```

+  Set up and personalise other settings e.g. install QGIS plugins
    + Zoom to postcode
    + OpenLayers
    + IPython terminal


#### Sharing the virtual machine image

+  Freeze TW_devVM_vanilla machine, then close and Save Machine State
+  Make a full clone of TW_devVM_vanilla, called TW_devVM
+  Start up TW_devVM
+  Run 'Prepare for shipping to end user' from the desktop
+  Delete desktop icon from the skeleton directory:

    ```
    sudo rm /etc/skel/Desktop/Prepare\ for\ shipping\ to\ end\ user
    ```

+  Shutdown the virtual machine
+  Copy to the TW_devVM directory from the VirtualBox VMs directory onto the
   network at _T:\Operations\Products\Software\Client\_
