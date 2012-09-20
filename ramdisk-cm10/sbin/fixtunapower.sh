#!/sbin/bb/busybox ash
bb="/sbin/bb/busybox"

$bb mount -o rw,remount /system
$bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
$bb cp /system/lib/hw/power.default.so /system/lib/hw/power.default.so.bak
$bb rm -rf /system/lib/hw/power.tuna.so
$bb rm -rf /system/lib/hw/power.default.so
#$bb cp /sbin/power.tuna.so /system/lib/hw
#$bb chmod 644 /system/lib/hw/power.tuna.so
$bb chmod 644 /system/lib/hw/power.tuna.so.bak
$bb chmod 644 /system/lib/hw/power.default.so.bak
$bb mount -o ro,remount /system
