#!/bin/bash

trap ctrl_c INT

function ctrl_c() {
 echo "**exit"
}


if wget --input-file=sources.txt --continue --directory-prefix=$LFS/sources ; 
then

cd /mnt/lfs/sources

if su lfs -c "for a in \`ls -1 *.tar.{xz,bz2,gz}\`; do tar -xvf \$a; done" ;
then
echo "done"
else 
	echo "error unpacking"
fi
 else
	 echo "error downloading"
fi
