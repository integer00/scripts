#!/bin/bash

if wget --input-file=test.txt --continue --directory-prefix=$LFS/sources ;
then
	echo "sucess"
else 
	echo "error"
fi
