#!/sbin/bb/busybox ash
bb="/sbin/bb/busybox"

$bb mount -o rw,remount /system

if [ ! -e /system/lib/hw/power.tuna.so.bak ]; then
 $bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
fi

$bb rm -rf /system/lib/hw/power.tuna.so
$bb cp /sbin/power.tuna.so /system/lib/hw
$bb chmod 644 /system/lib/hw/power.tuna.so
$bb chmod 644 /system/lib/hw/power.tuna.so.bak

$bb mount -o ro,remount /system
