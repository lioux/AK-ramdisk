#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "repack-bootimg.pl <kernel> <ramdisk-directory> <outfile>\n";

die $usage unless $ARGV[0] && $ARGV[1] && $ARGV[2];

chdir $ARGV[1] or die "$ARGV[1] $!";

system ("find . | cpio -o -H newc | lzop > $dir/ramdisk-repack.cpio.lzo");

chdir $dir or die "$ARGV[1] $!";;

system ("./mkbootimg --cmdline 'no_console_suspend=1 console=null' --kernel $ARGV[0] --ramdisk ramdisk-repack.cpio.lzo -o $ARGV[2]");

unlink("ramdisk-repack.cpio.lzo") or die $!;

print "\nrepacked boot image written at $ARGV[1]-repack.img\n";
