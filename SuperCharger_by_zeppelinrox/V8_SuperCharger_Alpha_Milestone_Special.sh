#!/system/bin/sh
# V8 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.
echo "  REMINDER: ONLY USE BUSYBOX v1.18.2 OR LOWER!!"
#set -o errexit
cat > /sdcard/V8SuperCharger.html <<EOF
Hi! I hope that the V8 SuperCharger script is working well for you!<br>
<br>
First be sure to have <a href="http://market.android.com/details?id=com.jrummy.busybox.installer">BusyBox</a> installed or else the scripts won't work!<br>
Also, only install <b>BusyBox v1.18.2 or lower!</b> v1.18.3 and above sometimes give errors on some ROMs!<br>
<br>
A nice app for running the script is <a href="http://market.android.com/details?id=os.tools.scriptmanager">Script Manager</a><br>
It can even load scripts on boot - on ANY ROM!<br>
Plus, it even has WIDGETS!<br>
So you can actually put a V8 SuperCharger shortcut on your desktop, launch it, and have a quick peek at your current status!<br>
<br>
But first, you need to set up Script Manager properly!<br>
In the "Config" settings, enable "Browse as Root."<br>
Then browse to where you saved the V8 SuperCharger script, select it, and in the script's properties box, be sure to select "Run as Root."<br>
<b>Do NOT run this file at boot!</b> (You don't want to run the install on every boot, do you?)<br>
Run the V8 SuperCharger script, touch the screen to access the soft keyboard, and enter your choice :)<br>
<br>
<b>Stock ROMs</b>: After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, be sure that "Browse as Root" is enabled.<br>
Press the menu key and then Browser. Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
<b>Custom ROMs</b>: If you have a custom rom that loads /system/etc/init.d boot scripts,<br>
You DON'T need to use Script Manager to load a boot script. It will all be automatic!<br>
Also, if you can run boot scripts from the /system/etc/init.d folder, there are other options.<br>
For example you can use an app like Terminal Emulator to run the script.<br>
I've even made a special version for Terminal Emulator which has 60 colums :)<br>
If your ROM has the option, <b>DISABLE "Lock Home In Memory.</b> This takes effect immediately.<br>
Alternately, <u>if you need to free up extra ram</u>, you can use "Lock Home in Memory" as a "Saftey Lock".<br>
ie. Use it to toggle your launcher from "Bulletproof" (0) or Die-Hard (1) to "Weak" (2) in the event that you want to make the launcher an easy kill and free up extra ram ;)<br>
<br>
<b>If Settings Don't Stick:</b> If you have Auto Memory Manager, DISABLE SuperUser permissions and if you have AutoKiller Memory Optimizer, DISABLE the apply settings at boot option!<br>
Also, if you have a <b>Custom ROM</b>, there might be something in the init.d folder that interferes with priorities and minfrees.<br>
If you can't find the problem, a quick fix is to have Script Manager run <b>/system/etc/init.d/99SuperCharger</b> "at boot" and "as root."<br>
<br>
For those with a <b>Milestone</b>, I made a version for <b>Androidiani Open Recovery</b> too :D<br>
Just extract the zip to the root of the sdcard (it contains the directory structure), load AOR, and there will be a SuperCharger Menu on the main screen! <br>
<br>
<b>Overclocker:</b> Only for Custom ROMs with the init.d folder! And ONLY for advanced users!!<br>
Basically, this is a shortcut to having to edit an overclock script file manually.<br>
A new overclock file is created and any other overclock settings/modules remain the same.<br>
All that the new file does is override previously loaded mhz and vsel values<br>
The "backup" is to merely delete the overclock file that the V8 SuperCharger created ;)<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V8 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
reset="\e[0m";black="\e[0;30m";blackbold="\e[1;30m";red="\e[0;31m";redbold="\e[1;31m";green="\e[0;32m";greenbold="\e[1;32m";yellow="\e[0;33m";yellowbold="\e[1;33m";blue="\e[0;34m";bluebold="\e[1;34m";magneta="\e[0;35m";magnetabold="\e[1;35m";cyan="\e[0;36m";cyanbold="\e[1;36m";white="\e[0;37m";whitebold="\e[1;37m"
hilite=$yellow
titles=$greenbold
colour=$cyan
error=0
ocerror=0
speed=2
sleep="sleep $speed"
clear
smrun=`pidof os.tools.scriptmanager`
echo "  REMINDER: ONLY USE BUSYBOX v1.18.2 OR LOWER!!"
echo ""
if [[ -n "$smrun" ]]; then
	echo -e $hilite"   Touch the screen to bring up soft keyboard."$reset
else
	echo -e $hilite" Try Script Manager... it's easier!"$reset
fi
echo ""
echo -e " Settings: "$titles"Titles, "$colour"Text, "$reset"Scrolling Speed = $speed."
echo ""
echo " Customize colours and scrolling speed?"
echo -n " Enter Y for Yes, any key for defaults: "
read customcolours
case $customcolours in
	y|Y)custom=1;;
	*)echo -e $colour
	  echo " Default theme loaded...";;
esac
if [ "$custom" -eq 1 ] 2>/dev/null; then
	while :
	do
	echo ""
	echo -e $titles" Title Colour: "$cyanbold"C-yan,"$whitebold"W-hite,"$greenbold"G-reen,"$redbold"R-ed,"$magnetabold"M-agneta"$reset
	echo -n " Choose a title colour: "
	read ctitles
	case $ctitles in
		c|C)titles=$cyanbold;tt=c;break;;
		w|W)titles=$whitebold;tt=w;break;;
		g|G)titles=$greenbold;tt=g;break;;
		r|R)titles=$redbold;tt=r;break;;
		m|M)titles=$magnetabold;tt=m;break;;
		*)echo ""
		  echo -e $hilite" Invalid entry... Please try again..."
		  sleep 2
		  echo -e $reset
		  clear
		  if [[ -n "$smrun" ]]; then
			echo -e $hilite"   Touch the screen to bring up soft keyboard."$reset
		  else
			echo -e $hilite" Try Script Manager... it's easier!"$reset
		  fi
		  echo ""
		  echo -e " Settings: "$titles"Titles, "$colour"Text, "$reset"Scrolling Speed = $speed."
		  echo ""
		  echo " Customize colours and scrolling speed?"
		  echo " Enter Y for Yes, any key for defaults: $customcolours";;
	esac
	done
	while :
	do
	echo -e $reset
	clear
	if [[ -n "$smrun" ]]; then
		echo -e $hilite"   Touch the screen to bring up soft keyboard."$reset
	else
		echo -e $hilite" Try Script Manager... it's easier!"$reset
	fi
	echo ""
	echo -e " Settings: "$titles"Titles, "$colour"Text, "$reset"Scrolling Speed = $speed."
	echo ""
	echo " Customize colours and scrolling speed?"
	echo " Enter Y for Yes, any key for defaults: $customcolours"
	echo ""
	echo -e $titles" Title Colour: "$cyanbold"C-yan,"$whitebold"W-hite,"$greenbold"G-reen,"$redbold"R-ed,"$magnetabold"M-agneta"$reset
	echo " Choose a title colour: "$tt
	echo ""
	echo -e $colour" Text Colour:  "$cyan"C-yan,"$white"W-hite,"$green"G-reen,"$red"R-ed,"$magneta"M-agneta"$reset
	echo -n " Choose a text colour: "
	read ccolour
	case $ccolour in
		c|C)colour=$cyan;cl=c;break;;
		w|W)colour=$white;cl=w;break;;
		g|G)colour=$green;cl=g;break;;
		r|R)colour=$red;cl=r;break;;
		m|M)colour=$magneta;cl=m;break;;
		*)echo ""
		  echo -e $hilite" Invalid entry... Please try again..."
		  sleep 2;;
	esac
	done
	while :
	do
	echo -e $reset
	clear
	if [[ -n "$smrun" ]]; then
		echo -e $hilite"   Touch the screen to bring up soft keyboard."$reset
	else
		echo -e $hilite" Try Script Manager... it's easier!"$reset
	fi
	echo ""
	echo -e " Settings: "$titles"Titles, "$colour"Text, "$reset"Scrolling Speed = $speed."
	echo ""
	echo " Customize colours and scrolling speed?"
	echo " Enter Y for Yes, any key for defaults: $customcolours"
	echo ""
	echo -e $titles" Title Colour: "$cyanbold"C-yan,"$whitebold"W-hite,"$greenbold"G-reen,"$redbold"R-ed,"$magnetabold"M-agneta"$reset
	echo " Choose a title colour: "$tt
	echo ""
	echo -e $colour" Text Colour:  "$cyan"C-yan,"$white"W-hite,"$green"G-reen,"$red"R-ed,"$magneta"M-agneta"$reset
	echo " Choose a text colour: "$cl
	echo -e $colour
	echo " Scrolling speed options..."
	echo ""
	echo " 0(no waiting), 1(fast), 2(normal), 3(slow)"
	echo ""
	echo -n " Please select scrolling speed (0 - 3): "
	read cspeed
	case $cspeed in
		0)sleep="sleep $cspeed";break;;
		1)sleep="sleep $cspeed";break;;
		2)sleep="sleep $cspeed";break;;
		3)sleep="sleep $cspeed";break;;
		*)echo ""
		  echo -e $hilite" Invalid entry... Please try again..."
		  $sleep;;
	esac
	done
fi
info=$titles
sig=$titles
line=$titles================================================
$sleep
while :
echo ""
do
 HL=`getprop ro.HOME_APP_ADJ`;FA=`getprop ro.FOREGROUND_APP_ADJ`;PA=`getprop ro.PERCEPTIBLE_APP_ADJ`;VA=`getprop ro.VISIBLE_APP_ADJ`
 if [[ -z "$PA" ]]; then
	froyo=1
 else
	froyo=0
 fi
 MB0=4;MB1=0;MB2=0;MB3=0;MB4=0;MB5=0;MB6=0
 SP1=0;SL1=0;SL2=0;SL3=0;SL4=0;SL5=0;SL6=0
 echo -e $line
 echo -e $hilite"For Help & Info see /sdcard/V8SuperCharger.html"
 echo -e $line
 $sleep
 echo "\\\\\\\\ V 8  S U P E R C H A R G E R - M E N U ////"
 echo " =============================================="
 echo -e $colour
 echo " 1. SuperCharger & Launcher Status"
 echo " 2. Aggressive 1 Settings  {6,8,24,30,40,50 mb}"
 echo " 3. Aggressive 2 Settings  {6,8,25,30,35,35 mb}"
 echo " 4. Balanced 1 Settings    {6,8,24,26,28,30 mb}"
 echo " 5. Balanced 2 Settings    {6,8,26,27,28,28 mb}"
 echo " 6. Balanced 3 Settings    {6,8,26,28,30,32 mb}"
 echo " 7. MultiTasking Settings  {6,8,22,24,26,26 mb}"
 echo " 8. Gaming Settings       {6,20,40,70,80,90 mb}"
 echo " 9. MegaMemory Device  {6,12,75,125,150,175 mb}"
 echo "10. Cust-OOMized Settings    {See Slot 3 Tips!}"
 echo "11. OOM Grouping Fixes + Die-Hard Launcher"
 echo "12. OOM Grouping Fixes + BulletProof Launcher"
 echo "13. UnDo Kernel/Memory Tweaks"
 echo "14. UnSuperCharger"
 echo "15. 3G TurboCharger + Hardware Acceleration"
 echo "16. Overclocker  {99sc-overclock SuperCedes OC}"
 echo "17. UnOverclocker      {Removes 99sc-overclock}"
 echo "18. REBOOT! (WARNING - There is NO Warning!)"
 echo "19. Exit"
 echo -e $hilite
 awk -F , '{print " NOTE: Current minfrees = "$1/256,$2/256,$3/256,$4/256,$5/256,$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
 echo -n "       Launcher is.... ";
 if [ "$HL" -gt "$VA" ]; then
	echo "so.... weak.... :("
	status=4
 elif [ "$HL" -eq "$VA" ]; then
	echo "Locked In Memory!"
	status=3
 elif [ "$froyo" -eq 1 ]; then
	if [ "$HL" -eq "$FA" ]; then
		echo "BULLETPROOF!"
		status=1
	else
		echo "HARD TO KILL!"
		status=2
	fi
 else
	if [ "$HL" -ge "$FA" ] && [ "$HL" -lt "$PA" ]; then
		echo "BULLETPROOF!"
		status=1
	else
		echo "HARD TO KILL!"
		status=2
	fi
 fi
 echo -e $colour
 echo " Disable Lock Home in Memory &..."
 echo " Disable Compcache & wipe caches if lag occurs!"
 echo ""
 if [[ -n "$smrun" ]]; then
	echo " In Config, select Run as Root & Browse as Root!"
 	echo -e " But "$hilite"DO NOT"$colour" run this script at boot!"
 	echo ""
	echo " For a quick status check..."
	echo " ...put a V8 SuperCharger WIDGET on the desktop!"
 else
	echo "   Optimized for display with Script Manager."
	echo ""
	echo " SM can give you a quick status check..."
	echo " ...Put a V8 SuperCharger WIDGET on the desktop!"
	echo "                                   ...Try it! :)"
 fi
 echo ""
 echo -e $hilite" Slot 3 Sets Free RAM & is your New Task Killer!"
 echo ""
 echo -n "      Please make a selection (1 - 18): "
 read opt
 echo ""
 $sleep
 if [ "$opt" -ne 19 ] 2>/dev/null; then
	mount -o remount,rw /system 2>/dev/null
	for m in /dev/block/mtdblock*
	do
	mount -o remount,rw $m /system 2>/dev/null
	done
 fi
 echo -e $line
 echo "            \\\\\\\\ V8 SUPERCHARGER ////"
 echo "             ======================="
 echo -e $hilite
 $sleep
case $opt in
  1) echo "      V8 SUPERCHARGER AND LAUNCHER STATUS!";;
  2) echo "       AGGRESSIVE 1 + DIE-HARD LAUNCHER!"
     CONFIG="Aggressive 1"
	 MB1=6;MB2=8;MB3=24;MB4=30;MB5=40;MB6=50;;
  3) echo "       AGGRESSIVE 2 + DIE-HARD LAUNCHER!"
     CONFIG="Aggressive 2"
	 MB1=6;MB2=8;MB3=25;MB4=30;MB5=35;MB6=35;;
  4) echo "        BALANCED 1 + DIE-HARD LAUNCHER!"
     CONFIG="Balanced 1"
	 MB1=6;MB2=8;MB3=24;MB4=26;MB5=28;MB6=30;;
  5) echo "        BALANCED 2 + DIE-HARD LAUNCHER!"
     CONFIG="Balanced 2"
	 MB1=6;MB2=8;MB3=26;MB4=27;MB5=28;MB6=28;;
  6) echo "        BALANCED 3 + DIE-HARD LAUNCHER!"
     CONFIG="Balanced 3"
	 MB1=6;MB2=8;MB3=26;MB4=28;MB5=30;MB6=32;;
  7) echo "       MULTITASKING + DIE-HARD LAUNCHER!"
     CONFIG="MultiTasking"
	 MB1=6;MB2=8;MB3=22;MB4=24;MB5=26;MB6=26;;
  8) echo "          GAMING + DIE-HARD LAUNCHER!"
     CONFIG="Gaming"
	 MB1=6;MB2=20;MB3=40;MB4=70;MB5=80;MB6=90;;
  9) echo "        MEGAMEMORY + DIE-HARD LAUNCHER!"
     CONFIG="MegaMemory"
	 MB1=6;MB2=12;MB3=75;MB4=125;MB5=150;MB6=175;;
  10)echo "       CUST-OOMIZER + DIE-HARD LAUNCHER!"
     CONFIG="CUST-OOMIZED"
	 echo -e $line$colour
	 echo ""
	 $sleep
	 echo " Enter your desired lowmemorykiller OOM levels!"
	 echo ""
	 $sleep
	 echo -e $hilite" Slot 3 determines your fee ram the most!!"$colour
	 echo ""
	 $sleep
	 echo " To restart, enter a letter to go to main menu."
	 echo -e $hilite
	 $sleep
 	 echo -n "              Slot 1: ";read MB1
	 if [ "$MB1" -gt 0 ] 2>/dev/null; then
		echo -n "                Slot 2: ";read MB2
		if [ "$MB2" -gt 0 ] 2>/dev/null; then
			echo -n "                  Slot 3: ";read MB3
			if [ "$MB3" -gt 0 ] 2>/dev/null; then
				echo -n "                    Slot 4: ";read MB4
				if [ "$MB4" -gt 0 ] 2>/dev/null; then
					echo -n "                      Slot 5: ";read MB5
					if [ "$MB5" -gt 0 ] 2>/dev/null; then
						echo -n "                        Slot 6: ";read MB6
						if [ "$MB6" -gt 0 ] 2>/dev/null; then
							echo ""
							echo "        Cust-OOMized Settings Accepted!"
						else
							error=1
						fi
					else
						error=1
					fi
				else
					error=1
				fi
			else
				error=1
			fi
		else
			error=1
		fi
	 else
		error=1
	 fi
	 echo "";;
  11)echo " OOM GROUPING FIXES PLUS..."
     echo ""
     echo "                          ...DIE-HARD LAUNCHER!";;
  12)echo " OOM GROUPING FIXES PLUS..."
     echo ""
	 echo "                       ...BULLETPROOF LAUNCHER!";;
  13)echo -e $titles"              ==================="
     echo "             //// UNKERNELIZER \\\\\\\\";;
  14)echo -e $titles"             ====================="
	 echo "            //// UNSUPERCHARGER \\\\\\\\";;
  15)echo -e $titles"            ======================"
     echo "           //// 3G TURBOCHARGER \\\\\\\\";;
  16)echo -e $titles"              =================="
	 echo "             //// OVERCLOCKER \\\\\\\\"
	 echo -e $line
	 echo ""
	 $sleep
	 echo -e $hilite" WARNING: For Advanced Users only!!"
	 $sleep
	 echo " For Custom ROMs only!!"
	 echo " This may have no effect on some Custom ROMs :p"
	 echo -e $colour
	 $sleep
	 echo " This creates /system/init.d/99sc-overclock"
	 $sleep
	 echo " Current overclock files are untouched..."
	 echo " 99sc-overclock merely updates mhz and vsel!"
	 echo ""
	 $sleep
	 echo " Guide for entering your 5 desired steppings..."
	 echo -e $hilite
	 $sleep
	 echo " Maximum Speed = 1200 mhz  -  Maximum vsel = 80"
	 echo " Minimum Speed = 125 mhz   -  Minimum vsel = 18"
	 echo -e $colour
	 $sleep
	 echo " ENTER THE TOP SPEED AND VSEL FIRST! (in mhz)"
	 $sleep
	 echo ""
	 echo " EACH VALUE MUST BE LOWER THAN PRIOR VALUE"
	 echo ""
	 $sleep
	 echo " To restart, enter a letter to go to main menu."
	 echo -e $hilite
	 $sleep
	 echo -n "        5th Gear mhz: ";read MHZ5
	 if [ "$MHZ5" -ge 125 ] 2>/dev/null && [ "$MHZ5" -le 1200 ] 2>/dev/null; then
		echo -n "                              vsel 5: ";read VSEL5
		if [ "$VSEL5" -ge 18 ] 2>/dev/null && [ "$VSEL5" -le 80 ] 2>/dev/null; then
			echo -n "        4th Gear mhz: ";read MHZ4
			if [ "$MHZ4" -ge 125 ] 2>/dev/null && [ "$MHZ4" -le 1200 ] 2>/dev/null; then
				if [ "$MHZ5" -gt "$MHZ4" ];then
					echo -n "                              vsel 4: ";read VSEL4
					if [ "$VSEL4" -ge 18 ] 2>/dev/null && [ "$VSEL4" -le 80 ] 2>/dev/null; then
						if [ "$VSEL5" -gt "$VSEL4" ]; then
							echo -n "        3rd Gear mhz: ";read MHZ3
							if [ "$MHZ3" -ge 125 ] 2>/dev/null && [ "$MHZ3" -le 1200 ] 2>/dev/null; then
								if [ "$MHZ4" -gt "$MHZ3" ];then
									echo -n "                              vsel 3: ";read VSEL3
									if [ "$VSEL3" -ge 18 ] 2>/dev/null && [ "$VSEL3" -le 80 ] 2>/dev/null; then
										if [ "$VSEL4" -gt "$VSEL3" ];then
											echo -n "        2nd Gear mhz: ";read MHZ2
											if [ "$MHZ2" -ge 125 ] 2>/dev/null && [ "$MHZ2" -le 1200 ] 2>/dev/null; then
												if [ "$MHZ3" -gt "$MHZ2" ]; then
													echo -n "                              vsel 2: ";read VSEL2
													if [ "$VSEL2" -ge 18 ] 2>/dev/null && [ "$VSEL2" -le 80 ] 2>/dev/null; then
														if [ "$VSEL3" -gt "$VSEL2" ]; then
															echo -n "        1st Gear mhz: ";read MHZ1
															if [ "$MHZ1" -ge 125 ] 2>/dev/null && [ "$MHZ1" -le 1200 ] 2>/dev/null; then
																if [ "$MHZ2" -gt "$MHZ1" ]; then
																	echo -n "                              vsel 1: ";read VSEL1
																	if [ "$VSEL1" -ge 18 ] 2>/dev/null && [ "$VSEL1" -le 80 ] 2>/dev/null; then
																		if [ "$VSEL2" -gt "$VSEL1" ]; then
																		else
																			ocerror=1
																		fi
																	else
																		error=1
																	fi
																else
																	ocerror=1
																fi
															else
																error=1
															fi
														else
															ocerror=1
														fi
													else
														error=1
													fi
												else
													ocerror=1
												fi
											else
												error=1
											fi
										else
											ocerror=1
										fi
									else
										error=1
									fi
								else
									ocerror=1
								fi
							else
								error=1
							fi
						else
							ocerror=1
						fi
					else
						error=1
					fi
				else
					ocerror=1
				fi
			else
				error=1
			fi
		else
			error=1
		fi
	 else
		error=1
	 fi
	 echo "";;
  17)echo -e $titles"             ===================="
	 echo "            //// UNOVERCLOCKER \\\\\\\\";;
  18)echo "                    !!POOF!!"
     $sleep
     reboot;;
  19)echo " Did you find this useful? Feedback is welcome!";;
  *) echo -e "   #!*@%$*?%@&)&*#!*?(*)(*)&(!)%#!&?@#$*%&?&$%$*#?!"$colour
     echo ""
     sleep 2
	 echo "     oops.. typo?!  $opt is an Invalid Option!"
     echo ""
     $sleep
	 echo "            1 <= Valid Option => 18 !!";
     echo ""
     $sleep
	 echo -n "    hehe... Press Enter key to continue... ;) ";
     read enterKey
	 echo ""
     opt=0;;
esac
if [ "$opt" -ge 1 ] && [ "$opt" -le 19 ]; then
	echo -e $line$colour
	echo ""
	$sleep
fi
if [ "$error" -eq 1 ]; then
	echo -e $hilite" Input Error! Try again :)"
	error=0
	sleep 2
elif [ "$ocerror" -eq 1 ]; then
	echo -e $hilite" Input Error! Last value entered was too high!"
	echo ""
	sleep 2
	echo " Try again :)"
	ocerror=0
	sleep 2
else
	if [ "$opt" -eq 1 ]; then
		echo " Out Of Memory (OOM) / lowmemorykiller values:"
		echo ""
		$sleep
		echo "        "`cat /sys/module/lowmemorykiller/parameters/minfree` pages
		echo -e $hilite
		$sleep
		awk -F , '{print "  Which means: "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
		echo ""
		echo -e $line$colour
		echo ""
		$sleep
		echo " Home Launcher Priority is: $HL"
		echo ""
		$sleep
		echo "         Foreground App Priority is: $FA"
		echo ""
		$sleep
		echo "                     Visible App Priority is: $VA"
		echo ""
		$sleep
		if [ "$HL" -le "$FA" ]; then
			echo -e $hilite" Home Launcher = Foreground App = BULLETPROOF!"
		elif [ "$HL" -gt "$FA" ] && [ "$HL" -lt "$VA" ]; then
			echo " Launcher is greater than Foreground App..."
			echo ""
			$sleep
			echo "          ...and it is less than Visible App..."
			echo ""
			$sleep
			echo -e $hilite"          Home Launcher is DIE-HARD!"
		elif [ "$HL" -eq "$VA" ]; then
			echo -e $hilite"Home Launcher = Visible App = Locked In Memory!"
		else [ "$HL" -gt "$VA" ]
			echo " Launcher is greater than Visible App..."
			echo ""
			$sleep
			echo -e $hilite"          Wow, that's one weak ass launcher! :("
		fi
		echo -e $colour
		$sleep
		echo " BUT if Home is Locked in Memory,it's really $VA!"
		echo ""
		$sleep
		echo " ie. Home Launcher =Visible App= Pretty Weak :P"
		echo ""
		echo -e $line
		echo ""
		$sleep
		echo -e $sig" SuperCharger and Launcher Status..."
	fi
	if [ "$opt" -ge 2 ] && [ "$opt" -le 14 ]; then
		if [ "$opt" -le 10 ]; then
			SP1=$(($MB0*256));SL1=$(($MB1*256));SL2=$(($MB2*256));SL3=$(($MB3*256));SL4=$(($MB4*256));SL5=$(($MB5*256));SL6=$(($MB6*256))
			echo -e $hilite" zoom... zoom..."
			echo ""
			$sleep
		fi
		if [ "$opt" -eq 11 ] || [ "$opt" -eq 12 ]; then
			echo " This toggles the launcher between..."
			echo ""
			echo "                    ...Die-Hard and BulletProof"
			echo ""
			echo -e $hilite" Minfree values will remain unchanged!"
			echo ""
			$sleep
			if [ "$opt" -eq 12 ]; then
				echo -e $hilite" WARNING: BulletProofing is not recommended..."
				echo "               ...It can have negative effects!"
				echo -e $colour
				echo -n " Continue? Enter Y for Yes, any key for No: "
				read bp
				case $bp in
					y|Y)echo " Okaaaay... if you say so..."
					    echo "";;
					*)opt=99;;
				esac
			$sleep
			fi
		fi
		if [ "$opt" -le 12 ]; then
			echo -e $info"=============  Information Section  ============"
			echo "             ======================="
 			echo -e $colour
			$sleep
		fi
		if [ "$opt" -ne 13 ]; then
			if [ -f "/sdcard/V8UnSuperCharged.html" ]; then
				rm /sdcard/V8UnSuperCharged.html
			fi
			if [ -f "/sdcard/V8SuperChargerHelp.html" ]; then
				rm /sdcard/V8SuperChargerHelp.html
			fi
			if [ -f "/sdcard/V8SuperChargerScriptManagerHelp.html" ]; then
				rm /sdcard/V8SuperChargerScriptManagerHelp.html
			fi
			sed -i '/.*_ADJ/d' /data/local.prop
			sed -i '/.*_ADJ/d' /system/build.prop
			sed -i '/.*99SuperCharger/d' /data/local/userinit.sh
		fi
		if [ "$opt" -le 13 ] && [ -f "/system/etc/rootfs/init.mapphone_umts.rc" ]; then
			echo " Found /system/etc/rootfs/init.mapphone_umts.rc"
			echo ""
			$sleep
			if [ "$opt" -eq 11 ] || [ "$opt" -eq 12 ]; then
				echo " init.mapphone_umts.rc will be OOM Fixed!"
			elif [ "$opt" -eq 13 ]; then
				echo " init.mapphone_umts.rc to be UnKernelized!"
			else
				echo " init.mapphone_umts.rc to be SuperCharged!"
			fi
			echo ""
			$sleep
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc.unsuper" ]; then
				echo " Backup already exists... leaving backup intact"
			else
				echo " Backing up ORIGINAL settings..."
				cp -r /system/etc/rootfs/init.mapphone_umts.rc /system/etc/rootfs/init.mapphone_umts.rc.unsuper
			fi
			echo ""
			$sleep
		fi
		if [ "$opt" -eq 14 ]; then
			echo -e $hilite" UNSUPERCHARGE..."
			echo ""
			sleep 1
			echo "       ...UNFIX OOM GROUPINGS..."
			echo ""
			sleep 1
			echo "                   ...RESTORE WEAK ASS LAUNCHER"
			echo ""
			echo -e $line$colour
			echo ""
			$sleep
			echo " UnSuperCharging Performance...."
			echo ""
			$sleep
			if [ -f "/sdcard/V8UnSuperChargerError.html" ]; then
				rm /sdcard/V8UnSuperChargerError.html
			fi
			if [ ! -f "/system/etc/init.d/99SuperCharger" ] && [ ! -f "/data/99SuperCharger.sh" ] && [ ! -f "/system/etc/rootfs/init.mapphone_umts.rc" ] && [ ! -f "/system/etc/rootfs/init.mapphone_umts.rc.unsuper" ]; then
				echo -e $hilite" I Got Nothing To Do! Try SuperCharging first!"
				echo ""
				$sleep
cat > /sdcard/V8UnSuperCharged.html <<EOF
There was nothing to uninstall!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V8 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
				echo -e $line
				echo -e $hilite"See /sdcard/V8UnSuperCharged.html for more help!"
				echo -e $line$colour
 				echo ""
 				$sleep
			fi
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc.unsuper" ]; then
				echo -e $hilite"                 BACKUP FOUND!"$colour
				echo ""
				$sleep
				echo "Restore /system/etc/rootfs/init.mapphone_umts.rc"
				echo ""
				$sleep
				cp -fr /system/etc/rootfs/init.mapphone_umts.rc.unsuper /system/etc/rootfs/init.mapphone_umts.rc
			fi
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc" ]; then
				if [ ! -f "/system/etc/rootfs/init.mapphone_umts.rc.unsuper" ]; then
					echo -e $hilite"      ERROR... ERROR... ERROR... ERROR..."
					echo ""
					$sleep
					echo "               BACKUP NOT FOUND!"
					echo ""
					$sleep
					echo "CAN'T restore your ROM's default minfree values!"
					echo ""
					sleep 3
cat > /sdcard/V8UnSuperChargerError.html <<EOF
The backup file, /system/etc/rootfs/init.mapphone_umts.rc.unsuper,<br>
WAS NOT found! Please do a manual restore of init.mapphone_umts.rc<br>
from you ROM's update file!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V8 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
					echo -e $line
					echo -e $hilite"See /sdcard/V8UnSuperChargerError.html for help!"
					echo -e $hilite
					echo ""
					sleep 4
					echo " Clean /system/etc/rootfs/init.mapphone_umts.rc"
					echo ""
					sed -i '/.*_ADJ/d' /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/parameters\/adj/d' /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/vm\/.*oom.*/d' /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/kernel\/panic.*/d' /system/etc/rootfs/init.mapphone_umts.rc
					$sleep	
				fi
			fi
		fi
		if [ "$opt" -le 10 ] || [ "$opt" -eq 14 ]; then
			sed -i '/.*_MEM/d' /data/local.prop
			sed -i '/.*_MEM/d' /system/build.prop
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				echo " Cleaning Up SuperCharge from init.d folder"
				echo ""
				$sleep
				echo " Cleaning Up Grouping Fixes from init.d folder"
				echo ""
				rm /system/etc/init.d/99SuperCharger
				$sleep
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				echo " Cleaning Up SuperCharge from /data folder"
				echo ""
				$sleep
				echo " Cleaning Up Grouping Fixes from /data folder"
				echo ""
				rm /data/99SuperCharger.sh
				$sleep
			fi
		fi
		if [ "$opt" -eq 14 ]; then
			if [ ! -f "/sdcard/V8UnSuperCharged.html" ]; then
				echo " Removed Kernel/Memory Tweaks..."
				echo ""
				$sleep
				if [ ! -f "/sdcard/V8UnSuperChargerError.html" ]; then
					echo " Your ROM's default minfree values are restored!"
					echo ""
					$sleep
				fi
				echo " Out Of Memory (OOM) Groupings UnFixed..."
				echo ""
				$sleep
				echo "                ...OOM Priorities UnFixed..."
				echo ""
				$sleep
				echo "                  Weak Ass Launcher Restored :("
				echo ""
				$sleep
				echo " UnSuperCharging Complete..."
				echo ""
				$sleep
				echo -e $hilite"  REBOOT NOW FOR UNSUPERCHARGE TO TAKE EFFECT!"
				echo ""
				echo -e $line
				echo ""
				$sleep
			fi
			echo -e $sig" UnSuperCharging..."
		fi
		if [ "$opt" -eq 11 ] || [ "$opt" -eq 12 ]; then
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc" ]; then
				sed -i '/parameters\/adj/d' /system/etc/rootfs/init.mapphone_umts.rc
			fi
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				echo " Removing Prior Grouping Fixes from init.d folder"
				echo ""
				sed -i '/parameters\/adj/d' /system/etc/init.d/99SuperCharger
				$sleep
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				echo " Removing Prior Grouping Fixes from /data folder"
				echo ""
				sed -i '/parameters\/adj/d' /data/99SuperCharger.sh
				$sleep
			fi
		fi
		if [ "$opt" -le 13 ]; then
			if [ "$opt" -eq 13 ]; then
				echo " Removing Kernel/Memory Tweaks..."
				echo ""
				$sleep
			fi
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc" ]; then
				if [ "$opt" -ne 13 ]; then
					sed -i '/.*_ADJ/d' /system/etc/rootfs/init.mapphone_umts.rc
				fi
				sed -i '/vm\/.*oom.*/d' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/kernel\/panic.*/d' /system/etc/rootfs/init.mapphone_umts.rc
			fi
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				sed -i '/.*oom.*/d' /system/etc/init.d/99SuperCharger
				sed -i '/.*panic.*/d' /system/etc/init.d/99SuperCharger	
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				sed -i '/.*oom.*/d' /data/99SuperCharger.sh
				sed -i '/.*panic.*/d' /data/99SuperCharger.sh
			fi
			if [ "$opt" -eq 13 ]; then
				echo "               ...Kernel/Memory Tweaks Removed!"
				$sleep
			fi
		fi
		if [ "$opt" -le 12 ]; then
			echo -e $line$colour
 			if [ "$opt" -le 10 ]; then
				echo -e $hilite" SuperCharging Performance: $CONFIG!"
				echo -e $line$colour
				echo ""
				$sleep
				echo " Out Of Memory (OOM) / lowmemorykiller values:"
				echo ""
				$sleep
				awk -F , '{print "    Old MB = "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
				echo -e $hilite"    New MB = $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 mb"$colour
				echo ""
				$sleep
				echo " Old Pages = "`cat /sys/module/lowmemorykiller/parameters/minfree`
				echo -e $hilite" New Pages = $SL1,$SL2,$SL3,$SL4,$SL5,$SL6"$colour
				$sleep
			fi
			if [ -f "/system/etc/rootfs/init.mapphone_umts.rc" ]; then
				if [ "$opt" -le 10 ]; then
					sed -i '/.*_MEM/d' /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/lowmemorykiller/d' /system/etc/rootfs/init.mapphone_umts.rc
				fi
				echo ""
				echo " Fixing Out Of Memory (OOM) Groupings..."
				echo ""
				sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/adj 0,2,4,7,14,15' /system/etc/rootfs/init.mapphone_umts.rc
				$sleep
				echo "                    ...Fixing OOM Priorities..."
				echo ""
				$sleep
				sed -i '/on early/ a\
    setprop ro.FOREGROUND_APP_ADJ 0' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.FOREGROUND_APP_ADJ/ a\
    setprop ro.VISIBLE_APP_ADJ 2' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.PERCEPTIBLE_APP_ADJ 1' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.PERCEPTIBLE_APP_ADJ/ a\
    setprop ro.HEAVY_WEIGHT_APP_ADJ 3' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.HEAVY_WEIGHT_APP_ADJ/ a\
    setprop ro.SECONDARY_SERVER_ADJ 4' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.SECONDARY_SERVER_ADJ/ a\
    setprop ro.BACKUP_APP_ADJ 6' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.BACKUP_APP_ADJ/ a\
    setprop ro.HOME_APP_ADJ 2' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.HOME_APP_ADJ/ a\
    setprop ro.HIDDEN_APP_MIN_ADJ 7' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.CONTENT_PROVIDER_ADJ 8' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/ro.CONTENT_PROVIDER_ADJ/ a\
    setprop ro.EMPTY_APP_ADJ 15' /system/etc/rootfs/init.mapphone_umts.rc
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				$sleep
				if [ "$opt" -eq 12 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ 0/' /system/etc/rootfs/init.mapphone_umts.rc
					echo " Launcher is no Longer Die-Hard..."
					echo ""
					$sleep
					echo "                           ...It's BULLETPROOF!"
				else
					echo " Applying Die-Hard Launcher..."
					echo ""
					$sleep
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ 1/' /system/etc/rootfs/init.mapphone_umts.rc
					echo "                  ...Die-Hard Launcher APPLIED!"
				fi
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
					sed -i '/lowmemorykiller/ a\
    write /sys/module/lowmemorykiller/parameters/minfree '$SL1,$SL2,$SL3,$SL4,$SL5,$SL6 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.EMPTY_APP_ADJ/ a\
    setprop ro.FOREGROUND_APP_MEM '$SL1 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.FOREGROUND_APP_MEM/ a\
    setprop ro.VISIBLE_APP_MEM '$SL2 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.PERCEPTIBLE_APP_MEM '$SP1 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.PERCEPTIBLE_APP_MEM/ a\
    setprop ro.HEAVY_WEIGHT_APP_MEM '$SL3 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.HEAVY_WEIGHT_APP_MEM/ a\
    setprop ro.SECONDARY_SERVER_MEM '$SL3 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.SECONDARY_SERVER_MEM/ a\
    setprop ro.BACKUP_APP_MEM '$SL4 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.BACKUP_APP_MEM/ a\
    setprop ro.HOME_APP_MEM '$SP1 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.HOME_APP_MEM/ a\
    setprop ro.HIDDEN_APP_MEM '$SL4 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.CONTENT_PROVIDER_MEM '$SL5 /system/etc/rootfs/init.mapphone_umts.rc
					sed -i '/ro.CONTENT_PROVIDER_MEM/ a\
    setprop ro.EMPTY_APP_MEM '$SL6 /system/etc/rootfs/init.mapphone_umts.rc
				fi
				echo " Applying Kernel/Memory Tweaks..."
				echo ""
				$sleep
				echo "     oom_kill_allocating_task = 0"
				echo "                 panic_on_oom = 0"
				echo "                panic_on_oops = 1"
				echo "                        panic = 0"
				echo ""
				$sleep
				sed -i '/minfree/ a\
    write /proc/sys/vm/oom_kill_allocating_task 0' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/oom_kill_allocating_task/ a\
    write /proc/sys/vm/panic_on_oom 0' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/panic_on_oom/ a\
    write /proc/sys/kernel/panic_on_oops 1' /system/etc/rootfs/init.mapphone_umts.rc
				sed -i '/panic_on_oops/ a\
    write /proc/sys/kernel/panic 0' /system/etc/rootfs/init.mapphone_umts.rc
			else
				echo ""
				echo " Fixing Out Of Memory (OOM) Groupings..."
				echo ""
				$sleep
				echo "                    ...Fixing OOM Priorities..."
				echo ""
				$sleep
cat >> /data/local.prop <<EOF
ro.FOREGROUND_APP_ADJ=0
ro.VISIBLE_APP_ADJ=2
ro.PERCEPTIBLE_APP_ADJ=1
ro.HEAVY_WEIGHT_APP_ADJ=3
ro.SECONDARY_SERVER_ADJ=4
ro.BACKUP_APP_ADJ=6
ro.HOME_APP_ADJ=2
ro.HIDDEN_APP_MIN_ADJ=7
ro.CONTENT_PROVIDER_ADJ=8
ro.EMPTY_APP_ADJ=15
EOF
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				$sleep
				if [ "$opt" -eq 12 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ=0/' /data/local.prop
					echo " Launcher is no Longer Die-Hard..."
					echo ""
 					$sleep
 					echo "                           ...It's BULLETPROOF!"
				else
					echo " Applying Die-Hard Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ=1/' /data/local.prop
					echo "                  ...Die-Hard Launcher APPLIED!"
				fi
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
cat >> /data/local.prop <<EOF
ro.FOREGROUND_APP_MEM=$SL1
ro.VISIBLE_APP_MEM=$SL2
ro.PERCEPTIBLE_APP_MEM=$SP1
ro.HEAVY_WEIGHT_APP_MEM=$SL3
ro.SECONDARY_SERVER_MEM=$SL3
ro.BACKUP_APP_MEM=$SL4
ro.HOME_APP_MEM=$SP1
ro.HIDDEN_APP_MEM=$SL4
ro.CONTENT_PROVIDER_MEM=$SL5
ro.EMPTY_APP_MEM=$SL6
EOF
				fi
				echo " Applying Kernel/Memory Tweaks..."
				echo ""
				$sleep
				echo "         oom_kill_allocating_task = 0"
				echo "                     panic_on_oom = 0"
				echo "                    panic_on_oops = 1"
				echo "                            panic = 0"
				echo ""
				$sleep
				if [ -d "/system/etc/init.d" ]; then
					if [ -f "/data/99SuperCharger.sh" ]; then
						rm /data/99SuperCharger.sh
					fi
					if [ ! -f "/system/etc/init.d/99SuperCharger" ]; then
						echo "#!/system/bin/sh" > /system/etc/init.d/99SuperCharger
					fi
					echo "echo "0,2,4,7,14,15" > /sys/module/lowmemorykiller/parameters/adj;" >> /system/etc/init.d/99SuperCharger
					if [ "$opt" -le 10 ]; then
						echo "echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /sys/module/lowmemorykiller/parameters/minfree;" >> /system/etc/init.d/99SuperCharger
					fi
					echo "echo "0" > /proc/sys/vm/oom_kill_allocating_task;" >> /system/etc/init.d/99SuperCharger
					echo "echo "0" > /proc/sys/vm/panic_on_oom;" >> /system/etc/init.d/99SuperCharger
					echo "busybox sysctl -w kernel.panic_on_oops=1;" >> /system/etc/init.d/99SuperCharger
					echo "busybox sysctl -w kernel.panic=0;" >> /system/etc/init.d/99SuperCharger
					chown 0.0 /system/etc/init.d/99SuperCharger
					chmod 777 /system/etc/init.d/99SuperCharger
 					if [ ! -f "/data/local/userinit.sh" ]; then
						echo "#!/system/bin/sh" > /data/local/userinit.sh
					fi
					echo "sh /system/etc/init.d/99SuperCharger;" >> /data/local/userinit.sh
					chown 0.0 /data/local/userinit.sh
					chmod 777 /data/local/userinit.sh
				else
					if [ -f "/system/etc/init.d/99SuperCharger" ]; then
						rm /system/etc/init.d/99SuperCharger
					fi
					if [ ! -f "/data/99SuperCharger.sh" ]; then
						echo "#!/system/bin/sh" > /data/99SuperCharger.sh
					fi
					echo "echo "0,2,4,7,14,15" > /sys/module/lowmemorykiller/parameters/adj;" >> /data/99SuperCharger.sh
					if [ "$opt" -le 10 ]; then
						echo "echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /sys/module/lowmemorykiller/parameters/minfree;" >> /data/99SuperCharger.sh
					fi
					echo "echo "0" > /proc/sys/vm/oom_kill_allocating_task;" >> /data/99SuperCharger.sh
					echo "echo "0" > /proc/sys/vm/panic_on_oom;" >> /data/99SuperCharger.sh
					echo "busybox sysctl -w kernel.panic_on_oops=1;" >> /data/99SuperCharger.sh
					echo "busybox sysctl -w kernel.panic=0;" >> /data/99SuperCharger.sh
					echo -e $hilite" SORRY, INCOMPATIBLE ROM! - but not for long  ;)"$colour
					echo ""
					$sleep
					if [ "$opt" -le 10 ]; then
						echo " Some Changes are TEMPORARY & WON'T PERSIST!"
						echo ""
						$sleep
						echo " To enable PERSISTENT SuperCharger settings..."
						echo ""
						$sleep
						echo "...Die-Hard Launcher and OOM Grouping Fixes..."
					else
						echo " To enable PERSISTENT OOM Grouping Fixes..."
					fi
					echo -e $hilite
					$sleep
					if [ $smrun -gt 0 ] 2>/dev/null; then
cat > /sdcard/V8SuperChargerScriptManagerHelp.html <<EOF
Yay! You already have <a href="http://market.android.com/details?id=os.tools.scriptmanager">Script Manager!</a><br>
After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, enable "Browse as Root."<br>
Press the menu key and then Browser.<br>
Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V8 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
						echo " Use THIS app to load 99SuperCharger.sh on boot!"
						echo ""
						$sleep
						echo -e $line
						echo -e $hilite"See /sdcard/V8SuperChargerScriptManagerHelp.html"
						echo -e $line$colour
					else
						echo " ..Please ENABLE boot scripts to be run from..."
						echo "                  .../system/etc/init.d folder!"
						echo " Easier: Script Manager can solve everything ;)"
						echo ""
						$sleep
cat > /sdcard/V8SuperChargerHelp.html <<EOF
To enable init.d boot scripts, go <a href="http://forum.xda-developers.com/showthread.php?t=1017291">HERE</a><br>
This is for Motorolas! At least some of them anyway.<br>
If that page is incompatible with your phone, do some reasearch!<br>
<br>
A very nice and easy solution is to simply use<br>
Script Manager to load scripts on boot - on ANY ROM!<br>
Here is the <a href="http://market.android.com/details?id=os.tools.scriptmanager">Market Link</a><br>
So first, you use Script Manager to run the V8 SuperCharger script.<br>
Then use it again to load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the 99SuperCharger.sh properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V8 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
						echo -e $line
						echo -e $hilite" See /sdcard/V8SuperChargerHelp.html for help!"
						echo -e $line$colour
					fi
					echo ""
					$sleep
				fi
			fi
			echo "0,2,4,7,14,15" > /sys/module/lowmemorykiller/parameters/adj
			if [ "$opt" -le 10 ]; then
				echo " Setting lowmemorykiller to $MB1,$MB2,$MB3,$MB4,$MB5,$MB6 mb"
				echo ""
				echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /sys/module/lowmemorykiller/parameters/minfree
				$sleep
				echo " OOM minfrees levels are now set to..."
				echo ""
				echo "         ..."`cat /sys/module/lowmemorykiller/parameters/minfree`
				echo ""
				$sleep
				echo -e $hilite"      SUPERCHARGE IN EFFECT IMMEDIATELY!!"$colour
				echo ""
				$sleep
				echo " If this is your first V8 SuperCharge...."
				echo ""
				$sleep
			fi
			echo -e $hilite" REBOOT NOW TO ENABLE..."
			echo ""
			$sleep
			if [ "$opt" -eq 12 ]; then
				echo "          ...BULLETPROOF LAUNCHER..."
			else
				echo "            ...DIE-HARD LAUNCHER..."
			fi
			echo ""
			$sleep
			echo "                     ...AND OOM GROUPING FIXES!"
			echo ""
			$sleep
			if [ -f "/sdcard/V8SuperChargerHelp.html" ]; then
				echo -e $line$hilite
				echo "   ...AND RE-RUN THIS SCRIPT AFTER EACH REBOOT!"
			elif [ -f "/sdcard/V8SuperChargerScriptManagerHelp.html" ]; then
				echo -e $line$hilite
				echo " DON'T FORGET to have Script Manager load..."
				echo "            .../data/99SuperCharger.sh on boot!"
			elif [ "$opt" -le 10 ]; then
				echo -e $line$hilite
				echo "$CONFIG Settings WILL PERSIST after reboot!"
			fi
			echo -e $line
			echo ""
			$sleep
		fi
	fi
	if [ "$opt" -eq 15 ]; then
cat >> /data/local.prop <<EOF
ro.ril.hsxpa=3
ro.ril.gprsclass=12
ro.ril.hep=1
ro.ril.enable.dtm=1
ro.ril.hsdpa.category=28
ro.ril.enable.a53=1
ro.ril.enable.3g.prefix=1
ro.ril.htcmaskw1.bitmask=4294967295
ro.ril.htcmaskw1=14449
ro.ril.hsupa.category=9
debug.sf.hw=1
EOF
	fi
	if [ "$opt" -eq 16 ] || [ "$opt" -eq 17 ]; then
		if [ -d "/system/etc/init.d" ]; then
			if [ "$opt" -eq 16 ]; then
				echo " Accepted Custom Overclock Values... "
				echo ""
				$sleep
				echo "         $MHZ5 mhz @ $VSEL5 vsel"
				echo "            $MHZ4 mhz @ $VSEL4 vsel"
				echo "               $MHZ3 mhz @ $VSEL3 vsel"
				echo "                  $MHZ2 mhz @ $VSEL2 vsel"
				echo "                     $MHZ1 mhz @ $VSEL1 vsel"
				echo ""
				$sleep
cat > /system/etc/init.d/99sc-overclock <<EOF
#!/system/bin/sh
echo "5 $(($MHZ5*1000000)) $VSEL5" > /proc/overclock/mpu_opps;
echo "4 $(($MHZ4*1000000)) $VSEL4" > /proc/overclock/mpu_opps;
echo "3 $(($MHZ3*1000000)) $VSEL3" > /proc/overclock/mpu_opps;
echo "2 $(($MHZ2*1000000)) $VSEL2" > /proc/overclock/mpu_opps;
echo "1 $(($MHZ1*1000000)) $VSEL1" > /proc/overclock/mpu_opps;
EOF
				chmod 755 /system/etc/init.d/99sc-overclock
				chown 0.2000 /system/etc/init.d/99sc-overclock
				echo " Created /system/etc/init.d/99sc-overclock..."
				echo ""
				$sleep
				echo -e $hilite" REBOOT NOW TO ACTIVATE NEW OVERCLOCK SETTINGS!"
			else
				echo " Removing Custom Overclock Values... "
				echo ""
				$sleep
				if [ -f "/system/etc/init.d/99sc-overclock" ]; then
					rm /system/etc/init.d/99sc-overclock
					echo " Deleted /system/etc/init.d/99sc-overclock..."
					echo ""
					$sleep
					echo -e $hilite" REBOOT NOW TO RESTORE PRIOR OVERCLOCK SETTINGS"
				else
					echo -e $hilite" /system/etc/init.d/99sc-overclock not found :P"
				fi
			fi
		else
			echo -e $hilite" /system/etc/init.d folder not found :P"
		fi
		echo ""
		echo -e $line
		echo ""
		$sleep
		echo -e $sig" Overclocker & UnOverclocker..."
	fi
	if [ "$opt" -ge 2 ] && [ "$opt" -le 12 ] || [ "$opt" -eq 19 ]; then
		echo -e $sig" SuperCharging, OOM Grouping & Priority Fixes.."
		echo ""
		$sleep
		echo "          ...Die-Hard & BulletProof Launchers.."
	fi
	if [ "$opt" -ge 1 ] && [ "$opt" -le 19 ]; then
		echo ""
		$sleep
		echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
		sleep 2
	fi
	if [ "$opt" -eq 19 ]; then
 		echo ""
 		echo -e $magnetabold"                                     Buh Bye :)"
 		echo ""
		$sleep
		exit 0
	fi
fi
mount -o remount,ro /system; mount -o remount,ro /dev/block/mtdblock0 /system; mount -o remount,ro /dev/block/mtdblock1 /system; mount -o remount,ro /dev/block/mtdblock2 /system; mount -o remount,ro /dev/block/mtdblock3 /system; mount -o remount,ro /dev/block/mtdblock4 /system; mount -o remount,ro /dev/block/mtdblock5 /system; mount -o remount,ro /dev/block/mtdblock6 /system; mount -o remount,ro /dev/block/mtdblock7 /system; mount -o remount,ro /dev/block/mtdblock8 /system; mount -o remount,ro /dev/block/mtdblock9 /system 2>/dev/null
done
