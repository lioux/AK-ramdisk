## BUG REPORT SCRIPT
Thanks to [Lioux](https://github.com/lioux)
```python
You need ROOT access and busybox installed.
(/AK-ramdisk/cwm/data/ak/create_bugreport.sh)
```

## HOW-TO USE SCRIPT
The bugreport is saved on the **/sdcard/** root directory in the following name format: 
* /sdcard/bugreport_YYYYMMDD_HHh_MMm_SSs.tar.bz2

You can use the script in 2 ways:

1) No modification, it generates a complete bugreport (lioux style) minus dumpstate:
* time sh create_bugreport.sh
0m7.29s real     0m1.12s user     0m0.36s system
* du -k bugreport_20130327_19h_39m_56s.tar.bz2
96

Super fast, 7 seconds with about 96Kbytes.

2) If you edit the script and uncomment the line that adds a dumpstate to the bugreport (it's easy, there is a line explaining it inside the script):
* time sh create_bugreport.sh                                       
1m52.43s real     0m11.33s user     0m4.61s system
* du -k  bugreport_20130327_19h_53m_04s.tar.bz2                        
728     bugreport_20130327_19h_53m_04s.tar.bz2

Less than 2 minutes with about 728Kbytes. Not too shabby if I might say. :) So it's fast and compact.

## QUESTIONS AND ANSWERS
* Why is dumpstate disabled? Because I run it at every boot so that I can report if anything happens. Furthermore, we don't usually need dumpstate unless the kernel developer asks for it.
* You can submit these bugreports to other projects too. This is not limitted to AK. :)
* You can use script manager from play store to launch this script at every boot.
* And, a personal advice: open the bugreport before you submit it.
* You can learn a little more about your phone and what might have happened.
* Moreover, this might help you decide that you don't need to send that much information, just one file might have the information needed.

I hope you guys enjoy it.
