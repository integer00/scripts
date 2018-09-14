#!/bin/bash
if wget --input-file=sources.txt --continue --directory-prefix=$LFS/sources ; 
then


cd /mnt/lfs/sources


for a in `ls -1 *.tar.{xz,bz2,gz}`; do tar -xvf $a; done
echo "done"
fi
