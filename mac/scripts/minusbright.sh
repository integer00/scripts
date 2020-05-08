for ((i=0; i<8 ;i++)) do current=`cat /sys/class/backlight/intel_backlight/brightness`;let current=$current-$i; echo $current > /sys/class/backlight/intel_backlight/brightness;sleep 0.040; done
