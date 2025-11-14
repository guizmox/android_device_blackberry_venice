#!/system/bin/sh

pm trim-caches 9999999999
am kill-all

sync
echo 3 > /proc/sys/vm/drop_caches

fstrim -v /data
fstrim -v /cache

log -t venice_maintenance "RAM cleanup + Storage trim done."