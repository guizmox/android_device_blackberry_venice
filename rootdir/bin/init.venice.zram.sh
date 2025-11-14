#!/system/bin/sh

mem_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')

mem_mb=$((mem_kb / 1024))

if [ "$mem_mb" -lt 3500 ]; then
    log -t Configure zram "RAM < 4GB"
    echo 80 > /proc/sys/vm/swappiness
    echo 20 > /proc/sys/vm/vfs_cache_pressure
    echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
    echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
    echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
    echo 20 > /proc/sys/vm/dirty_background_ratio
    echo 40 > /proc/sys/vm/dirty_ratio
    echo 128 > /sys/block/mmcblk0/queue/read_ahead_kb
else
    log -t Configure zram "RAM >= 4GB"
    echo 30 > /proc/sys/vm/swappiness
    echo 60 > /proc/sys/vm/vfs_cache_pressure
    echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
    echo 256 > /sys/block/mmcblk0/queue/read_ahead_kb
fi
