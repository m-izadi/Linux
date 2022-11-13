# sysfs
  - sysfs is a pseudo file system provided by the Linux kernel that exports information about various kernel subsystems, hardware devices, and associated device drivers from the kernel's device model to user space through virtual files
  - sudo file system / 
  - in kernel memory     
  - vaghan faile haye system nistan dakel hafezeye kernel hastan
  - module haye sakht afzari dakhelesh neshon dade mishe

# dbus
  - D-Bus is a message bus system, a simple way for applications to talk to one another. In addition to interprocess communication, D-Bus helps coordinate process lifecycle; it makes it simple and reliable to code a "single instance" application or daemon, and to launch applications and daemons on demand when their services are needed.

# proc
  * The proc filesystem is a pseudo-filesystem which provides an
    interface to kernel data structures.  It is commonly mounted at
    /proc.  Typically, it is mounted automatically by the system, but
    it can also be mounted manually using a command such as:

        mount -t proc proc /proc

    Most of the files in the proc filesystem are read-only, but some
    files are writable, allowing kernel variables to be changed.

  - IRQ
    * The Interrupt Request line is a physical line from the card to the CPU through which to send interrupt signals - in others words, when the device needs the immediate attention of the CPU. Typically, each expansion card needs to have a dedicated IRQ line through which it can "interrupt" the microprocessor when it needs to. There are usually 16 IRQ lines (from 0-15), of which many are reserved by the system. Here is the list of IRQ lines and their assignment in most AT through Pentium computers:
  - I/O Address (or I/O channel)
    * Each expansion card or peripheral is given its own 3-digit hex number which is used to identify its "address" within the operating system. This address is used to signal the card or device, and send or receive data to/from it.
  - DMA Channels (Faster than I/O )
    * Direct Memory Access (DMA) permits expansion cards and peripherals to directly access memory (as the name suggests) without going via the CPU. This means it's much faster and keeps the CPU undistracted from its other tasks. In a typical PC there are 8 DMA channels available, as follows:


# ls 
   #lsusb
    ls usb

   #lsblk
    ls block

   #lspci
    ls pci

   #lshw
    ls hardware 

   #lsmod
     tamam module haiye ke kernel load karde ro neshon mide
     ba #rmmod mitonim module ha ra pak konim

# loadable kernel modules
  #lsmod
  #rmmod "module"
  #insmod "location/module.ko" or modprobe "module"


## الپیک ۱ - ۰۰۸ - بخش ۱۰۱.۲ - قسمت ۲/۲ - روند بوت شدن سیستم؛ سیستم‌دی، سیستم۵، ژورنال و لاگ‌ها
# How to Power on System
## 1- firmware - POST (Power on system test)
## 2- Boot Loader
## 3- Kernel
  - Those are stored in ***initrd*** or ***initramfs*** alongside the kernel and used during the boot (provide minimum kernel resource for load driver disk & other )
  - save kernel log in ***kernel ring buffer*** for dont lost log and save later in ***cat /var/log/dmesg*** or ***cat /var/log/boot.log***
  #### you can see this log with **dmesg** or **cat /var/log/dmesg** or **cat /var/log/boot.log**
      # journalctl -k
      # journalctl -b
      # journalctl -u kernel

## 4- kernel run init 
  ### init run other proccess
      (The kernel can run other processes, but the kernel becomes crowded and difficult to troubleshoot, and if the process fails, it may crash. )
  ### There are different init systems:
   - **SysVinit** is based on Unix System V. Not being used much but people loved it and you may see it on older machines or even on recently installed ones
   - **systemd** is the new replacement. Some people hate it but it is being used by all the major distros. Can start services in parallel and do lots of fancy stuff!
   - **upstart** was an event-based replacement for the traditional init daemon. The project was started in 2014 by Canonical (the company behind Ubuntu) to replace the SysV but did not continue after 2015 and Ubuntu is now using the systemd as its init system.
  #### find our init
         # which init
         # ls -ltrh /usr/sbin/init
         # readlink -f /usr/sbin/init
         # ps -p 1 (proccess id 1)
         # pstree
  ### Unit
    The systemd is made around units. A unit can be a service, group of services, or an action. Units do have a name, a type, and a configuration file. There are 12 unit types: automount, device, mount, path, scope, service, slice, snapshot, socket, swap, target & timer.
    # systemctl list-units
       # systemctl list-units --type=target
       # systemctl get-default 
            default target (groups of services are started via target unit files)
       # systemctl cat cups  (all of data for service and target - how to run - dependency after failure & ... )
           ***Note: target has parent of services and start taget is start all of child services ***
  ### all of service
        # cd /usr/lib/systemd/system
        # graphical.target
    **Target**:
        target has parent of services and start taget is start all of child services*** 
        # systemctl cat cups  (all of data for service and target - how to run - dependency after failure & ... )




## الپیک ۱ - ۰۰۹ - بخش ۱۰۱.۳ - قسمت ۱/۲ - ران لول‌ها و تارگت ها - مفاهیم و تغییر
# Runlevel & Target
  # systemd runlevel
    # sudo systemctl list-units --type=target 
            UNIT                   LOAD   ACTIVE SUB    DESCRIPTION                  
            basic.target           loaded active active Basic System                 
            bluetooth.target       loaded active active Bluetooth                    
            cryptsetup.target      loaded active active Local Encrypted Volumes      
            getty.target           loaded active active Login Prompts                
            graphical.target       loaded active active Graphical Interface          
            local-fs-pre.target    loaded active active Local File Systems (Pre)     
            local-fs.target        loaded active active Local File Systems           
            multi-user.target      loaded active active Multi-User System            
            network-online.target  loaded active active Network is Online            
            network.target         loaded active active Network                      
            nss-lookup.target      loaded active active Host and Network Name Lookups
            nss-user-lookup.target loaded active active User and Group Name Lookups  
            paths.target           loaded active active Paths                        
            remote-fs.target       loaded active active Remote File Systems          
            slices.target          loaded active active Slices                       
            sockets.target         loaded active active Sockets                      
            sound.target           loaded active active Sound Card                   
            swap.target            loaded active active Swap                         
            sysinit.target         loaded active active System Initialization        
            time-set.target        loaded active active System Time Set              
            time-sync.target       loaded active active System Time Synchronized     
            timers.target          loaded active active Timers
    #  systemctl cat multi-user.target
            # /lib/systemd/system/multi-user.target
            #  SPDX-License-Identifier: LGPL-2.1+
            #
            #  This file is part of systemd.
            #
            #  systemd is free software; you can redistribute it and/or modify it
            #  under the terms of the GNU Lesser General Public License as published by
            #  the Free Software Foundation; either version 2.1 of the License, or
            #  (at your option) any later version.

            [Unit]
            Description=Multi-User System
            Documentation=man:systemd.special(7)
            Requires=basic.target
            Conflicts=rescue.service rescue.target
            After=basic.target rescue.service rescue.target
            AllowIsolate=yes

    # systemctl get-default 
    # systemctl status multi-user.target 

### It is also possible to isolate any of the targets or move to two special targets too:

  * **rescue**: Local file systems are mounted, there is no networking, and only root user (maintenance mode)
  * **emergency**: Only the root file system and in read-only mode, No networking and only root (maintenance mode)
  * **reboot**
  * **halt**: Stops all processes and halts CPU activities
  * **poweroff**: Like halt but also sends an ACPI shutdown signal (no lights!)

### go to run level & tshould
    # systemctl isolate rescue
    # systemctl is-system-runnig
      maintenance

# SysV runlevels
### On SysV we were able to define different stages. On a red hat based system we usually had 7:

0- Shutdown
1- Single-user mode (recovery); also called S or s
2- Multi-user without networking
3- Multi-user with networking
4- to be customized by the admin
5- Multi-user with networking and graphics
6- Reboot

### And in Debian based system we had:

0- Shutdown
1- Single-user mode
2- Multi-user mode with graphics
6- Reboot

#### change beetwin runlevel
    # init 6 (reboot)
    # sudo runlevel
#### runlevel config
  - You can check your current runlevel with **runlevel** command. It comes from SysV era but still works on systemd systems. The default was in **/etc/inittab** (in old distibute)
  - in sudo cd /etc/init.d have bashscript to start or stop service

  - /etc/rc0.d ta rc6.d/

    - ls -ltrh  /etc/rc3.d
      if start name whit **S** this service start in this runlevel
      and have **K** kill the servic in the runlevel


# loggin massege
    
    # sudo nano /etc/motd
        write messege

    # who -T 
        will show user mesg status

# Unix directories - Filesystem Hierarchy Standard (FHS)


Directory   |   Description                                         |                     
/bin	      |   Essential command binaries  فایل ها مهم سیستمی                        |                     
/boot       |   Static files of the boot loader                     |                     
/dev	      |   Device files                                        |                     
/etc        | 	Host-specific system configuration                  |                     
/home       |   Home directory of the users                         |                     
/lib	      |   Essential shared libraries and kernel modules       |                     
/media	    |   Mount point for removable media                     |                     
/mnt	      |   Mount point for mounting a filesystem temporarily   |                     
/opt	      |   Add-on application software packages                |                     
/root       |   Home directory of the root user                     |                     
/sbin	      |   Essential system binaries   فایل های خیلی مهمی ک معمولا یوزر روت دسترسی داره|                     
/srv	      |   Data for services provided by this system           |                     
/tmp	      |   Temporary files, sometimes purged on each boot      |                     
/usr	      |   Secondary hierarchy                                 |                     
/var	      |   Variable data (logs, ...)                           |                     

  ### chnage option
    # cp /bin/ping /bin/p
    or
    # cp /usr/bin/ping /usr/bin/p
      ╰─$ p 1.1.1.1
      PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
      64 bytes from 1.1.1.1: icmp_seq=1 ttl=52 time=94.9 ms
      64 bytes from 1.1.1.1: icmp_seq=2 ttl=52 time=106 ms

    # sudo cp traceroute tr
    or
    # sudo cp /usr/bin/traceroute /usr/bin/tr             
      ╰─$ tr 1.1.1.1
      traceroute to 1.1.1.1 (1.1.1.1), 30 hops max, 60 byte packets
       1  _gateway (192.168.1.254)  3.511 ms  3.880 ms  3.853 ms
       2  5.106.2.50 (5.106.2.50)  7.105 ms  7.080 ms  7.799 ms

nano /opt/google/chrome/cron/google-chrome

# الپیک ۱ - ۰۱۲ - بخش ۱۰۲.۱ - ۲/۲ - طراحی ترکیب هارد دیسک - پارتیشن‌ها

    # sudo fdisk /dev/sdb 
    # sudo mount
    # sudo mount |grep sda
#### LVM Logical volium managment (full covered in lpic 2)

  * **Physical Volume (PV)**: A whole drive or a partition. It is better to define partitions and not use whole disks - unpartitioned.

  * **Volume Groups (VG)**: This is the collection of one or more PVs. OS will see the vg as one big disk. PVs in one VG, can have different sizes or even be on different physical disks.

  * **Logical Volumes (LV)**: OS will see lvs as partitions. You can format an LV with your OS and use it.


### lvdisplay





### partition size
/boot = 100M or 1G
/swap = Ram + 2 or Ram +4 or Ram * 2
/     = 30G
/home = 900G

Server
/boot = 100M or 1G
/swap = Ram + 2 or Ram +4 or Ram * 2
/     = 30G
/var/log  = 100G
/usr
/opt
/home



### Swap
  * system when go to hibernate all of data in the ram write in swap becuse ram dont have power and when system power on write data from swap to ram an resume job
        #  free  -h
        # swapon    (see swap location)
  ### Zram
    * In short zram is a virtual disk on your RAM which can be used as a swap space or be mounted anywhere you like
   **(dar z ram bakhshi az ram datahaye dakhelesh feshorde sazi mishe o baes mishe ram bishrati dar dastres dashte bashim)**

  - Debian 11; uses a swap partition
  - Ubuntu 22.04; uses a swap file
  - Fedora 36; uses zram

### BootLoader
- BIOS
  * get up pc
  * power on freamware
    * run freamware
    * POST (Power On Self Test)
  **Most systems use BIOS or UEFI. When on BIOS, system will do a self test called POST. Then it will hand over the boot process to the first sector of master boot record (MBR) which is track (Cylinder) 0, side (Head) 0 and Sector 1 of the first disk.**

  **MBR is only 512 bytes so we need a smart bootloader to handle larger boot managers and even multiple systems. Some of these boot loaders are LILO, GRUB and GRUB2.**
- UEFI


  **If the system is using UEFI, the hardware will follow UEFI stages. They start with a security phase and will continue till the end phase where the UEFI looks for a EFI System Partition, that is just a FAT32 partition (usually the first one, but that's implementation defined) with PE executables and runs them.**

#### Dual Boot
    # In both cases, the binary starts the boot loader. It might be a complete bootloader on /boot/efi/ of your computer or a small loader for the main grub on the MBR or a windows loader or even a chainloader.
  **Chain Loading is when a boot loader, loads another boot loader. This is done when a Linux bootloader needs to start a Windows system.**


  * GRUB Legacy (old version not use)
  * GRUB 2  (newest version & )


# الپیک ۱ - ۰۱۵ - ماجول ۱۰۲.۲ - نصب و استفاده از بوت از بوت لودرها - قسمت دو از دو: گراب لگاسی
###### https://linux1st.com/1022-install-a-boot-manager.html
--------------------------------------------------------------------------
**bios:** /boot/grub/grub.cfg
**uefi:** /boot/efi/EFI/distro-name/


Option          |	Description

menuentry       |	Defines a new menuentry
set root        |	Defines the root where /boot located
linux, linux16  |	Defines the location of the Linux kernel on BIOS systems
linuxefi        |	Defines the Linux kernel on UEFI systems
initrd          |	Defines the initramfs image for BIOS systems
initrdefi       |	Defines the initramfs image for UEFI systems


# GRUB2 commands
  - Install GRUB 
      * **grub-install /dev/sda**
      * after changing the config files, you need to issue **grub2-mkconfig** or **grub-mkconfig**
      * It reads the configuration files from **/etc/grub.d/** and **/etc/default/grub/** and create the **grub.cfg** file based on them
You run it like this:
## Generate new Grub config
    # grub2-mkconfig > /boot/grub2/grub.cfg
      or
    # grub2-mkconfig -o /boot/grub2/grub.cfg

There is also a command called update-grub as a frontend to grub-mkconfig which runs grub-mkconfig -o /boot/grub/grub.cfg

# grub basic config
### nano /etc/default/grub
        # GRUB_DEFAULT=0
        ## GRUB_TIMEOUT_STYLE=hidden  (when GRUB_TIMEOUT=0 dont show grub skip)
        # GRUB_TIMEOUT=5   (wait 5 second for grub)
        # GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
        # GRUB_CMDLINE_LINUX_DEFAULT="quiet"
        # GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"
grub-mkconfig > /boot/grub/grub.cfg ( generate new config from /etc/default/grub and /etc/grubd/ files )
**NOTE:** GRUB_TIMEOUT=5 and GRUB_TIMEOUT_STYLE=hidden show grub grapical config when system power on
# Update Grub
in grub enter **c** and go to **Grub Command line**
    # grub> ls (ls show hard disk)

    # grub> ls (hd0,gpt1)/     (sho all file in partition aval disk aval)
    # grub> linux vmlinuz-4.19.0.19-amd64 ro root=/dev/sda1 (or root=UUID=(find in grub orgin))
    or
    # grub> linux vmlinuz-4.19.0.19-amd64 ro root=/dev/mapper/OS-root 
    # grub> initrd.img-4.19.0.19-amd64
    # grub> boot

**NOTE:**you can update GRUB config with command ***update-grup***
Option                    Description
console=                 	Set the console
debug                     Start in debug mode
init=                    	Run an specific program instead of the default init
initrd=     	            Use this initrd
ro        	              Mount the root filesystem read only
rw        	              Mount the root filesystem for read and write
root=         	          Use this as the root filesystem
selinux	                  Disable selinux on boot
single,S,1,Single      	  Boot in single user mode for troubleshooting (SysV)
systemd.unit=            	Boot in this systemd target


# الپیک ۱ - ۰۱۶ - ماجول ۱۰۲.۳ - مدیریت کتابخانه‌های اشتراکی Manage Shared Libraries

### library

    # ldd /usr/bin/ls
### ldd
The ldd command helps you find:

  * If a program is dynamically or statically linked
  * What libraries a program needs
            # ldd /usr/bin/ls


config ldd
    # ldconfig
    # locate ldconfig
    # ldd /user/sbin/ldconfig
          staticaly linked  



file /usr/bin/ls
elf execute file (yani system midone in file ro chejori ejra kone)

readelf -W1 /usr/bin/ls
 /usr/lib64/ld-linux-x86-64.so.2 /usr/bin/ls


# کار کردن در خط فرمان - درک مفهوم شل (پوسته) و بش و دستورات مقدماتی 103.1


for extre feature install terminator


type cd
type ping
type vim

~ (tilda) refeer to /home/user/
## Get full infirmation from system
    # uname -a


 echo -e "\n\n\nali\n\a"
    \a = bell(Alart)
    \n = enter
touch a\ b
  \ (\space) = space ro carecter dar nazar migirad


## enviromental
    # env
    # echo $NAME
    # NAME=Tito
    # unset NAME      ( Remove variable )

  which vim
  whereis vim
  whatis vim



### Change Promt ( tito@tito:/home$ )
    # echo $PS1
    PS1=%(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
    
    # \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$

    # unset PS1



### IF You want to clear your history 
    # HISTSIZE=0





# الپیک ۱ - ۰۲۴ - بخش ۱۰۳.۲ - فیلتر استریم‌های متنی با دستورات گنو - قسمت ۱/۴ - مشاهده فایل‌ها

cat
دیدن محتویات فایل زیپ شده
zcat test.txt.gz
bzcat test.txt.gz
xzcat test.txt.gz
gzcat test.txt.gz



# Octal Dump & Hexzmal  |   User By Crackers
od -a Filename.txt
od -t c Filename.txt
od -c Filename.txt



# Split         تکه تکیه کردن فایل

برای جداسازی فایل ها استفاده میشه کاربردش هم برای انتقال راحت تر فایل های سنگین به مکان های دیگر

    # split -l 2 mytxt.txt        فایل متنی رو ۲ خط ۲ خط جدا میکنه و فایل های مختلف میسازه مثلا اگر ۵ خط باشه ۳ فایل درست میکنه
    # cat x* > myfile.txt   با این دستور میتونیم فایل هارو به هم بچسبونیم

    # split -b 2048 mytxt.txt       فایل هارو ۲ گیگ ۲ گیگ جدا میکنه

    # split -d -n  2048 mytxt.txt newfile         به ده تیکه با اسم نیوفایل تقسیم میکنه


# Head & Tail
    - head mytxt      ده خط اول رو نمایش میده
    - tail mytxt      ده خط اخر رو نمایش میده


# Tmux
  https://tmuxcheatsheet.com/
    - tmux ls
    - tmux attach -t database
    - tmux new -s database
    - 
    - tmux rename-session -t 0 database
    - Ctrl + b c                          New Session
    - Ctrl + b ,                          Rename current window
    - Ctrl + b n                          Next window
    - Ctrl + b 0 ... 9                    Switch/select window by number
    - Ctrl + b &                          Close current window
    - Ctrl + b s                          show all sessions
    - Ctrl + b w                          List windows
    - Ctrl + b d                          deattach
    -
    - Ctrl + b {                          Move the current pane left
    - Ctrl + b Spacebar                   Change Layouts
    - :setw synchronize-panes             send command to all Screen
    - 
    - 
    - 
    - 















































# Important Topic


  ## Target
    target has parent of services and start taget is start all of child services*** 
    # systemctl cat cups  (all of data for service and target - how to run - dependency after failure & ... )
  ## systemd & systemctl ( all of service )
    # cd /usr/lib/systemd/system
      # ls
      # graphical.target
      # systemctl status sshd
      # systemctl is-active sshd
      # systemctl is-failed sshd
      # systemctl restart sshd
      # systemctl reload sshd
      # systemctl daemon-reload sshd
      # systemctl enable sshd
      # systemctl disable sshd
    # systemctl is-system-running
    # systemctl --failed
## Journalctl
    # journalctl                          # show all journal
    # journalctl --no-pager               # do not use less
    # journalctl -n 10                    # only 10 lines
    # journalctl -S -1d                   # last 1 day
    # journalctl --since "10 min ago"     # last 1 day
    # journalctl -xe                      # last few logs
    # journalctl -u sshd                  # only ssh unit
    # journalctl _PID=1234

## Swap
    # system when go to hibernate all of data in the ram write in swap becuse ram dont have power and when system power on write data from swap to ram an resume job

**Note**: There is no strict formula for swap size. People used to say "double the ram but not more than 8GB". On recent machines with SSDs, some say "RAM + 2" (Hibernation + some extra ) or "RAM * 2" depending on your usage.