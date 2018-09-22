#!/bin/bash

echo "checking $LFS variable"

if [ /mnt/lfs = /mnt/lfs ];then


umount -v $LFS/{dev,proc,sys,run};
rm -rfv $LFS/{dev,proc,sys,run};


echo "preparing virtual kernel file systems";



if mkdir -pv $LFS/{dev,proc,sys,run};then
	echo "creating initial device nodes";
	if mknod -m 600 $LFS/dev/console c 5 1;then
		if mknod -m 666 $LFS/dev/null c 1 3;then
			echo "binding host dev directory to lfs"
			if mount -v --bind /dev $LFS/dev;then
				echo "mounting virtual kernel file systems"
				if mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620;then
				if mount -vt proc proc $LFS/proc;then
				if mount -vt sysfs sysfs $LFS/sys;then
				if mount -vt tmpfs tmpfs $LFS/run;then
					echo "checking shm symlink"
					if [ -h $LFS/dev/shm ];then
					     mkdir -pv $LFS/$(readlink $LFS/dev/shm)
				     	fi
					echo "done"
				fi
				fi
				fi
				fi
			fi
		fi
	fi
fi
fi

