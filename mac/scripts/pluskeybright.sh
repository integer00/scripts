for ((i=0; i<12 ;i++)) do current=`cat /sys/class/leds/smc\:\:kbd_backlight/brightness`;let current=$current+$i; echo $current > /sys/class/leds/smc\:\:kbd_backlight/brightness;sleep 0.040; done
