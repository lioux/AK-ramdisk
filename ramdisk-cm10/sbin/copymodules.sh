#!/sbin/bb/busybox sh

bb="/sbin/bb/busybox"
log="/data/ak-boot.log"

$bb mount -o rw,remount /system

exec >>$log 2>&1

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