#!/system/bin/sh
#
# The Die-Hard Battery Calibrator created by zeppelinrox.
#
line=================================================
minmV=4150
minpc=90
timelimit=4
totalminutes=20
totalseconds=$(($totalminutes*60))
secondsleft=$totalseconds
calibrated=0
override=0
auto=0
while :; do
clear
stty -icanon min 0 time ${timelimit}0
calibrate=
dhopt=
manual=
enable=0
plugged=0
almostfull=0
timesup=0
if [ -f "/sys/class/power_supply/battery/voltage_now" ]; then mv=$((`cat /sys/class/power_supply/battery/voltage_now`/1000))
elif [ -f "/sys/class/power_supply/battery/batt_vol" ]; then mv=`cat /sys/class/power_supply/battery/batt_vol`
else mv=$((`grep VOLTAGE_NOW /sys/class/power_supply/*/* | sed 's/.*=//'`/1000))
fi 2>/dev/null
capacity=`cat /sys/class/power_supply/*/capacity`
status=`cat /sys/class/power_supply/*/status`
ac=`cat /sys/class/power_supply/*ac*/online`
usb=`cat /sys/class/power_supply/*usb*/online`
if [ "$ac" -eq 1 ] || [ "$usb" -eq 1 ]; then plugged=1; fi
if [ "$mv" -ge "$minmV" ] || [ "$capacity" -ge "$minpc" ]; then almostfull=1; fi
if [ "$plugged" -eq 1 ] && [ "$almostfull" -eq 1 ]; then enable=1; fi
if [ "$enable" -eq 1 ]; then override=0; fi
echo "      ==================================="
busybox echo "     //// DIE-HARD BATTERY CALIBRATOR \\\\\\\\"
echo $line
busybox echo "     \\\\\\\\ Boosts Battery Performance! ////"
echo "      ==================================="
echo ""
id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%%gid*}`
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	echo " You are NOT running this script as root..."
	echo ""
	sleep 4
	echo $line
	echo "                      ...No SuperUser for you!!"
	echo $line
	echo ""
	sleep 4
	echo "     ...Please Run as Root and try again..."
	echo ""
	echo $line
	echo ""
	sleep 4
	exit 69
fi
echo -n "          Status = "$status
if [ "$usb" -eq 1 ]; then echo " | USB Plugged In"
elif [ "$ac" -eq 1 ]; then echo " | AC Plugged In"
else echo ""
fi
echo ""
echo " Current Current = "$mv"mV | Battery Level = "$capacity"%"
echo ""
echo " Battery should read approximately $((($mv-3200)/10))%"
echo ""
echo $line
if [ "$enable" -eq 1 ]; then echo "          Calibration Status: ENABLED"
elif [ "$override" -eq 1 ]; then echo "          Calibration Status: OVERRIDE"
else echo "          Calibration Status: DISABLED"
fi
echo $line
if [ "$auto" -eq 1 ]; then echo "         Auto Calibrate Mode: ENABLED"
else echo "         Auto Calibrate Mode: DISABLED"
fi
echo $line
echo ""
echo " Charge until 4200mV is reached..."
echo ""
echo "   ...leave it for about 20 extra minutes..."
echo ""
echo "                             ...then Calibrate!"
echo ""
echo $line
if [ "$enable" -eq 1 ] || [ "$override" -eq 1 ] && [ "$plugged" -eq 1 ]; then
	echo "   Delete Battery Stats Now?"
	echo $line
	echo ""
	echo -n " Enter C (Calibrate) or X (Exit): "
	if [ "$auto" -eq 0 ]; then
		echo ""; echo ""
		echo -n " Or... Enter: A to Enable Automatic Mode! "
		if [ "$override" -eq 1 ]; then
			echo ""
			echo -n "              M to Enable Manual Mode! "
		fi
		read calibrate
	else calibrate=C; echo $calibrate
	fi
	case $calibrate in
	  a|A)auto=1; override=0;;
	  m|M)override=0;;
	  c|C)if [ "$auto" -eq 0 ]; then timesup=1
		  else
			if [ "$secondsleft" -eq "$totalseconds" ]; then time=$( date +"%H:%M:%S"); fi
			minremain=$(($secondsleft/60))
			secremain=$(($secondsleft-$(($minremain*60))))
			if [ "$secremain" -lt 10 ]; then secremain="0$secremain"; fi
			echo ""
			echo $line
			echo ""
			echo " Start Time: $time - $totalminutes min. Delay Activated"
			echo ""
			echo " Auto Calibration in: $minremain minutes $secremain seconds ;-)"
			echo ""
			echo -n " Or... Enter M for Manual Mode... "
			read manual
			if [ "$manual" = "M" ] || [ "$manual" = "m" ]; then auto=0; fi
			if [ "$secondsleft" -le 0 ]; then timesup=1;fi
			secondsleft=$(($secondsleft-$timelimit))
		  fi
		  if [ "$timesup" -eq 1 ]; then echo ""; echo ""; echo $line
			if [ -f "/data/system/batterystats.bin" ]; then
				mount -o remount,rw /data 2>/dev/null
				rm /data/system/batterystats.bin
				echo " SUCCESS: Battery Stats have been DELETED!"
				echo $line
				echo ""
				su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -n com.android.music/.MediaPlaybackActivity -d file:///system/media/audio/ui/LowBattery.ogg"
				echo ""
				echo $line
			else echo " DOH!: Battery Stats were already deleted!?"; echo $line
			fi
			calibrated=1; break
		  fi;;
	  x|X)echo ""; echo ""; echo $line
		  echo "        Calibration declined this time!"
		  echo $line; break;;
		*);;
	esac
else
	if [ "$plugged" -eq 0 ]; then echo "   TO CALIBRATE... PLEASE PLUG IN THE POWER!"
	elif [ "$auto" -eq 1 ]; then echo "   Automatc Mode will start at $minmV OR $minpc%!"
	else echo "   Cannot Calibrate until 4200mV is reached..."
	fi
	echo $line
	echo ""
	echo " Wait or... Enter: P for Power Usage Summary"
	echo "                   H for Battery History (Froyo)"
	if [ "$plugged" -eq 1 ]; then
		if [ "$auto" -eq 0 ]; then echo "                   A for Automatic Mode!"
		else echo "                   M for Manual Mode (Default)"
		fi
		echo "                   O to Override..."
	fi
	echo "                   X to Exit..."
	echo ""
	echo " Tip: View Battery History and..."
	echo "         ...Under \"Partial Wake Usage\"..."
	echo -n "                    ...Find Battery Drainers! "
	read dhopt
	case $dhopt in
	  p|P)echo ""; echo ""; su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -n com.android.settings/.fuelgauge.PowerUsageSummary";;
	  h|H)echo ""; echo ""; su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -n com.android.settings/.battery_history.BatteryHistory";;
	  a|A)if [ "$plugged" -eq 1 ]; then override=0; auto=1; fi;;
	  m|M)if [ "$plugged" -eq 1 ]; then override=0; auto=0; fi;;
	  o|O)if [ "$plugged" -eq 1 ]; then override=1; auto=0; fi;;
	  x|X)echo ""; echo ""; echo $line; break;;
		*);;
	esac
fi
stty sane
done
if [ "$calibrated" -eq 1 ]; then
	echo ""
	sleep 1
	echo " Do NOT unplug your device!"
	echo ""
	sleep 1
	echo $line
	echo "           A REBOOT IS ALSO REQUIRED!"
	echo $line
	echo ""
	sleep 1
	echo " BONUS TIP - Try The NOBOL Technique!!"
	echo " ========="
	echo ""
	sleep 1
	echo " If you can reboot and reach the animation..."
	echo ""
	sleep 1
	echo "        ...WITHOUT the battery inside..."
	echo ""
	sleep 1
	echo " Get extra juice by popping the battery in..."
	echo ""
	sleep 1
	echo " ...AFTER the logo & when the animation starts!"
	echo ""
	sleep 1
	echo $line
	echo "          NOBOL = NO Battery On Logo!"
	echo $line
	echo ""
	sleep 1
	echo " Note: This won't work if charging via USB!"
	echo ""
	sleep 1
	echo $line
	echo ""
	sleep 1
	echo " So... after rebooting, relaunch this script..."
	echo ""
	sleep 1
	echo "              ...and monitor the battery stats."
	echo ""
	sleep 1
	echo " Be sure that ~4200mV shows up as 100%!"
	echo ""
	sleep 1
	echo " Well, don't be too anal about it... lol"
	echo ""
	sleep 1
	echo " Then unplug your device..."
	echo ""
	sleep 1
	echo "            ...the mV WILL go down..."
	echo ""
	sleep 1
	echo "      ...but should remain in the 4150mV range!"
	echo ""
	echo $line
	echo ""
	sleep 1
	echo " Note: dalvik-cache will be wiped as well..."
	echo ""
	sleep 1
	echo "    ...so the reboot will be longer than usual!"
	echo ""
	echo $line
	echo ""
	sleep 1
	echo " Reboot Now?"
	echo ""
	sleep 1
	echo -n " Enter N for No, any key for Yes: "
	if [ "$auto" -eq 0 ]; then read restart
	else restart=Y; echo $restart
	fi
	echo ""
	case $restart in
	  n|N)echo " uh... right... okay..."
		  echo ""
		  echo $line;;
		*)rm -fr /*/dalvik-*/* 2>/dev/null
		  echo " All cleaned up and ready to..."
		  echo ""
		  $sleep
		  echo $line
		  echo "                    !!POOF!!"
		  echo $line
		  echo ""
		  sleep 2
		  busybox sync
		  if [ -f "/proc/sys/kernel/sysrq" ]; then
			  echo 1 > /proc/sys/kernel/sysrq 2>/dev/null
			  echo b > /proc/sysrq-trigger 2>/dev/null
		  fi
		  echo "  If it don't go poofie, just reboot manually!"
		  echo ""
		  echo $line
		  reboot; busybox reboot;;
	esac
fi
echo ""
sleep 1
echo " The Die-Hard Battery Calibrator..."
echo ""
sleep 1
echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
echo ""
sleep 2
echo "                                     Buh Bye :)"
echo ""
echo $line
echo ""
sleep 1
exit 0
