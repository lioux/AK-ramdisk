#!/system/bin/sh
# Script for Recovery 4.2.2 Wpa and Hostapd

mount -o rw,remount /system

echo "Coping Files to System Dir ..."

cp -vr /data/ak/backup/hostapd /system/bin
cp -vr /data/ak/backup/hostapd_cli /system/bin
cp -vr /data/ak/backup/wpa_supplicant /system/bin
cp -vr /data/ak/backup/wpa_cli /system/bin

chown root:shell /system/bin/hostapd
chown root:shell /system/bin/hostapd_cli
chown root:shell /system/bin/wpa_supplicant
chown root:shell /system/bin/wpa_cli

chmod 755 /system/bin/hostapd
chmod 755 /system/bin/hostapd_cli
chmod 755 /system/bin/wpa_supplicant
chmod 755 /system/bin/wpa_cli

echo "Recovery Done ..."

mount -o ro,remount /system
