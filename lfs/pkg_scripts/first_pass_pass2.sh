#!/bin/bash

PS3='Select a package to install: '
options=(
"install tcl"
"install expect"
"Quit"
)

select opt in "${options[@]}"
do

    case $opt in
	    
  
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
	 
"Quit")
            break
	    ;;
	    
*) echo "invalid option $REPLY"
	;;

	esac
done


