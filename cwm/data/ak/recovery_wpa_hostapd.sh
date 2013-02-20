#!/system/bin/sh
# Script for Recovery 4.2.2 Wpa and Hostapd

echo "Coping Files to System Dir ..."

cp -vr /data/ak/backup/hostapd /system/bin
cp -vr /data/ak/backup/hostapd_cli /system/bin
cp -vr /data/ak/backup/wpa_supplicant /system/bin
cp -vr /data/ak/backup/wpa_cli /system/bin

echo "Recovery Done ..."
