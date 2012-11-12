#!/bin/sh
#
# Optimization script by @VOKU github
# Compress png and jpg by 50%
# Package files:
# aptitude install optipng pngcrush jpegoptim
#

find . -iname '*.png' -exec optipng -o7 {} \;

for file in `find . -name "*.png"`;do
 echo $file;
 pngcrush -rem alla -reduce -brute "$file" tmp_img_file.png;
 mv -f tmp_img_file.png $file;
done;

find . -iname '*.jpg' -exec jpegoptim --force {} \;

echo "... Done, picks optimized! ..."; echo
