#!/sbin/bb/busybox ash
bb="/sbin/bb/busybox"

$bb mount -o rw,remount /system
$bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
$bb cp /sbin/power.tuna.so /system/lib/hw
$bb chmod 644 /system/lib/hw/power.tuna.so
$bb mount -o ro,remount /system

echo "0" > /sys/module/wakelock/parameters/debug_mask
echo "0" > /sys/module/userwakelock/parameters/debug_mask
echo "0" > /sys/module/earlysuspend/parameters/debug_mask
echo "0" > /sys/module/alarm/parameters/debug_mask
echo "0" > /sys/module/alarm_dev/parameters/debug_mask
echo "0" > /sys/module/binder/parameters/debug_mask