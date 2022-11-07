# IOPS
=====
# iostat Document
    iostat -xd      =
    iostat -p       =
    iostat -d       =
    iostat -dx 1    =   Continuously Refreshing
    iostat -d sda   =   Total Info

    Reads/second only:
        # iostat -dx sda | grep sda | awk '{ print $4; }'

    Writes/sec only:
        # iostat -dx sda | grep sda | awk '{ print $5; }'

    Reads/sec and writes/sec separated with a slash:
        # iostat -dx sda | grep sda | awk '{ print $4"/"$5; }'

    Overall IOPS (what most people talk about):
        # iostat -d sda | grep sda | awk '{ print $2; }'

**Link:** https://unix.stackexchange.com/questions/225095/how-to-get-total-read-and-total-write-iops-in-linux







## iostat   Information
        # The IOPS for this device xvda is r/s + w/s = 100 + 50 =150
        # “r/s”         =   reads per second
        # “w/s”         =   writes per second
        # rkB/s         =   kilobytes read per second
        # wkB/s         =   kilobytes written per second
        # avgrq-sz      =   average size of each request in sectors
        # avgqu-sz      =   average queue length of the requests
        # “await”       =   average time (in milliseconds) that each request spent in the queue
        # “svctm”       =   average service time (in milliseconds) for each request
        # “%util”       =   percentage of time that the disk was active
        
**link:** https://unix.stackexchange.com/questions/225095/how-to-get-total-read-and-total-write-iops-in-linux



# Docker Test

# Details
This service run container & Test from **512B until the 8MB Blocks IOPs**

______________________________________________
# Output Examples
    # sudo docker run --rm -it --device=/dev/sda cxcv/iops --num-threads 2 /dev/sda
    /dev/sda, 240.06 G, sectorsize=512B, #threads=2, pattern=random:
     512  B blocks: 14715.8 IO/s,   7.5 MB/s ( 60.3 Mbit/s)
       1 kB blocks: 12144.9 IO/s,  12.4 MB/s ( 99.5 Mbit/s)
       2 kB blocks: 8804.0 IO/s,  18.0 MB/s (144.2 Mbit/s)
       4 kB blocks: 5641.7 IO/s,  23.1 MB/s (184.9 Mbit/s)
       8 kB blocks: 5625.0 IO/s,  46.1 MB/s (368.6 Mbit/s)
      16 kB blocks: 3420.9 IO/s,  56.0 MB/s (448.4 Mbit/s)
      32 kB blocks: 1994.6 IO/s,  65.4 MB/s (522.9 Mbit/s)
      65 kB blocks: 1527.8 IO/s, 100.1 MB/s (801.0 Mbit/s)
     131 kB blocks: 1474.4 IO/s, 193.3 MB/s (  1.5 Gbit/s)
     262 kB blocks:  738.3 IO/s, 193.5 MB/s (  1.5 Gbit/s)
     524 kB blocks:  438.9 IO/s, 230.1 MB/s (  1.8 Gbit/s)
       1 MB blocks:  267.2 IO/s, 280.2 MB/s (  2.2 Gbit/s)
       2 MB blocks:  139.8 IO/s, 293.2 MB/s (  2.3 Gbit/s)
       4 MB blocks:   87.2 IO/s, 365.6 MB/s (  2.9 Gbit/s)
       8 MB blocks:   48.6 IO/s, 408.0 MB/s (  3.3 Gbit/s)
      16 MB blocks:   24.6 IO/s, 412.7 MB/s (  3.3 Gbit/s)
      33 MB blocks:   11.9 IO/s, 398.3 MB/s (  3.2 Gbit/s)
      67 MB blocks:    6.6 IO/s, 443.7 MB/s (  3.5 Gbit/s)
     134 MB blocks:    3.3 IO/s, 438.6 MB/s (  3.5 Gbit/s)
     268 MB blocks:    1.6 IO/s, 420.6 MB/s (  3.4 Gbit/s)
     536 MB blocks:    0.7 IO/s, 383.4 MB/s (  3.1 Gbit/s)





**Link:** https://github.com/benschweizer/iops






# sar -d

Open and edit /etc/default/sysstat config file and change row from ENABLED=”false” to ENABLED=”true”

    # sudo /etc/default/sysstat
        ENABLED=”true”
    
    # sudo service sysstat restart
    # sar -d