#!/system/bin/sh
# Script for Recovery 4.2.2 Wpa and Hostapd

mount -o rw,remount /system

echo "Coping Files to System Dir ..."

sleep 10

rm -rf /system/bin/hostapd
cp -vr /data/ak/backup/hostapd /system/bin/hostapd
chown root:shell /system/bin/hostapd
chmod 755 /system/bin/hostapd

echo "Recovery Done ..."

mount -o ro,remount /system
