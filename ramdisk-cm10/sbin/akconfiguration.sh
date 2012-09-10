#!/sbin/bb/busybox ash

bb="/sbin/bb/busybox"
log="/data/ak-boot.log"
logbck="/data/ak-boot.log.bck"

$bb cp -vr $log $logbck
$bb rm -rf $log

exec >>$log 2>&1

$bb date >>$log

echo""

$bb echo "KERNEL INFO ----------------------------------------"
$bb echo "Kernel-Version:"
$bb cat /proc/version
$bb echo "END -----------------------------------------------------";echo""

$bb echo "LAST REBOOT ----------------------------------------"
$bb date +"Last Reboot: %d.%m.%y / %H:%m" -d @$(( $(date +%s) - $(cut -f1 -d. /proc/uptime) ));
$bb echo "END -----------------------------------------------------";echo""

$bb echo "LIST HW LIB -----------------------------------"
$bb echo "List libraries:"
$bb ls -l /system/lib/hw/
$bb echo "END -----------------------------------------------------";echo""

$bb echo "LIST MODULE LIB ----------------------------------------"
$bb echo "List libraries:"
$bb ls -l /system/lib/modules/
$bb echo "END -----------------------------------------------------";echo""

exit
