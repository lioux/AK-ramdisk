#!/sbin/bb/busybox sh

bb="/sbin/bb/busybox"
log="/data/ak-boot.log"

$bb mount -o rw,remount /system

exec >>$log 2>&1

$bb echo ""
$bb echo "Fix power.tuna.so Lib -----------------------------------"
$bb date >>$log

$bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
$bb cp /sbin/files/hw/power.tuna.so /system/lib/hw
$bb chmod 644 /system/lib/hw/power.tuna.so

$bb echo "List .so libraries:"
$bb ls -l /system/lib/hw/

$bb date >>$log
$bb echo "End -----------------------------------------------------"
$bb echo ""

$bb mount -o ro,remount /system

exit