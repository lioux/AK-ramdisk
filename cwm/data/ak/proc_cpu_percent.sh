#!/system/bin/sh

###
## Variables
###
cpuNumber=0
cpuPercentage=0
oldTotalTime=0
oldProcessTime=0
period=0
processTime=0
totalTime=0

###
## Functions
###
obtainCpuNumber() {
  local cpuNumber

  cpuNumber=$( grep -E cpu[0123456789]+ /proc/stat | busybox wc -l )

  echo $cpuNumber
}

obtainField() {
 local field fieldNumber record

 fieldNumber=${1}
 shift

 record="${@}"

 field=$( echo ${record} | busybox cut -f ${fieldNumber} -d ' ' )

 echo "${field}"
}

obtainTotalTime() {
  local procStat
  local userTime niceTime systemTime idleTime
  local ioWait irq softIrq steal tails
  local idleAllTime systemAllTime totalTime
  
  # read usertime nicetime systemtime idletime ioWait irq softIrq steal tails  << $(cat /proc/stat | busybox sed '/cpu\s/!d; s/cpu//')
  procStat=$( cat /proc/stat | busybox sed '/cpu\s/!d; s/cpu//; s/\t+/ /; s/\s+/ /' )
  userTime=$(obtainField 1 ${procStat})
  niceTime=$(obtainField 2 ${procStat})
  systemTime=$(obtainField 3 ${procStat})
  idleTime=$(obtainField 4 ${procStat})
  ioWait=$(obtainField 5 ${procStat})
  irq=$(obtainField 6 ${procStat})
  softIrq=$(obtainField 7 ${procStat})
  steal=$(obtainField 8 ${procStat})
  tails=$(obtainField 9 ${procStat})

  let idleAllTime=idleTime+ioWait
  let systemAllTime=systemTime+irq+softIrq +steal

  let totalTime=userTime+niceTime+systemAllTime+idleAllTime

  echo $totalTime
}

obtainProcessTime() {
  local pid procStat stime utime
  local processTime

  pid="${1}"

  #read utime stime <<(cat /proc/$pid/stat | busybox awk '{print $14, $15}')
  procStat=$( cat /proc/$pid/stat | busybox awk '{print $14, $15}' | busybox sed 's/\t+/ /; s/\s+/ /' )

  utime=$(obtainField 1 ${procStat})
  stime=$(obtainField 2 ${procStat})

  let processTime=utime+stime

  echo $processTime
}

###
## Execute script
###

process=$1
[ -z "$process" ] && echo please input a process name && exit 1

pid=`busybox pgrep $process`
[ -z "$pid" -o ! -d "/proc/$pid" ] && echo please input a valid process name && exit 1

cpuNumber=$( obtainCpuNumber )
oldTotalTime=$( obtainTotalTime )
oldProcessTime=$( obtainProcessTime $pid )

while true; do
  sleep 1

  totalTime=$( obtainTotalTime )

  let period=totalTime-oldTotalTime
  let period=period/cpuNumber

  processTime=$( obtainProcessTime $pid )

  # TODO - we need more precision, we need to compile bc for Android
  #cpuPercentage=$( echo "scale=8; ($processTime-$oldProcessTime)*100/$period" | bc )
  let cpuPercentage=processTime-oldProcessTime
  let cpuPercentage=cpuPercentage*100

  # protects against division by 0
  if [ $cpuPercentage -ne 0 ]; then
    let cpuPercentage=cpuPercentage/period
  fi

  oldTotalTime=$totalTime
  oldProcessTime=$processTime

  echo $cpuPercentage
done

