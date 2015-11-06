# Instructions and scripts for setting up a Linux development virtual machine

### Setting up the vmdk image on your own machine


### Creating the vmdk image

+  Create new virtual machine with 16 Gb disk space called TW_devVM_vanilla
+  Share the C:\dev, C:\dotfiles, T:\, X:\ and Y:\ drives with it (automount,
   full access)
+  Use Linux Mint OEM image, so each user gets to set own preferences
+  Install Linux from the .iso file (username _oem_, password _TWAdm1n_)
+  Restart the virtual machine

#### Preparation of the software and settings

> Note that Linux Mint comes with the following installed:
> + virtualbox-guest-utils
> + virtualbox-guest-dkms
> + virtualbox-guest-x11
> These are used to communicate with VirtualBox and have to be install manually in some other distributions.

+  Uncomment the ADD_EXTRA_GROUPS and EXTRA_GROUPS lines in /etc/adduser.conf
+  Add `vboxfs` to the list of extra groups
+  Add links to the shared directories:
```
ln -s /media/sf_dev /home/oem/dev
ln -s /media/sf_dotfiles /home/oem/dotfiles
ln -s /media/sf_T_DRIVE /home/oem/T
ln -s /media/sf_X_DRIVE /home/oem/X
ln -s /media/sf_Y_DRIVE /home/oem/Y
```

+  Setup desktop preferences e.g. background, panels

+  Copy all the files that you want all users to have to the /etc/skel directory.

```
sudo cp dev dotfiles TW_devVM X Y T Desktop .config
```

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
   network at T:\Operations\Products\Software\Client\
