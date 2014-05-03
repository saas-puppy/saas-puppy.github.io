#!/bin/bash

# NOTE: this script is preliminary and performs no sanity checks
exit

: <<'NOTES'

packages installed:
  libruby1.9.1-dbg (downloaded direct)
  ruby1.9.1-full_1.9.3.0
    ca-certificates_20130906ubuntu0.12.04.1
    libruby1.9.1_1.9.3.0
    libyaml-0-2_0.1.4
    ruby1.9.1_1.9.3.0
    ruby1.9.1-dev_1.9.3.0
    ruby1.9.1-examples_1.9.3.0
    ri1.9.1_1.9.3.0
  lxtermial_0.1.11
    libvte9_0.28.2
    libvte-common_0.28.2
  nano_2.2.6-1

gems installed: (no doc)
  rails -v '3.2.16'
    i18n-0.6.9
    multi_json-1.9.3
    activesupport-3.2.16
    builder-3.0.4
    activemodel-3.2.16
    rack-1.4.5
    rack-cache-1.2
    rack-test-0.6.2
    journey-1.0.4
    hike-1.2.3
    tilt-1.4.1
    sprockets-2.2.2
    erubis-2.7.0
    actionpack-3.2.16
    arel-3.0.3
    tzinfo-0.3.39
    activerecord-3.2.16
    activeresource-3.2.16
    mime-types-1.25.1
    polyglot-0.3.4
    treetop-1.4.15
    mail-2.5.4
    actionmailer-3.2.16
    rake-10.3.1
    rack-ssl-1.3.4
    thor-0.19.1
    json-1.8.1
    rdoc-3.12.2
    railties-3.2.16
    bundler-1.6.2
    rails-3.2.16
  heroku
    excon-0.33.0
    heroku-api-0.3.18
    netrc-0.7.7
    rest-client-1.6.7
    addressable-2.3.6
    launchy-2.4.2
    rubyzip-1.1.3
    heroku-3.6.0

updated ssl certificates

quick-launch buttons added to taskbar:
  urxvt
  geany
  lxterminal
  seamonkey

other:
  reduced number of virtual desktops to one and removed pager from taskbar
  customized colored bash prompt with git branch status , aliases , default editor
  updated Puppy and Ubuntu package repository indices<
  cloned rottenpotatoes course project skeleton
  reassigned urxvt desktop link to lxterminal
  reduced number of virtual desktops to one and removed pager from taskbar

NOTES


: <<'TODO'

* get lxterminal to use customizations in .bashrc (issue #1)
* globicons entry for lxtermial does not seem sufficient (issue #2)
* unetbootin on linux installed incorrect boot entry pmedia=usbflash
  => edit UNetBootIn grub entry to pmedia=atahd or pmedia=cd
* script fetch and install of deb packages
* script initial remastering (this script)
  => (see http://www.murga-linux.com/puppy/viewtopic.php?t=71349)
* how to install heroku apt pgp key
  => for now install heroku gem (and foreman?)
* how to supress root user warning
  => "Don't run Bundler as root. Bundler can ask for sudo if it is needed, and
installing your bundle as root will break this application for all non-root
users on this machine."

TODO


# bash script begin

UNSQUASH_DIR="/mnt/home/unsquashed"
LIVECD_DIR="/mnt/home/puppylivecdbuild"
BASE_BUILD="puppy_raring_3.9.9.2"
INPUT_SFS="$BASE_BUILD.sfs"
OUTPUT_SFS=$INPUT_SFS
ISO_FILENAME="saas-puppy_0.1.iso"
$SCRIPTS_URL="https://github.com/saas-puppy/saas-puppy/scripts"


: <<'SETUP'
NOTE: puppy version > 5.5 will not boot in virtualbox (qemu and vmware ok)

download puppylinux base image and devx*.sfs to / dir
install with unetbootin to HD or USB or burn to cd or load iso into vm
boot base image

# set screen resolution
select screen resolution here if you like then click "OK"
static setting in next alert is unimportant

# cd install
if booted from cd you may install 'frugally':
  Menu => Setup => Puppy Universl installer (choose frugal install)
  
# allocate persistent 'home' storage file
Menu => Setup => SFS-Load on-th-fly then browse to your real partition
select the appropriate devx*.sfs the click "load" to add to right-panel
on the next alert press "yes?" then on the next alert press "skip" 
Menu => Shutdown => Reboot computer then proceed through "first shutdown" alerts:
  alert #1: press "save to file"
  alert #2: press "administrator" # TODO: lets see how well 'fido' behaves
  alert #3: press "continue"
  alert #4: select the partition to store the persistence file then press "ok"
  alert #5: select a filesystem type for persistence file (any will do) then press "ok"
  alert #6: press "ok"
  alert #7: press "normal" (although any will do)
  alert #8: select a file-size for persistent 'home'  (512MB is plenty) then press "ok"
  alert #9: press "yes save"
  alert #10: you may not see this if you installed ("copy file" speeds up cd boot)

# locate your partition (if you need it - you probably don't)
the partition where you saved the persistent 'home' is now mounted at /mnt/home

# setup network
check your network connection (wired eth may auto-connect)
if network is connected skip to # load packages
run "setup networking" from the right-click menu of the network taskbar tray icon
select an option from the "connect to internet by" group
assuming you chose "LAN" (else your on your own (add instructions here if you do)
"simple network setup" is suficient for wired LAN
"frisbee" is better for wifi - select you AP and press "connect" or set your static routing
if DHCP wait until "acqiured" - if you press "exit" the next "default tool" alert is unimportant

# update package indices
Menu => Setup => Puppy Package Manager (or commandline ppm)
press "Configure package manager" then press "Update now"
press "Enter" key as many times as it asks in the orage terminal that pops up
the "processing ... into standard format" routine may take a while
when package index update is complete press enter one last time in yellow terminal
back in configure package manager press "ok"
press "exit package manager"

# download and install libruby-dbg (or add ubuntu-security repo list to ppm)
# if Precise Puppy
  http://mirrors.kernel.org/ubuntu/pool/main/r/ruby1.9.1/libruby1.9.1-dbg_1.9.3.0-1ubuntu2.8_i386.deb
  petget ./libruby1.9.1-dbg_1.9.3.0-1ubuntu2.8_i386.deb
# if Raring Puppy
  wget http://mirrors.kernel.org/ubuntu/pool/main/r/ruby1.9.1/libruby1.9.1-dbg_1.9.3.0-1ubuntu2.8_i386.deb
  petget ./libruby1.9.1-dbg_1.9.3.0-1ubuntu2.8_i386.deb
click "OK" a few times until it indicates success with no unmet dependencies

# install packages
reopen package manager
you should see the package we just installed in the "installed packages" pane
enter ruby1.9.1-full in find textbox then press "go"
press "search" in "search all repositories group"
click on the ruby package in the results pane to install
for any package that lists dependencies (most do) press "examine dependencies"
you will see a "dependencies" tab for each repo this install will hit
press "download and install selected packages"
press "download packages" for each repo window and wait for next
when all are inatalled press "ok" TODO: "trim the fat" sounds good but i think we want to keep ruby-dev
after some time a new window should say no missing libs and no missing deps
repeat this procedure for other packages e.g. nano , lxterminal (NOT rails)

open a terminal

# create symlinks
ln -s /usr/bin/ruby1.9.1 /usr/local/bin/ruby
ln -s /usr/bin/gem1.9.1  /usr/local/bin/gem
ln -s /usr/bin/irb1.9.1  /usr/local/bin/irb

# install rails and heroku (foreman is not reqired for the course)
gem install rails -v '3.2.16' --no-ri --no-rdoc
gem install heroku            --no-ri --no-rdoc

# install ssl certs
update-ca-certificates (this will complain - ubuntu removed some of these certs)

# install rottenpotatoes app
cd ~
git clone https://github.com/saasbook/hw2_rottenpotatoes.git ./rails-apps/rottenpotatoes/

# remaster image
Menu => Setup => Remaster Puppy LiveCD (TODO: manual remaster can be scripted)
choose all default options until asked to burn CD
choose NOT to burn CD    (preserving build dir $LIVECD_DIR)
choose NOT to create ISO (preserving build dir $LIVECD_DIR)
press "ok" to quit then run this script

SETUP

# explode filesystem
unsquashfs -d $UNSQUASH_DIR $LIVECD_DIR/$INPUT_SFS

# copy /root files
wget -O $UNSQUASH_DIR/root/.bashrc                     $SCRIPTS_URL/.bashrc
wget -O $UNSQUASH_DIR/root/.jwm/jwmrc-personal         $SCRIPTS_URL/jwmrc-personal
wget -O $UNSQUASH_DIR/root/.jwmrc-tray                 $SCRIPTS_URL/.jwmrc-tray
wget -O $UNSQUASH_DIR/root/Choices/ROX_Filer/globicons $SCRIPTS_URL/globicons
wget -O $UNSQUASH_DIR/root/Choices/ROX_Filer/PuppyPin  $SCRIPTS_URL/PuppyPin
rm      $UNSQUASH_DIR/root/.packages/user-installed-packages
cp -rn  /root/.packages          $UNSQUASH_DIR/root/
cp -r   /root/.config/lxterminal $UNSQUASH_DIR/root/
cp -r   /root/.gem               $UNSQUASH_DIR/root/
cp -r   /root/rails-apps         $UNSQUASH_DIR/root/

# copy /etc files
cp      /etc/ssl/certs/          $UNSQUASH_DIR/etc/

# copy /usr files
# not sure if these get copied on initial remaster
#cp -rn /usr/share/ca-certificates $UNSQUASH_DIR/usr/share/ca-certificates # TODO: i dont think this was necessary with PrecisePupppy

# copy /var files
cp -r  /var/lib/gems/            $UNSQUASH_DIR/var/lib/

# supress ruby 'insecure PATH' warning
chmod 775 /var

# implode filesystem
rm $LIVECD_DIR/$INPUT_SFS
mksquashfs $UNSQUASH_DIR $LIVECD_DIR/$OUTPUT_SFS -noappend
#rm -rf $UNSQUASH_DIR # or keep this around hd space permitting ~800MB

# create ISO image
cd /mnt/home
mkisofs -b isolinux.bin -c boot.cat -D -l -R -v -no-emul-boot -boot-load-size 4 -boot-info-table -o $ISO_FILENAME $LIVECD_DIR
#rm -rf $LIVECD_DIR   # or keep this around hd space permitting ~400MB
