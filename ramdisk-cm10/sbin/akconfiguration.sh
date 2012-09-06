#!/sbin/bb/busybox ash

bb="/sbin/bb/busybox"
log="/data/ak-boot.log"
logbck="/data/ak-boot.log.bck"

$bb cp -vr $log $logbck
$bb rm -rf $log

exec >>$log 2>&1

$bb echo ""
$bb echo "Fix power.tuna.so Lib -----------------------------------"
$bb date >>$log
$bb echo "List .so libraries:"
$bb ls -l /system/lib/hw/
$bb date >>$log
$bb echo "End -----------------------------------------------------"
$bb echo ""

$bb echo ""
$bb echo "Copy modules Lib ----------------------------------------"
$bb date >>$log
$bb echo "List .ko libraries:"
$bb ls -l /system/lib/modules/
$bb date >>$log
$bb echo "End -----------------------------------------------------"
$bb echo ""

exit
