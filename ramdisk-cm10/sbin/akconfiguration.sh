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
$bb echo "Kernel Version:"
$bb cat /proc/version
$bb echo "END ------------------------------------------------";echo""

$bb echo "LAST REBOOT ----------------------------------------"
$bb date +"Last Reboot: %d.%m.%y / %H:%m" -d @$(( $(date +%s) - $(cut -f1 -d. /proc/uptime) ));
$bb echo "END ------------------------------------------------";echo""

$bb echo "ROM VERSION ----------------------------------------"
echo "Rom Version:"
getprop ro.modversion
getprop cm.version
getprop ro.build.description
getprop ro.build.date
getprop ro.build.display.id
getprop ro.build.id
$bb echo "END ------------------------------------------------";echo""

$bb echo "MEM INFO -------------------------------------------"
$bb echo "Mem Info:"
$bb free;
$bb cat /proc/meminfo;
$bb echo "END ------------------------------------------------";echo""

$bb echo "USB INFO -------------------------------------------"
$bb echo "Usb Info:"
lsusb
$bb echo "END ------------------------------------------------";echo""

$bb echo "LSMOD ----------------------------------------------"
$bb echo "Lsmod Info:"
lsmod
$bb echo "END ------------------------------------------------";echo""

$bb echo "PARTITIONS -----------------------------------------"
$bb echo "Partitions Info:"
mount
cat /proc/partitions
$bb echo "END ------------------------------------------------";echo""

$bb echo "LIST HW LIB ----------------------------------------"
$bb echo "List libraries:"
$bb ls -l /system/lib/hw/
$bb echo "END ------------------------------------------------";echo""

$bb echo "LIST MODULE LIB ------------------------------------"
$bb echo "List libraries:"
$bb ls -l /system/lib/modules/
$bb echo "END ------------------------------------------------";echo""

exit
