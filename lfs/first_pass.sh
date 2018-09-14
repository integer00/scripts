#!/bin/bash


su lfs -c "
cd $LFS/sources;
cd binutils-2.31.1; 
mkdir -v build;

cd build;
pwd;
../configure --prefix=/tools \
--with-sysroot=$LFS \
--with-lib-path=/tools/lib \
--target=$LFS_TGT \
--disable-nls \
--disable-werror

"
