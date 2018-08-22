#!/bin/bash
#m.accuweather.com v 0.4

COUNTRY_CODE="kz"
CITY_NAME="almaty"
CITY_CODE="222191"

WEATHER_URL="http://m.accuweather.com/en/${COUNTRY_CODE}/${CITY_NAME}/${CITY_CODE}/current-weather/${CITY_CODE}"
CHECK_INTERFACE=$(ifconfig|grep ppp0|grep -o UP)
SYMBOL_CELSIUS="℃"

ICON_SUNNY=""
ICON_CLOUDY=""
ICON_CLEAR=""
ICON_RAINY=""
ICON_STORM=""
ICON_SNOW=""
ICON_FOGGY=""

WEATHER_INFO=$(wget -qO- "${WEATHER_URL}")

WEATHER_TEMP=$(echo "${WEATHER_INFO}" | grep 'temp">' | awk -F '>' '{print $2}' | awk -F '&' '{print $1}')
WEATHER_DATA=$(echo "${WEATHER_INFO}" | grep '<p>' | awk -F '>' '{print $2}' | awk -F '<' '{print $1; exit}')


#if [ "${CHECK_INTERFACE}" == UP ]; then
#	
#	if   [ "${WEATHER_DATA}" == Overcast ]; then
#		echo "${ICON_CLOUDY} ${WEATHER_TEMP} ${SYMBOL_CELSIUS}"
#	elif [ "${WEATHER_DATA}" == Clear ]; then
#		echo "${ICON_CLEAR} ${WEATHER_TEMP} ${SYMBOL_CELSIUS}"
#	elif [ "${WEATHER_DATA}" == Foggy ] || [ "${WEATHER_DATA}" == 'Light fog' ]; then
#		echo "${ICON_FOGGY} ${WEATHER_TEMP} ${SYMBOL_CELSIUS}"
#       else
#		echo "${WEATHER_TEMP} ${SYMBOL_CELSIUS}"
#
#	fi
#fi

echo -e "It's \033[0;34m${WEATHER_TEMP} \033[0moutside." 
