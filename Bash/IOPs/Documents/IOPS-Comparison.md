**Note_1:**  The Tests are not accurate because the hard drives are under load
# 192.168.7.151
 Server Information

    # sudo fdisk -l
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disklabel type: gpt

# 192.168.7.156
 Server Information

    # sudo fdisk -l
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disklabel type: gpt





_______________________________________________________________________________
# IOSTAT 
    # Command
      # iostat -dx sda | grep sda | awk '{ print $4"/"$5; }'
    # Format
      # rkB/s         =   kilobytes read per second
      # wkB/s         =   kilobytes written per second
### Raid_1 192.168.7.151
    39.12/23.77 = IOPS = 62.89kB/s
    rkB/s / wkB/s
### Raid_10 192.168.7.156
    12.41/8.81  = IOPS = 21.22KB/s
    rkB/s / wkB/s


# HDPARM
    # Command
      # sudo hdparm -Tt /dev/sda
## Result:

Raid_1 192.168.7.151

    /dev/sda:
     Timing cached reads:   10526 MB in  1.99 seconds = 5298.09 MB/sec
     Timing buffered disk reads: 452 MB in  3.02 seconds = 149.89 MB/sec

Raid_10 192.168.7.156

    /dev/sda:
     Timing cached reads:   12428 MB in  1.99 seconds = 6236.44 MB/sec
     Timing buffered disk reads: 194 MB in  3.01 seconds =  64.52 MB/sec




________________________________________________________________________________________________________________
# Container Test
# Setup
    # Step 1
        sudo git clone https://github.com/benschweizer/iops
    # Step 2 
        cd iops
        sudo docker run --rm -it --device=/dev/sda cxcv/iops --num-threads 2 /dev/sda
        # test block by block
# Test:
sectorsize=512B, #threads=2, pattern=random:

                    |   Raid_1 192.168.7.151    |   Raid_10 192.168.7.156         
     512  B blocks: |  50.9 kB/s (407.3 kbit/s) |  13.1 kB/s (105.2 kbit/s)
       1 kB blocks: | 112.3 kB/s (898.2 kbit/s) |  57.0 kB/s (456.2 kbit/s)
       2 kB blocks: | 185.6 kB/s (  1.5 Mbit/s) | 112.8 kB/s (902.1 kbit/s)
       4 kB blocks: | 270.7 kB/s (  2.2 Mbit/s) | 203.5 kB/s (  1.6 Mbit/s)
       8 kB blocks: |  62.1 kB/s (496.6 kbit/s) | 308.3 kB/s (  2.5 Mbit/s)
      16 kB blocks: | 672.8 kB/s (  5.4 Mbit/s) | 538.2 kB/s (  4.3 Mbit/s)
      32 kB blocks: |   1.8 MB/s ( 14.5 Mbit/s) | 686.6 kB/s (  5.5 Mbit/s)
      65 kB blocks: |   4.7 MB/s ( 37.7 Mbit/s) |   2.0 MB/s ( 15.9 Mbit/s)
     131 kB blocks: |  14.6 MB/s (116.6 Mbit/s) |   4.3 MB/s ( 34.4 Mbit/s)
     262 kB blocks: |  20.7 MB/s (165.3 Mbit/s) |   2.5 MB/s ( 19.8 Mbit/s)
     524 kB blocks: |  39.7 MB/s (317.9 Mbit/s) |   2.7 MB/s ( 21.5 Mbit/s)
       1 MB blocks: |  58.5 MB/s (467.7 Mbit/s) |   9.9 MB/s ( 79.2 Mbit/s)
       2 MB blocks: |  80.5 MB/s (644.3 Mbit/s) |  42.4 MB/s (339.4 Mbit/s)
       4 MB blocks: |  93.5 MB/s (747.8 Mbit/s) |  52.8 MB/s (422.3 Mbit/s)
       8 MB blocks: | 113.1 MB/s (905.1 Mbit/s) |  65.5 MB/s (524.0 Mbit/s)
      16 MB blocks: | 140.1 MB/s (  1.1 Gbit/s) |  93.5 MB/s (747.9 Mbit/s)
      33 MB blocks: | 106.1 MB/s (848.9 Mbit/s) | 104.2 MB/s (833.5 Mbit/s)
      67 MB blocks: | 176.6 MB/s (  1.4 Gbit/s) | 113.0 MB/s (904.2 Mbit/s)
     134 MB blocks: | 159.4 MB/s (  1.3 Gbit/s) | 111.2 MB/s (889.5 Mbit/s)
     268 MB blocks: | 242.9 MB/s (  1.9 Gbit/s) |



# Raid_1 192.168.7.151  & pattern=random 
                    |          #threads=1                 #threads=2                    #threads=4
     512  B blocks: |  28.7 kB/s (229.4 kbit/s) |  47.2 kB/s (377.4 kbit/s)   | 69.1 kB/s (552.8 kbit/s)  |
       1 kB blocks: | 101.6 kB/s (812.6 kbit/s) |  90.9 kB/s (726.8 kbit/s)   | 134.0 kB/s (  1.1 Mbit/s) |
       2 kB blocks: | 143.2 kB/s (  1.1 Mbit/s) |  191.9 kB/s (  1.5 Mbit/s)  | 144.8 kB/s (  1.2 Mbit/s) |
       4 kB blocks: | 221.6 kB/s (  1.8 Mbit/s) |  104.0 kB/s (832.1 kbit/s)  | 180.1 kB/s (  1.4 Mbit/s) |
       8 kB blocks: | 351.2 kB/s (  2.8 Mbit/s) |  147.0 kB/s (  1.2 Mbit/s)  | 117.4 kB/s (939.2 kbit/s) |
      16 kB blocks: | 628.7 kB/s (  5.0 Mbit/s) |  1.1 MB/s (  8.7 Mbit/s)    | 137.2 kB/s (  1.1 Mbit/s) |
      32 kB blocks: |   1.8 MB/s ( 14.3 Mbit/s) |  2.2 MB/s ( 18.0 Mbit/s)    | 535.4 kB/s (  4.3 Mbit/s) |
      65 kB blocks: |   3.6 MB/s ( 29.1 Mbit/s) |  4.7 MB/s ( 37.7 Mbit/s)    | 5.7 MB/s ( 45.7 Mbit/s)   |
     131 kB blocks: |  11.6 MB/s ( 92.6 Mbit/s) |  11.0 MB/s ( 87.6 Mbit/s)   | 15.1 MB/s (120.7 Mbit/s)  |
     262 kB blocks: |  20.5 MB/s (163.8 Mbit/s) |  18.1 MB/s (144.7 Mbit/s)   | 23.6 MB/s (188.4 Mbit/s)  |
     524 kB blocks: |  30.6 MB/s (244.5 Mbit/s) |  36.4 MB/s (291.5 Mbit/s)   | 41.4 MB/s (331.3 Mbit/s)  |
       1 MB blocks: |  54.5 MB/s (435.9 Mbit/s) |  42.3 MB/s (338.2 Mbit/s)   | 62.2 MB/s (497.4 Mbit/s)  |
       2 MB blocks: |  51.2 MB/s (409.9 Mbit/s) |  78.2 MB/s (625.8 Mbit/s)   | 64.3 MB/s (514.7 Mbit/s)  |
       4 MB blocks: |  59.5 MB/s (476.2 Mbit/s) |  149.3 MB/s (  1.2 Gbit/s)  | 80.6 MB/s (645.1 Mbit/s)  |
       8 MB blocks: |  12.3 MB/s ( 98.2 Mbit/s) |  119.6 MB/s (957.2 Mbit/s)  | 92.1 MB/s (737.0 Mbit/s)  |
      16 MB blocks: | 114.1 MB/s (912.8 Mbit/s) |  115.8 MB/s (926.1 Mbit/s)  | 132.4 MB/s (  1.1 Gbit/s) |
      33 MB blocks: | 180.3 MB/s (  1.4 Gbit/s) |  121.9 MB/s (975.0 Mbit/s)  | 126.8 MB/s (  1.0 Gbit/s) |
      67 MB blocks: | 132.9 MB/s (  1.1 Gbit/s) |  127.6 MB/s (  1.0 Gbit/s)  | 197.8 MB/s (  1.6 Gbit/s) |
     134 MB blocks: | 152.8 MB/s (  1.2 Gbit/s) |  203.8 MB/s (  1.6 Gbit/s)  | 223.2 MB/s (  1.8 Gbit/s) |
     268 MB blocks: | 227.3 MB/s (  1.8 Gbit/s) |  146.9 MB/s (  1.2 Gbit/s)  | 108.9 MB/s (871.3 Mbit/s) |

# Raid_1 192.168.7.151  & pattern=sequential 

                    |         #threads=2          |         #threads=4         |
     512  B blocks: |  160.6 MB/s (  1.3 Gbit/s)  | 106.3 MB/s (850.8 Mbit/s)  |
       1 kB blocks: |  244.0 MB/s (  2.0 Gbit/s)  | 189.3 MB/s (  1.5 Gbit/s)  |
       2 kB blocks: |  278.6 MB/s (  2.2 Gbit/s)  | 284.6 MB/s (  2.3 Gbit/s)  |
       4 kB blocks: |  356.6 MB/s (  2.9 Gbit/s)  | 638.2 MB/s (  5.1 Gbit/s)  |
       8 kB blocks: |  504.6 MB/s (  4.0 Gbit/s)  | 923.9 MB/s (  7.4 Gbit/s)  |
      16 kB blocks: |  679.1 MB/s (  5.4 Gbit/s)  | 1.2 GB/s (  9.7 Gbit/s)    |
      32 kB blocks: |  828.0 MB/s (  6.6 Gbit/s)  | 1.2 GB/s (  9.7 Gbit/s)    |
      65 kB blocks: |   1.0 GB/s (  8.1 Gbit/s)   | 1.4 GB/s ( 11.3 Gbit/s)    |
     131 kB blocks: |   1.2 GB/s (  9.5 Gbit/s)   | 1.8 GB/s ( 14.3 Gbit/s)    |
     262 kB blocks: |   1.5 GB/s ( 11.6 Gbit/s)   | 2.0 GB/s ( 16.2 Gbit/s)    |
     524 kB blocks: |   1.6 GB/s ( 12.7 Gbit/s)   | 2.4 GB/s ( 19.0 Gbit/s)    |
       1 MB blocks: |   1.8 GB/s ( 14.1 Gbit/s)   | 2.7 GB/s ( 21.8 Gbit/s)    |
       2 MB blocks: |   1.9 GB/s ( 15.0 Gbit/s)   | 2.8 GB/s ( 22.5 Gbit/s)    |
       4 MB blocks: |   1.9 GB/s ( 15.4 Gbit/s)   | 3.0 GB/s ( 23.9 Gbit/s)    |
       8 MB blocks: |   2.1 GB/s ( 16.7 Gbit/s)   | 3.1 GB/s ( 25.2 Gbit/s)    |
      16 MB blocks: |   2.2 GB/s ( 17.7 Gbit/s)   | 3.3 GB/s ( 26.7 Gbit/s)    |
      33 MB blocks: |   2.2 GB/s ( 17.5 Gbit/s)   | 3.1 GB/s ( 24.8 Gbit/s)    |
      67 MB blocks: |   1.9 GB/s ( 15.1 Gbit/s)   | 2.3 GB/s ( 18.1 Gbit/s)    |
     134 MB blocks: |   2.1 GB/s ( 16.9 Gbit/s)   | 3.0 GB/s ( 23.9 Gbit/s)    |
     268 MB blocks: |   1.8 GB/s ( 14.5 Gbit/s)   | 2.0 GB/s ( 16.3 Gbit/s)    |
     536 MB blocks: |   1.3 GB/s ( 10.5 Gbit/s)   | 1.3 GB/s ( 10.4 Gbit/s)    |
       1 GB blocks: |  915.0 MB/s (  7.3 Gbit/s)  | -----------------------    |
__________________________________________________________________________________________________________________
# Raid_10 192.168.7.156  & pattern=random 
                    |         #threads=1                    #threads=2                    #threads=4           |
     512  B blocks: |   2.8 kB/s ( 22.1 kbit/s)   | 7.1 kB/s ( 57.2 kbit/s)     | 28.5 kB/s (228.1 kbit/s)     |
       1 kB blocks: |  25.8 kB/s (206.7 kbit/s)   | 4.0 kB/s ( 31.6 kbit/s)     | 46.0 kB/s (368.1 kbit/s)     |
       2 kB blocks: |  43.8 kB/s (350.4 kbit/s)   | 9.0 kB/s ( 71.6 kbit/s)     | 17.7 kB/s (141.3 kbit/s)     |
       4 kB blocks: |  59.7 kB/s (477.4 kbit/s)   | 6.7 kB/s ( 54.0 kbit/s)     | 22.9 kB/s (182.9 kbit/s)     |
       8 kB blocks: | 157.5 kB/s (  1.3 Mbit/s)   | 329.8 kB/s (  2.6 Mbit/s)   | 132.4 kB/s (  1.1 Mbit/s)    |
      16 kB blocks: | 343.6 kB/s (  2.7 Mbit/s)   | 189.9 kB/s (  1.5 Mbit/s)   | 903.4 kB/s (  7.2 Mbit/s)    |
      32 kB blocks: | 323.1 kB/s (  2.6 Mbit/s)   | 551.1 kB/s (  4.4 Mbit/s)   | 554.8 kB/s (  4.4 Mbit/s)    |
      65 kB blocks: | 544.7 kB/s (  4.4 Mbit/s)   | 1.4 MB/s ( 10.8 Mbit/s)     | 1.1 MB/s (  9.2 Mbit/s)      |
     131 kB blocks: |   2.3 MB/s ( 18.7 Mbit/s)   | 1.3 MB/s ( 10.6 Mbit/s)     | 1.4 MB/s ( 11.2 Mbit/s)      |
     262 kB blocks: |   3.7 MB/s ( 29.8 Mbit/s)   | 4.7 MB/s ( 37.6 Mbit/s)     | 2.3 MB/s ( 18.1 Mbit/s)      |
     524 kB blocks: |   5.0 MB/s ( 39.7 Mbit/s)   | 8.2 MB/s ( 65.5 Mbit/s)     | 3.0 MB/s ( 23.6 Mbit/s)      |
       1 MB blocks: |  13.8 MB/s (110.2 Mbit/s)   | 11.4 MB/s ( 91.2 Mbit/s)    | 5.0 MB/s ( 39.8 Mbit/s)      |
       2 MB blocks: |  22.6 MB/s (180.5 Mbit/s)   | 18.2 MB/s (145.7 Mbit/s)    | 7.6 MB/s ( 60.9 Mbit/s)      |
       4 MB blocks: |  22.9 MB/s (183.0 Mbit/s)   | 22.4 MB/s (179.5 Mbit/s)    | 16.2 MB/s (129.5 Mbit/s)     |
       8 MB blocks: |  20.2 MB/s (161.8 Mbit/s)   | 31.7 MB/s (253.3 Mbit/s)    | 24.2 MB/s (193.5 Mbit/s)     |
      16 MB blocks: |  35.2 MB/s (281.8 Mbit/s)   | 39.5 MB/s (315.8 Mbit/s)    | 18.5 MB/s (148.3 Mbit/s)     |
      33 MB blocks: |  30.0 MB/s (240.0 Mbit/s    | 44.2 MB/s (353.4 Mbit/s)    | 47.3 MB/s (378.0 Mbit/s)     |
      67 MB blocks: |  -----------------------    | 51.3 MB/s (410.5 Mbit/s)    | 38.1 MB/s (304.8 Mbit/s)     |

# Raid_10 192.168.7.156  & pattern=sequential 
                    |         #threads=2         |        #threads=4         |
     512  B blocks: |   12.2 MB/s ( 97.3 Mbit/s) | 15.8 MB/s (126.5 Mbit/s)  |
       1 kB blocks: |   18.0 MB/s (144.3 Mbit/s) | 59.7 MB/s (477.9 Mbit/s)  |
       2 kB blocks: |   73.0 MB/s (583.8 Mbit/s) | 164.3 MB/s (  1.3 Gbit/s) |
       4 kB blocks: |   93.6 MB/s (748.6 Mbit/s) | 377.4 MB/s (  3.0 Gbit/s) |
       8 kB blocks: |  153.8 MB/s (  1.2 Gbit/s) | 672.1 MB/s (  5.4 Gbit/s) |
      16 kB blocks: |  187.5 MB/s (  1.5 Gbit/s) | 1.6 GB/s ( 13.1 Gbit/s)   |
      32 kB blocks: |  220.3 MB/s (  1.8 Gbit/s) | 1.7 GB/s ( 13.2 Gbit/s)   |
      65 kB blocks: |  257.7 MB/s (  2.1 Gbit/s) | 2.1 GB/s ( 17.0 Gbit/s)   |
     131 kB blocks: |  285.8 MB/s (  2.3 Gbit/s) | 2.2 GB/s ( 17.6 Gbit/s)   |
     262 kB blocks: |  351.9 MB/s (  2.8 Gbit/s) | 2.2 GB/s ( 18.0 Gbit/s)   |
     524 kB blocks: |  384.6 MB/s (  3.1 Gbit/s) | 2.3 GB/s ( 18.1 Gbit/s)   |
       1 MB blocks: |  406.3 MB/s (  3.3 Gbit/s) | 2.4 GB/s ( 19.2 Gbit/s)   |
       2 MB blocks: |  447.7 MB/s (  3.6 Gbit/s) | 2.5 GB/s ( 19.7 Gbit/s)   |
       4 MB blocks: |  389.8 MB/s (  3.1 Gbit/s) | 2.6 GB/s ( 20.6 Gbit/s)   |
       8 MB blocks: |  507.1 MB/s (  4.1 Gbit/s) | 2.7 GB/s ( 21.7 Gbit/s)   |
      16 MB blocks: |  447.4 MB/s (  3.6 Gbit/s) | 2.7 GB/s ( 21.5 Gbit/s)   |
      33 MB blocks: |  574.1 MB/s (  4.6 Gbit/s) | 2.7 GB/s ( 21.3 Gbit/s)   |
      67 MB blocks: |  473.5 MB/s (  3.8 Gbit/s) | 2.8 GB/s ( 22.0 Gbit/s)   |
     134 MB blocks: |  525.2 MB/s (  4.2 Gbit/s) | 1.1 GB/s (  8.9 Gbit/s)   |
     268 MB blocks: |  234.2 MB/s (  1.9 Gbit/s) | 781.6 MB/s (  6.3 Gbit/s) |
     536 MB blocks: |  ------------------------- | 414.2 MB/s (  3.3 Gbit/s) |



