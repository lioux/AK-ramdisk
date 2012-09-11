#!/sbin/bb/busybox ash
bb="/sbin/bb/busybox"

$bb mount -o rw,remount /system
$bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
$bb cp /sbin/power.tuna.so /system/lib/hw
$bb chmod 644 /system/lib/hw/power.tuna.so
$bb mount -o ro,remount /system
