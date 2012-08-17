#!/sbin/bb/busybox ash

bb="/sbin/bb/busybox"
log="/data/ak-boot.log"
logbck="/data/ak-boot.log.bck"

$bb mount -o rw,remount /system

$bb cp -vr $log $logbck
$bb rm -rf $log

exec >>$log 2>&1

$bb echo ""
$bb echo "Fix power.tuna.so Lib -----------------------------------"
$bb date >>$log

$bb cp /system/lib/hw/power.tuna.so /system/lib/hw/power.tuna.so.bak
$bb cp /sbin/files/hw/power.tuna.so /system/lib/hw
$bb chmod 644 /system/lib/hw/power.tuna.so

echo "0" > /sys/module/wakelock/parameters/debug_mask
echo "0" > /sys/module/userwakelock/parameters/debug_mask
echo "0" > /sys/module/earlysuspend/parameters/debug_mask
echo "0" > /sys/module/alarm/parameters/debug_mask
echo "0" > /sys/module/alarm_dev/parameters/debug_mask
echo "0" > /sys/module/binder/parameters/debug_mask

$bb echo "List .so libraries:"
$bb ls -l /system/lib/hw/

$bb date >>$log
$bb echo "End -----------------------------------------------------"
$bb echo ""

$bb echo ""
$bb echo "Copy modules Lib ----------------------------------------"
$bb date >>$log

if $bb [ ! -d /system/lib/modules ]; then   
    $bb echo "Module Directory not found ... Making it ..."
    $bb mkdir /system/lib/modules
    $bb chmod 777 /system/lib/modules
fi

$bb rm -rf /system/lib/modules/*
$bb cp -vr /sbin/files/modules/* /system/lib/modules/
$bb chmod 644 /system/lib/modules/*

$bb echo "List .ko libraries:"
$bb ls -l /system/lib/modules/

$bb date >>$log
$bb echo "End -----------------------------------------------------"
$bb echo ""

$bb mount -o ro,remount /system

exit
