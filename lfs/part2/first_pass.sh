#!/bin/bash

PS3='Select a package to install: '
options=(
"install binutils"
"install gcc"
"install linux-headers"
"install glibc"
"install libstdc++"
"install binutils-2"
"install gcc-2"
"install tcl"
"install expect"
"install dejagnu"
"install m4"
"install ncurses"
"install bash"
"install bison"
"install bzip2"
"install coreutils"
"Quit"
)

select opt in "${options[@]}"
do

    case $opt in
	    
"install binutils")
            
	
	cd $LFS/sources;
	cd binutils-2.31.1; 
	mkdir -v build;
	cd build;

	if ../configure --prefix=/tools \
		--with-sysroot=$LFS \
		--with-lib-path=/tools/lib \
		--target=$LFS_TGT \
		--disable-nls \
		--disable-werror; then
	
	if make -s; then
		case $(uname -m) in  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;esac

	if make install; then
		echo "installed complete"
	fi
	fi
fi
;;

"install gcc")
            
	echo "installing gcc"
	cd $LFS/sources/gcc-8.2.0;
	tar -xf ../mpfr-4.0.1.tar.xz;
	mv -v mpfr-4.0.1 mpfr;
	tar -xf ../gmp-6.1.2.tar.xz;
	mv -v gmp-6.1.2 gmp;
	tar -xf ../mpc-1.1.0.tar.gz;
	mv -v mpc-1.1.0 mpc

	for file in gcc/config/{linux,i386/linux{,64}}.h
		do
		cp -uv $file{,.orig}
		sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
		-e 's@/usr@/tools@g' $file.orig > $file
		echo '
		#undef STANDARD_STARTFILE_PREFIX_1
		#undef STANDARD_STARTFILE_PREFIX_2
		#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
		#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
		touch $file.orig
		done

		case $(uname -m) in
			x86_64)
			sed -e '/m64=/s/lib64/lib/' \
			-i.orig gcc/config/i386/t-linux64
			;;
			esac

		mkdir -v build;
		cd build;
		if ../configure \
			--target=$LFS_TGT \
			--prefix=/tools \
			--with-glibc-version=2.11 \
			--with-sysroot=$LFS \
			--with-newlib \
			--without-headers \
			--with-local-prefix=/tools \
			--with-native-system-header-dir=/tools/include \
			--disable-nls \
			--disable-shared \
			--disable-multilib \
			--disable-decimal-float \
			--disable-threads \
			--disable-libatomic \
			--disable-libgomp \
			--disable-libmpx \
			--disable-libquadmath \
			--disable-libssp \
			--disable-libvtv \
			--disable-libstdcxx \
			--enable-languages=c,c++; then
		if make -s; then
			make install;
		fi
	fi
	
		
;;

"install linux-headers")
        	echo "installing linux-headers";
	    	cd $LFS/sources/linux-4.18.5;
		if make mrproper;then
		if make INSTALL_HDR_PATH=dest headers_install;then
			if cp -rv dest/include/* /tools/include;then
				echo "install sucess"
			fi
		fi
	fi

			
	;;

		
"install glibc")
        	echo "installing glibc";
	    	cd $LFS/sources/glibc-2.28;
	
		mkdir -v build;
		cd build;

		if ../configure \
			--prefix=/tools \
			--host=$LFS_TGT \
			--build=$(../scripts/config.guess) \
			--enable-kernel=3.2 \
			--with-headers=/tools/include \
			libc_cv_forced_unwind=yes \
			libc_cv_c_cleanup=yes;then
		if make -s;then
			if make install;then
				echo "glib installed"
			fi
		fi
	fi
	

			
	;;

	
"install libstdc++")
        	echo "installing libstdc++";
	    	cd $LFS/sources/gcc-8.2.0;
	
		rm -rf build;

		mkdir -v build;
		cd build;
		if ../libstdc++-v3/configure \
			--host=$LFS_TGT \
			--prefix=/tools \
			--disable-multilib \
			--disable-nls \
			--disable-libstdcxx-threads \
			--disable-libstdcxx-pch \
			--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/8.2.0;then
		if make;then
			if make install;then
				echo "libstdc++ installed";
			fi
		fi
	fi

	

			
	;;

		
"install binutils-2")
        	echo "installing binutils pass 2";
	    	cd $LFS/sources/binutils-2.31.1;
	
		rm -rf build;
		mkdir -v build;
		cd build;

		if CC=$LFS_TGT-gcc \
		AR=$LFS_TGT-ar \
		RANLIB=$LFS_TGT-ranlib \
		../configure \
			--prefix=/tools \
			--disable-nls \
			--disable-werror \
			--with-lib-path=/tools/lib \
			--with-sysroot;then
		if make;then
			if make install;then
				if make -C ld clean;then
					if make -C ld LIB_PATH=/usr/lib:/lib;then
						if cp -v ld/ld-new /tools/bin;then
							echo "completed"
						fi
					fi
				fi
			fi
		fi
	fi

;;

	
"install gcc-2")
        	echo "installing gcc pass 2";
	    	cd $LFS/sources/gcc-8.2.0;
	
		cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

		for file in gcc/config/{linux,i386/linux{,64}}.h
		do
			cp -uv $file{,.orig}
			sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
			-e 's@/usr@/tools@g' $file.orig > $file
			echo '
			#undef STANDARD_STARTFILE_PREFIX_1
			#undef STANDARD_STARTFILE_PREFIX_2
			#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
			#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
			touch $file.orig
		done

		case $(uname -m) in
		x86_64)
		sed -e '/m64=/s/lib64/lib/' \
		-i.orig gcc/config/i386/t-linux64
		;;
		esac


		rm -rf build;
		mkdir -v build;
		cd build;

		if CC=$LFS_TGT-gcc \
		CXX=$LFS_TGT-g++ \
		AR=$LFS_TGT-ar \
		RANLIB=$LFS_TGT-ranlib \
		../configure \
			--prefix=/tools \
			--with-local-prefix=/tools \
			--with-native-system-header-dir=/tools/include \
			--enable-languages=c,c++ \
			--disable-libstdcxx-pch \
			--disable-multilib \
			--disable-bootstrap \
			--disable-libgomp;then
		if make;then
			if make install;then
				ln -sv gcc /tools/bin/cc;
				echo "install completed";
			fi
		fi
		fi
	


;;

"install tcl")
	echo "configuring tcl";
	cd $LFS/sources;
	cd tcl8.6.8/unix;
	if ./configure --prefix=/tools;then
		echo "making tcl";
		if make -s;then
			if TZ=UTC make test;then
				if make install;then
					chmod -v u+w /tools/lib/libtcl8.6.so;

					if make install-private-headers;then
						ln -sv tclsh8.6 /tools/bin/tclsh;					fi
				fi
			fi
		fi
	fi

	;;

"install expect")

	cd $LFS/sources;
	cd expect5.45.4;
	cp -v configure{,.orig};
	sed 's:/usr/local/bin:/bin:' configure.orig > configure

	echo "configuring expect";
	if ./configure --prefix=/tools \
		--with-tcl=/tools/lib \
		--with-tclinclude=/tools/include;then
	echo "making expect";
	if make -s;then
		if make SCRIPTS="" install;then
			echo "install done";

		fi
	fi
	fi

	;;
"install dejagnu")
	cd $LFS/sources;
	cd dejagnu-1.6.1	
	if ./configure --prefix=/tools;then
		if make install;then
			if make check;then
				echo "installed";
			fi
		fi
	fi


	;;	

"install m4")

	cd $LFS/sources;
	cd m4-1.4.18;
	if sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c;then
	 if echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h;then
	  if ./configure --prefix=/tools;then
		  if make;then
			  if make install;then
				  echo "installed";
			  fi
		  fi
	  fi
  fi
fi


	;;

"install ncurses")

	cd $LFS/sources;
	cd ncurses-6.1;

	if sed -i s/mawk// configure;then
		if ./configure --prefix=/tools \
			--with-shared \
			--without-debug \
			--without-ada \
			--enable-widec \
			--enable-overwrite;then
		if make;then
			if make install;then
				echo "installed";
			fi
		fi
	fi
fi

	;;

"install bash")

	cd $LFS/sources;
	cd bash-4.4.18;

	if ./configure --prefix=/tools --without-bash-malloc;then
		if make;then
			if make install;then
				ln -sv bash /tools/bin/sh;
				echo "installed";
			fi
		fi
	fi

	;;

"install bison")

	cd $LFS/sources;
	cd bison-3.0.5;

	if ./configure --prefix=/tools;then
		if make;then
			if make install;then
				echo "installed";
			fi
		fi
	fi

	;;
"install bzip2")

	cd $LFS/sources;
	cd bzip2-1.0.6
	
	if make;then
		if make PREFIX=/tools install;then
			echo "installed";
		fi
	fi

	;;

"install coreutils")
	cd $LFS/sources;
	cd coreutils-8.30;

	if ./configure --prefix=/tools --enable-install-program=hostname;then
		if make;then
			if make install;then
				echo "installed";
			fi
		fi
	fi


	;;
"Quit")
            break
	    ;;
	    
*) echo "invalid option $REPLY"
	;;

	esac
done

