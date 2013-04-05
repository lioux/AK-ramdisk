#!/bin/bash

process=$1
pid=`pgrep $process`
[ -z "$pid" -o ! -d "/proc/$pid" ] && echo please input a valid process name && exit 1

cpu_num=`grep cpu /proc/stat | wc -l`
let cpu_num=cpu_num-1

read usertime nicetime systemtime idletime ioWait irq softIrq steal tails < <(cat /proc/stat | sed '/cpu\s/!d; s/cpu//')
let idlealltime=idletime+ioWait
let systemalltime=systemtime+irq+softIrq+steal
let oldtotal=usertime+nicetime+systemalltime+idlealltime
read utime stime < <(cat /proc/$pid/stat | awk '{print $14, $15}')
let old_process_time=utime+stime

while true; do
	sleep 1

	read usertime nicetime systemtime idletime ioWait irq softIrq steal tails < <(cat /proc/stat | sed '/cpu\s/!d; s/cpu//')
	let idlealltime=idletime+ioWait
	let systemalltime=systemtime+irq+softIrq+steal
	let totaltime=usertime+nicetime+systemalltime+idlealltime
	let period=(totaltime-oldtotal)/cpu_num
	read utime stime < <(cat /proc/$pid/stat | awk '{print $14, $15}')
	let process_time=utime+stime

	cpu_percentage=`echo "scale=8; (${process_time}-${old_process_time})*100/$period" | bc`
	oldtotal=$totaltime
	old_process_time=$process_time
	echo $cpu_percentage

done
