#!/system/bin/sh
#
# V6 SuperCharger Update 9 RC13 by -=zeppelinrox=-
#
# When using scripting tricks, ideas, or code snippets from here, GIVE PROPER CREDIT.
# There are many things may look simple, but actually took a lot of time, trial, and error to get perfected.
# So DO NOT remove credits, put your name on top, and pretend it's your creation.
# That's called kanging and makes you a dumbass.
#
# This script can be used freely and can even be modified for PERSONAL USE ONLY.
# It can be freely incorporated into ROMs - provided that proper credit is given WITH a link back to the XDA SuperCharger thread.
# If you want to share it or make a thread about it, just provide a link to the main thread.
#      - This ensures that users will always be getting the latest versions.
# Prohibited: Any modification (excluding personal use), repackaging, redistribution, or mirrors of my work are NOT PERMITTED.
# Thanks, zeppelinrox.
#
# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.
# SuperMinFree Calculator & MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]
# Entropy-ness Enlarger (sysctl tweak for kernel.random.read_wakeup_threshold that keeps entropy_avail full) discovered by zeppelinrox.
#
# See http://goo.gl/qM6yR - SuperCharger thread at XDA
# See http://goo.gl/IvGL1 - Ultimatic Jar Patcher Tools thread at XDA for more Goodness and MultiTasking!
#                           ie. Patch services.jar for ICS and above to get 100% SuperCharged with "Jelly ISCream"
#                               Patch services.jar for ALL ROMS (Froyo and above) and get "Maximum MultiTasking Mods"
#                               Patch services.jar for Sense 4 and above ROMS (Not needed for Sense 3.6 and below) and get a "Non-Sense App Limit"
#
# See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article!
# See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why 'Free RAM' Is NOT Wasted RAM!"
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.
# See http://goo.gl/P8Bvu - How Entropy-ness Enlarger works.
# See http://goo.gl/Zc85j - Possible reasons why it may actually do something :p
#
# For Debugging: Delete the # at the beginning of the next line and watch the output on the next run!
# set -x
#
PATH=$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=$PATH:`ls -d /data/local/busybox*/xbin 2>/dev/null`; fi
line=================================================
if [ ! "`busybox --help`" ]; then username=Baby
else username=`busybox grep -m 1 "\@gmail" /data/data/com.android.vending/shared_prefs/vending_preferences.xml | busybox sed 's/.*_\|@.*//g'` 2>/dev/null
fi
echo ""
echo $line
echo ""
echo " Hey, Hey, $username..."
echo ""
sleep 1
echo "  ...SuperCharge Your Way..."
echo ""
sleep 1
echo "         ...Watch Your Launcher Rip..."
echo ""
sleep 1
echo "                              ...Lags Keep Away!"
echo ""
sleep 1
echo $line
echo " NOTE: BUSYBOX v1.16.2 OR HIGHER IS RECOMMENDED!"
echo $line
echo ""
sleep 2
remount(){
	mount -o remount,$1 / 2>/dev/null
	mount -o remount,$1 rootfs 2>/dev/null
	busybox mount -o remount,$1 / 2>/dev/null
	busybox mount -o remount,$1 rootfs 2>/dev/null
	mount -o remount,$1 /system 2>/dev/null
	busybox mount -o remount,$1 /system 2>/dev/null
	busybox mount -o remount,$1 $(busybox mount | awk '/ \/system /{print $1,$3}') 2>/dev/null
}
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
remount rw
if [ "`awk '/ \/ /&&/ro,/' /proc/mounts`" ]; then
	echo " Problem! Can't mount root as read write..."
	echo ""
	sleep 2
	echo "      ...so watch out for the pretty errors! :p"
	echo ""
	sleep 2
	echo " But maybe you should just reboot first!"
	echo ""
	sleep 2
fi
if [ -d "/sqlite_stmt_journals" ]; then madesqlitefolder=0
else mkdir /sqlite_stmt_journals; madesqlitefolder=1
fi
if [ -e "$EXTERNAL_STORAGE" ]; then storage=${EXTERNAL_STORAGE#*mnt}
elif [ -e "$EXTERNAL_STORAGE2" ]; then storage=${EXTERNAL_STORAGE2#*mnt}
elif [ -e "$USBHOST_STORAGE" ]; then storage=${USBHOST_STORAGE#*mnt}
elif [ -e "$SECONDARY_STORAGE" ]; then storage=${SECONDARY_STORAGE#*mnt}
elif [ -e "$PHONE_STORAGE" ]; then storage=${PHONE_STORAGE#*mnt}
elif [ -e "/sdcard1" ]; then storage=/sdcard1
elif [ -e "/sdcard0" ]; then storage=/sdcard0
else storage="/sdcard"
fi
storagename=/${storage##*/}
cat > $storage/!SuperCharger.html <<EOF
<br>
<br>
<i><u><b>The -=V6 SuperCharger=-</b></u> created by -=zeppelinrox=-</i><br>
<br>
<u><b>Owner's Guide</b></u><br>
<br>
Hi! I hope that the V6 SuperCharger script is working well for you!<br>
<br>
<b>Did this file just auto load?</b> If so, you have init.d boot scripts working and there are 3 reasons why this could happen:<br>
1. You're <u>not</u> 100% SuperCharged and minfrees <u>don't match</u>! If this is the case, <u><b>READ</b></u> this entire help file - <u><b>BEFORE</b></u> asking redundant questions!</u>. Also check /data/BootLog_SuperCharger.log and /data/Ran_SuperCharger.log!<br>
2. You set Wheel Alignment or Fix Alignment to run on boot but you don't have the zipalign binary installed. Get it by installing the <a href="http://goo.gl/1JPl8">SuperCharger Starter Kit</a>. Also check /data/BootLog_ZepAlign.log or /data/BootLog_FixAlign.log!<br>
3. You set Detailing to run on boot but you don't have the sqlite3 binary installed. Get it by installing the <a href="http://goo.gl/1JPl8">SuperCharger Starter Kit</a>. Also check /data/BootLog_Detailing.log!<br>
<br>
Here is some <b><u>Background Info</u></b> in case you're curious...<br>
<br>
<a href="http://goo.gl/krtf9">Linux Memory Consumption</a> - Nice article!<br>
<a href="http://goo.gl/hFdNO">Memory and SuperCharging Overview</a>, or... "Why 'Free RAM' Is NOT Wasted RAM!"<br>
<a href="http://goo.gl/4w0ba">MFK Calculator Info</a> - explanation for <b>vm.min_free_kbytes</b><br>
<a href="http://goo.gl/P8Bvu">Entropy-ness Enlarger Info</a> - explanation for <b>kernel.random.read_wakeup_threshold</b><br>
<a href="http://goo.gl/Zc85j">Entropy-ness Enlarger Musings...</a> - Possible reasons why it may actually do something :p<br>
<br>
<u><b>Patching services.jar/odex for ALL ROMS:</b></u>: It actually has 3 Mods. See the <a href="http://goo.gl/IvGL1">-=Ultimatic Jar Patcher Tools=-</a> thread.<br>
Mod 1. "Jelly ISCream" for ICS, Jelly Bean and above. This will SuperCharge Your Home Launcher and ADJ/OOM Priorities!<br>
Mod 2. "Maximum MultiTasking Mods" for Froyo and above<br>
Mod 3. "Non-Sense App Limit" for Sense 4 and above (Not needed for Sense 3.6 and below).<br>
<br>
Ok... now be sure to have <a href="http://play.google.com/store/apps/details?id=com.jrummy.busybox.installer">BusyBox</a> installed or else the scripts won't work!<br>
Most custom roms should already have a version installed and that usually works OK.<br>
So if you need to, only install <b>BusyBox v1.16.2 or higher!</b><br>
Note that some versions above v1.18.2 and below v1.19.1 sometimes give errors so <u>PAY ATTENTION</u> to the script output!<br>
Versions above v1.19.0 should be fine though.<br>
If all else fails or if you get "<b>applet not found</b>" errors, just grab BusyBox from the <a href="http://goo.gl/qM6yR">V6 SuperCharger Thread!</a><br>
Or even better, get the <b>SuperCharger Starter Kit!</b>
<br>
A nice app for running the script is <a href="http://play.google.com/store/apps/details?id=os.tools.scriptmanager">Script Manager</a><br>
It can even load scripts on boot - on ANY ROM!<br>
Plus, it even has WIDGETS!<br>
So you can actually put a V6 SuperCharger shortcut on your desktop, launch it, and have a quick peek at your current status!<br>
<br>
But first, you need to set up Script Manager properly!<br>
In the "Config" settings, enable "Browse as Root."<br>
Then browse to where you saved the V6 SuperCharger script, select it, and in the script's properties box, be sure to select "Run as Root" ie. SuperUser!<br>
<b>Do NOT run this file at boot!</b> (You don't want to run the install on every boot, do you?)<br>
Run the V6 SuperCharger script, touch the screen to access the soft keyboard, and enter your choice :)<br>
<br>
<u><b>Stock ROMs</b></u>: After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, be sure that "Browse as Root" is enabled.<br>
Press the menu key and then Browser. Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" (SuperUser) and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically ;^]<br>
<br>
<u><b>Custom ROMs</b></u>: If you have a custom rom that loads /system/etc/init.d boot scripts,<br>
You DON'T need to use Script Manager to load a boot script. It will all be automatic!<br>
Also, if you can run boot scripts from the /system/etc/init.d folder, there are other options.<br>
For example you can use an app like Terminal Emulator to run the script.<br>
<u>PRE-ICS ROMS</u>: If your ROM has the option, <b>DISABLE "Lock Home In Memory.</b> This takes effect immediately.<br>
Alternately, <u>if you need to free up extra ram</u>, you can use "Lock Home in Memory" as a "Saftey Lock".<br>
ie. Use it to toggle your launcher from "Bulletproof" (0) or Hard To Kill (1) to "Weak" (2) in the event that you want to make the launcher an easy kill and free up extra RAM ;)<br>
<br>
<u><b>If Settings Don't Stick:</b></u> If you have Auto Memory Manager, DISABLE SuperUser permissions and if you have AutoKiller Memory Optimizer, DISABLE the apply settings at boot option!<br>
Also, if you have a <b>Custom ROM</b>, there might be something in the init.d folder that interferes with priorities and minfrees.<br>
If you can't find the problem, a quick fix is to have Script Manager run <b>/system/etc/init.d/*99SuperCharger</b> "at boot" and "as root."<br>
<br>
Another option is to make a Script Manager widget for <b>/system/etc/init.d/*99SuperCharger</b> or <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
<br>
For those with a <b>Milestone</b>, I made a version for <b>Androidiani Open Recovery</b> too :D<br>
Just extract the zip to the root of $storage (it contains the directory structure), load AOR, and there will be a SuperCharger Menu on the main screen! <br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://goo.gl/qM6yR">-=V6 SuperCharger Thread=-</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
<br>
EOF
load_help_file(){
	echo ""
	echo $line
	echo ""
	$sleep
	LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!SuperCharger.html
	echo ""
	$sleep
	echo $line
}
load_page(){
	echo $line
	echo ""
	$sleep
	LD_LIBRARY_PATH=/vendor/lib:/system/lib am start http://goo.gl/$1
	echo ""
}
if [ ! -s "$storage/!SuperCharger.html" ]; then FAIL=yes
	echo " Big Problem! Can't create the help file!"
	echo ""
	sleep 2
	echo " Possible reasons:"
	echo ""
	sleep 2
	echo " 1. Not running as root...?"
	sleep 1
	echo " 2. Busybox isn't installed...?"
	sleep 1
	echo " 3. Busybox can't mount as r/w for some reason."
	echo ""
	sleep 2
fi
if [ "$madesqlitefolder" -eq 1 ]; then rm -r /sqlite_stmt_journals; fi 2>/dev/null
remount ro
echo $line
if [ "`grep 2>/dev/null`" = "Toolbox!" ] || [ "`cp 2>/dev/null`" = "Toolbox!" ]; then sleep="sleep 3"
	echo "                 What The Hell?"
	echo $line
	echo ""
	$sleep
	echo " This ROM has fubarred commands such as..."
	echo ""
	$sleep
	echo "                    ...\"grep\" or \"cp\" (copy)..."
	echo ""
	$sleep
	echo "   ...which can break ANY shell script or apps!"
	echo ""
	$sleep
	echo " Gonna fix up that crap for you..."
	echo ""
	$sleep
	remount rw
	for i in /system/bin/*; do
		if [ "`cat $i`" = "toolbox" ]; then rm $i; fi
	done
	remount ro
	echo $line
	echo "          All Done! And You're Welcome!"
	echo $line
	echo ""
	$sleep
elif [ "`echo $0 | grep "init\.d"`" ]; then sleep="sleep 4"
	echo "               HAHAHAHAHAHAHAHA!!"
	echo $line
	echo ""
	$sleep
	echo " Why the hell is this in the init.d folder?!"
	echo ""
	$sleep
	echo " This AIN'T a start up script... LOL!"
	echo ""
	$sleep
	echo " Somebody should have read this help file..."
	load_help_file
	echo "            No SuperCharger For You!"
	echo $line
	echo ""
	$sleep
	exit 69
fi
echo "        Test Driving Your Android Device..."
echo $line
if [ ! "`busybox --help`" ]; then FAIL=yes; sleep="sleep 4"
	echo ""
	sleep 1
	echo " BusyBox NOT FOUND..."
	echo ""
	$sleep
	echo $line
	echo "                           ...No Supe For You!!"
	echo $line
	echo ""
	$sleep
	echo " If you continue, problems can occur..."
	echo ""
	$sleep
	echo "                         ...and even bootloops!"
	echo ""
	$sleep
	echo "  ...Please install BusyBox and try again..."
	echo ""
	$sleep
	echo " Get BusyBox from the V6 SuperCharger Thread!"
	echo ""
	load_page qM6yR
	echo $line
	echo ""
	$sleep
	echo " I hope that helped! :^)"
	echo ""
	$sleep
	echo " Continue anyway...?"
	echo ""
	sleep 2
	echo -n " Enter Y for Yes, any key for No: "
	read bbnotfound
	echo ""
	case $bbnotfound in
	  y|Y)echo " uh... right... okay..."
		  echo ""
		  echo $line;;
		*)echo $line
		  echo "            No SuperCharger For You!"
		  echo $line
		  echo ""
		  $sleep
		  exit 69;;
	esac
else
	sleep 2
	if [ ! "`busybox --help | grep awk`" ]; then badbb=yes; echo " WARNING: awk applet NOT FOUND... Bad BusyBox!"; echo $line; sleep 2; fi
	if [ ! "`busybox --help | grep sed`" ]; then badbb=yes; echo " WARNING: sed applet NOT FOUND... Bad BusyBox!"; echo $line; sleep 2; fi
	if [ ! "`busybox --help | grep pgrep`" ]; then badbb=yes; echo " WARNING: pgrep applet NOT FOUND... Bad BusyBox!"; echo $line; sleep 2; fi
	if [ "$badbb" ]; then FAIL=yes; sleep="sleep 4"
		echo ""
		echo " Your BusyBox is an EPIC FAIL... :p"
		echo ""
		$sleep
		echo " It's version does NOT even matter because..."
		echo ""
		$sleep
		echo $line
		echo "    It's MISSING basic applets and functions!"
		echo $line
		echo ""
		$sleep
		echo " If you continue, problems can occur..."
		echo ""
		$sleep
		echo "                         ...and even bootloops!"
		echo ""
		$sleep
		echo " ...Please reinstall BusyBox and try again..."
		echo ""
		$sleep
		echo " Get BusyBox from the V6 SuperCharger Thread!"
		echo ""
		$sleep
		echo $line
		echo " And DON'T play stupid and ask me what's wrong!!"
		load_page qM6yR
		echo $line
		echo ""
		$sleep
		echo " I hope that helped! :^)"
		echo ""
		$sleep
	fi
	test1=`busybox | awk 'NR==1{print $1}'`
	test2=`busybox | awk 'NR==1{print $2}'`
	test3=`echo 1000,2000,3000,4000,5000,6000 | awk -F, '{OFMT="%.0f";print $1/256, $2/256, $3/256, $4/256, $5/256, $6/256}'`
	echo ""
	if [ "$test2" ]; then echo " BusyBox $test2 Found!"
	else echo " ERROR! Can't determine BusyBox version!"; FAIL=yes
	fi
	echo ""
	sleep 1
	if [ "$test1" = "BusyBox" ] && [ "$test3" = "4 8 12 16 20 23" ]; then
		echo "   AWKing Awesome... AWK test passed!"
		echo ""
		sleep 1
		test4=`pgrep ini`
		if [ "$test4" ]; then echo "          Groovy... pgrep test passed too!"
		else FAIL=yes; sleep="sleep 4"
			echo " BusyBox has holes in it..."
			echo ""
			$sleep
			echo " ...BulletProof Apps ain't gonna work..."
			echo ""
			$sleep
			echo $line
			echo "                          ...pgrep test FAILED!"
			echo $line
		fi
	else FAIL=yes; sleep="sleep 4"
		echo " There was an AWK error..."
		echo ""
		$sleep
		echo $line
		echo "                              ...what the AWK!?"
		echo $line
		echo ""
		$sleep
		if [ "$test3" != "4 8 12 16 20 23" ]; then
			echo $line
			echo "   It can't even do... SIMPLE math! LOL WUT!?"
			echo $line
			echo ""
			$sleep
		fi
		echo " If you continue, problems can occur..."
		echo ""
		$sleep
		echo "                         ...and even bootloops!"
		echo ""
		$sleep
		echo " ...Please reinstall BusyBox and try again..."
		echo ""
		$sleep
		echo " Get BusyBox from the V6 SuperCharger Thread!"
		echo ""
		$sleep
		echo $line
		echo " And DON'T DARE ask me to support broken shit!!"
		load_page qM6yR
		echo $line
		echo ""
		$sleep
		echo " I hope that helped! :^)"
		echo ""
		$sleep
		echo " Continue anyway...?"
		echo ""
		sleep 2
		echo -n " Enter Y for Yes, any key for No: "
		read awkerror
		echo ""
		case $awkerror in
		  y|Y)echo " uh... right... okay..."
			  echo ""
			  echo $line;;
			*)echo $line
			  echo "            No SuperCharger For You!"
			  echo $line
			  echo ""
			  $sleep
			  exit 69;;
		esac
	fi
fi 2>/dev/null
echo ""
sleep 1
id=$(id); id=${id#*=}; id=${id%%[\( ]*}
if [ "$id" = "0" ] || [ "$id" = "root" ]; then echo "        Nice! You're Running as Root/SuperUser!"
else FAIL=yes; sleep="sleep 4"
	echo $line
	echo " You are NOT running this script as root..."
	echo $line
	echo ""
	$sleep
	echo $line
	echo "                      ...No SuperUser For You!!"
	echo $line
	echo ""
	$sleep
	echo "         ...Please Run as Root and try again..."
	echo ""
	$sleep
	echo " Loading Owner's Guide..."
	load_help_file
	echo ""
	$sleep
	echo " I hope that helped! :^)"
	echo ""
	$sleep
	echo " Oh... and one more thing..."
	echo ""
	echo $line
	echo "            No SuperCharger For You!"
	echo $line
	echo ""
	$sleep
	exit 69
fi
echo ""
sleep 1
echo $line
echo -n "            Test Drive Report: "
if [ "$FAIL" ]; then echo "FAIL!"
else echo "PASS!"
fi
echo $line
echo ""
sleep 2
ver=V6U9RC13ForYourLag_QF
if [ -f "/system/build.prop.unsuper" ] && [ "/dev/alarm" -nt "/system/build.prop.unsuper" ]; then scranb4boot=yes; fi
animspeed="busybox sleep 0.1"
smrun=`pgrep scriptmanager`
bbversion=`busybox | awk 'NR==1{print $1,$2}'`
if [ -f "/sys/kernel/mm/uksm/run" ]; then KSM=UKSM; ksmdir=uksm
else KSM=KSM
	if [ -f "/sys/kernel/mm/ksm/run" ]; then ksmdir=ksm; fi
fi
if [ -e "/dev/frandom" ]; then
	frandomtype=`stat /dev/frandom | awk '/type/{print $NF}'`
	erandomtype=`stat /dev/erandom | awk '/type/{print $NF}'`
fi
opt=0;ran=0;gb=0;preics=yes;jb=0;memory=c;a=already_modified;b=bad_jar;ram1=11736;oomstick=0;ADJs=0;OOMs=0;minfrees=0
ram=$((`awk '/MemTotal/{print $2}' /proc/meminfo`/1024))
heapsize=$((ram*20/100+ram*20/100%2))
heapgrowthlimit=$((heapsize/2))
LIMIT1=0;LIMIT2=3;LIMIT3=6;LIMIT4=10;LIMIT5=12;LIMIT6=15
newscadj="$LIMIT1,$LIMIT2,$LIMIT3,$LIMIT4,$LIMIT5,$LIMIT6";oldscadj1="0,3,5,7,14,15";oldscadj2="0,2,4,7,14,15";oldscadj3="0,3,6,10,14,15";oldscadj4="0,4,8,12,14,15";scamadj1="0,2,5,7,14,15";scamadj2="0,1,2,4,6,15"
minfreefile="/sys/module/lowmemorykiller/parameters/minfree"
if [ -f "/proc/1/oom_adj" ]; then oom_adj="oom_adj"
elif [ -f "/proc/1/oom_score_adj" ]; then  oom_adj="oom_score_adj"
fi
if [ "`busybox ps -w`" ]; then w=" -w"; fi 2>/dev/null
TMP_DIR="$storage/V6_SuperCharger/temp"
homeadj=`getprop ro.HOME_APP_ADJ`;FA=`getprop ro.FOREGROUND_APP_ADJ`;PA=`getprop ro.PERCEPTIBLE_APP_ADJ`;VA=`getprop ro.VISIBLE_APP_ADJ`;low=w
api="`awk '/ro.build.version.sdk/{gsub(/[^0-9]/,"");print}' /system/build.prop`"
if [ "$api" -ge 14 ]; then postics=yes;preics=;FA=0;PA=2
	if [ "$api" -ge 16 ]; then jb=1; fi
elif [ "$PA" ]; then gb=1
fi
initrcpath1="/init.rc"
initrcpath="/data$initrcpath1"
initrcbackup=$initrcpath.unsuper
remount rw
for rc in `awk '/import/&&!/#|ro\.hardware/{print $NF}' $initrcpath1` `busybox find /system/ -iname "*.rc"`; do
	if [ "`echo $rc | awk '!/goldfish|ueventd/'`" ] && [ ! "`echo $allrcpaths | grep $rc`" ]; then
		if [ ! -f "$rc" ]; then
			echo "on early-boot" > $rc
			echo "on boot" >> $rc
			touch $rc.unsuper
		fi
		chown 0.0 $rc; chmod 644 $rc
		allrcpaths="$allrcpaths $rc"
		if [ "`grep -ls "on boot" $rc`" ]; then rcpaths="$rcpaths $rc"; fi
	fi
done
remount ro
alias echo="busybox echo"
alias rm="busybox rm"
crapp=`awk -F \" '/artprojects\.RAM/{print $2}' /d*/system/packages.xml`
mkdir /data/V6_SuperCharger 2>/dev/null
mkdir $storage/V6_SuperCharger 2>/dev/null
mkdir $storage/V6_SuperCharger/data 2>/dev/null
mkdir $storage/V6_SuperCharger/data/V6_SuperCharger 2>/dev/null
mkdir $storage/V6_SuperCharger/data/V6_SuperCharger/PowerShift_Scripts 2>/dev/null
mkdir $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_One_Shots 2>/dev/null
mkdir $storage/V6_SuperCharger/system 2>/dev/null
mkdir $storage/V6_SuperCharger/system/xbin 2>/dev/null
mkdir $storage/V6_SuperCharger/system/etc 2>/dev/null
mkdir $storage/V6_SuperCharger/system/etc/init.d 2>/dev/null
mkdir $storage/V6_SuperCharger/temp 2>/dev/null
if [ "`ls $storage/V6_SuperCharger/SuperCharger*`" ]; then mv $storage/V6_SuperCharger/SuperCharger* $storage/V6_SuperCharger/data/V6_SuperCharger; fi 2>/dev/null
if [ "`ls $storage/V6_SuperCharger/BulletProof_Apps*`" ]; then mv $storage/V6_SuperCharger/BulletProof_Apps* $storage/V6_SuperCharger/data/V6_SuperCharger; fi 2>/dev/null
if [ "`ls $storage/V6_SuperCharger/9*.sh`" ]; then mv $storage/V6_SuperCharger/9*.sh $storage/V6_SuperCharger/data; fi 2>/dev/null
if [ "`ls $storage/V6_SuperCharger/\!*.sh`" ]; then mv $storage/V6_SuperCharger/\!*.sh $storage/V6_SuperCharger/data/V6_SuperCharger; fi 2>/dev/null
if [ -d "$storage/V6_SuperCharger/BulletProof_One_Shots" ]; then
	cp -fr $storage/V6_SuperCharger/BulletProof_One_Shots $storage/V6_SuperCharger/data/V6_SuperCharger
	rm -r $storage/V6_SuperCharger/BulletProof_One_Shots
fi
if [ -d "$storage/V6_SuperCharger/PowerShift_Scripts" ]; then
	cp -fr $storage/V6_SuperCharger/PowerShift_Scripts $storage/V6_SuperCharger/data/V6_SuperCharger
	rm -r $storage/V6_SuperCharger/PowerShift_Scripts
fi
if [ -f "$storage/V6_SuperCharger/99super" ]; then mv $storage/V6_SuperCharger/99super $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/vac" ]; then mv $storage/V6_SuperCharger/vac $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/zepalign" ]; then mv $storage/V6_SuperCharger/zepalign $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/fixfc" ]; then mv $storage/V6_SuperCharger/fixfc $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/fixalign" ]; then mv $storage/V6_SuperCharger/fixalign $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/flush" ]; then mv $storage/V6_SuperCharger/flush $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/sclean" ]; then mv $storage/V6_SuperCharger/sclean $storage/V6_SuperCharger/system/xbin; fi
if [ -f "$storage/V6_SuperCharger/v6" ]; then mv $storage/V6_SuperCharger/v6 $storage/V6_SuperCharger/system/xbin; fi
if [ "`ls $storage/V6_SuperCharger/*9*`" ]; then mv $storage/V6_SuperCharger/*9* $storage/V6_SuperCharger/system/etc/init.d; fi 2>/dev/null
if [ -f "/data/V6_SuperCharger/SuperChargerMinfree" ]; then
	cp -fr /data/V6_SuperCharger/SuperChargerMinfree /data/V6_SuperCharger/SuperChargerMinfreeOld
	scminfreeold=`cat /data/V6_SuperCharger/SuperChargerMinfreeOld`
fi
load_options(){
	speed=`awk -F, '{print $1}' /data/V6_SuperCharger/SuperChargerOptions`
	buildprop=`awk -F, '{print $2}' /data/V6_SuperCharger/SuperChargerOptions`
	animation=`awk -F, '{print $3}' /data/V6_SuperCharger/SuperChargerOptions`
	initrc=`awk -F, '{print $4}' /data/V6_SuperCharger/SuperChargerOptions`
	launcheradj=`awk -F, '{print $5}' /data/V6_SuperCharger/SuperChargerOptions`
	if [ -f "/data/99SuperCharger.sh" ]; then panicmode=`awk '/^panicmode=/{gsub(/[^0-9]/,"");print}' /data/99SuperCharger.sh`
	else panicmode=`awk -F, '{print $6}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/99SuperCharger.sh" ]; then pyness=`awk '/^pyness=/{gsub(/[^0-9]/,"");print}' /data/99SuperCharger.sh`
	else pyness=`awk -F, '{print $7}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/99SuperCharger.sh" ]; then deduper=`awk '/^deduper=/{gsub(/[^0-9]/,"");print}' /data/99SuperCharger.sh`
	else deduper=`awk -F, '{print $8}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	propaccessories=`awk -F, '{print $9}' /data/V6_SuperCharger/SuperChargerOptions`
	if [ -f "/data/99SuperCharger.sh" ]; then tc3g=`awk '/^TCE=/{gsub(/[^0-9]/,"");print}' /data/99SuperCharger.sh`
	else tc3g=`awk -F, '{print $10}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/99SuperCharger.sh" ]; then sdtweak=`awk '/^sdtweak=/{gsub(/[^0-9]/,"");print}' /data/99SuperCharger.sh`
	else sdtweak=`awk -F, '{print $11}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/97BulletProof_Apps.sh" ]; then bpwait=`awk '/^bpwait=/{gsub(/[^0-9]/,"");print}' /data/97BulletProof_Apps.sh`
	else bpwait=`awk -F, '{print $12}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/V6_SuperCharger/!FastEngineFlush.sh" ]; then flushOmaticHours=`awk '/^flushOmaticHours=/{gsub(/[^0-9]/,"");print}' /data/V6_SuperCharger/!FastEngineFlush.sh`
	else flushOmaticHours=`awk -F, '{print $13}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/V6_SuperCharger/!Detailing.sh" ]; then detailinterval=`awk '/^detailinterval=/{gsub(/[^0-9]/,"");print}' /data/V6_SuperCharger/!Detailing.sh`
	else detailinterval=`awk -F, '{print $14}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/V6_SuperCharger/!WheelAlignment.sh" ]; then zepalign=`awk '/^bootzepalign=/{gsub(/[^0-9]/,"");print}' /data/V6_SuperCharger/!WheelAlignment.sh`
	else zepalign=`awk -F, '{print $15}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/V6_SuperCharger/!FixEmissions.sh" ]; then fixemissions=`awk '/^bootfixemissions=/{gsub(/[^0-9]/,"");print}' /data/V6_SuperCharger/!FixEmissions.sh`
	else fixemissions=`awk -F, '{print $16}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	if [ -f "/data/V6_SuperCharger/!FixAlignment.sh" ]; then fixalign=`awk '/^bootfixalign=/{gsub(/[^0-9]/,"");print}' /data/V6_SuperCharger/!FixAlignment.sh`
	else fixalign=`awk -F, '{print $17}' /data/V6_SuperCharger/SuperChargerOptions`
	fi
	music=`awk -F, '{print $18}' /data/V6_SuperCharger/SuperChargerOptions`
	if [ ! "`awk -F, '{print $18}' /data/V6_SuperCharger/SuperChargerOptions`" ]; then missingoptions=yes; animation=1; music=1; fi
	sleep="sleep $speed"
	if [ "$buildprop" -eq 1 ]; then prop="/system/build.prop"
	else prop="/data/local.prop"
	fi
	default_options_check
	if [ "$panicmode" -eq 3 ]; then kpanic=0; kpoops=0
	elif [ "$panicmode" -eq 2 ]; then kpanic=30; kpoops=0
	else kpanic=30; kpoops=1
	fi
}
default_options_check(){
	if [ ! "$sleep" ]; then sleep="sleep 2"; fi
	if [ ! "$launcheradj" ]; then launcheradj=1; fi
	if [ ! "$panicmode" ]; then panicmode=1; kpanic=30; kpoops=1; fi
	if [ ! "$pyness" ]; then pyness=1; fi
	if [ ! "$deduper" ] && [ "$ksmdir" ]; then deduper=1
	elif [ ! "$deduper" ]; then deduper=0
	fi
	if [ ! "$propaccessories" ]; then propaccessories=0; fi
	if [ ! "$tc3g" ]; then tc3g=0; fi
	if [ ! "$sdtweak" ] || [ "`echo $sdtweak | awk '/[^0-9]/ || $1>0 && $1<64'`" ]; then sdtweak=$(((ram/64+1)*128)); fi
	if [ ! "$bpwait" ] || [ "`echo $bpwait | grep "[^0-9]"`" ]; then bpwait=30; fi
	if [ ! "$flushOmaticHours" ] || [ "`echo $flushOmaticHours | awk '/[^\.0-9]/ || $1>24'`" ]; then flushOmaticHours=0
	else flushOmaticHours=`echo $flushOmaticHours | awk '{print $1*1}'`
	fi
	if [ ! "$detailinterval" ] || [ "`echo $detailinterval | awk '/[^0-9]/ || $1>9'`" ]; then detailinterval=3; fi
	if [ ! "$zepalign" ]; then zepalign=0; fi
	if [ ! "$fixemissions" ]; then fixemissions=0; fi
	if [ ! "$fixalign" ]; then fixalign=0; fi
}
if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then load_options
else firstgear=yes; autoshowcalculated=yes; default_options_check
fi 2>/dev/null
if [ ! "$music" ] || [ "$music" -eq 1 ]; then
	if [ ! -f "$storage/Download/For_Your_Lag" ]; then
		mkdir $storage/Download 2>/dev/null
		echo $line
		echo " wGetting a suprise for you... heh..."
		echo $line
		echo ""
		wget -qO $storage/Download/For_Your_Lag http://goo.gl/Mdz7vW
	fi 2>/dev/null
fi
echo $line
echo "               It's... SHOWTIME!!"
echo $line
echo ""
sleep 2
if [ ! "$music" ] || [ "$music" -eq 1 ]; then
	if [ -f "$storage/Download/For_Your_Lag" ]; then
		if [ "`busybox find /system -iname stagefright`" ]; then stagefright -ao $storage/Download/For_Your_Lag &
		else
			LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -d file://$storage/Download/For_Your_Lag -t audio/mpeg
			echo ""
			echo $line
			echo ""
			sleep 2
		fi
	fi
fi
if [ ! "$animation" ] || [ "$animation" -eq 1 ]; then
	clear;$animspeed;echo $line;echo "";echo "";echo "";echo "";echo "";echo ""; echo "";echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "";echo "";echo "";echo "";echo "";echo ""; echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo $line;echo "";echo "";echo "";echo "";echo ""; echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "";echo $line;echo "";echo "";echo "";echo ""; echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    |/   #####";echo "";echo $line;echo "";echo "";echo ""; echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    ||   //  #    #" ;echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";echo "";$animspeed
	clear;echo "";echo $line;echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;echo "";$animspeed
	clear;echo "";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo " zoom...";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #  Presented";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo " zoOM... zoOM...";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #  Presented by:";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo " zOOM... zOOM...";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #  Presented by:";echo "    |/   #####                 -=zeppelinrox=-";echo "";echo $line;sleep 1
	echo " NOTE: BUSYBOX v1.16.2 OR HIGHER IS RECOMMENDED!"
	echo $line
	echo ""
	sleep 2
fi
if [ "$smrun" ]; then echo "   Touch the screen to bring up soft keyboard"
else echo " Try Script Manager... it's easier!"
fi
echo ""
echo $line
echo ""
$sleep
echo " Additional BusyBox Info:"
echo ""
$sleep
echo " $bbversion"
echo " `busybox | awk -F \( 'NR==1{print "("$2}'`"
echo ""
$sleep
if [ "$bbversion" \> "BusyBox v1.16.1" ] && [ "$bbversion" \< "BusyBox v1.18.3" ] || [ "$bbversion" \> "BusyBox v1.18.9" ]; then echo "           ...which is fine - if it's COMPLETE!"; echo ""
else
	echo $line
	echo -n " WARNING!  Your BusyBox is "
	if [ "$bbversion" \> "BusyBox v1.18.2" ] && [ "$bbversion" \< "BusyBox v1.19.0" ]; then
		echo "greater than v1.18.2"
		echo ""
		sleep 2
		echo "                      ...and less that v1.19.0!"
		echo $line
		echo ""
		sleep 2
		echo " These versions can cause problems..."
	else
		echo "less than v1.16.2"
		echo $line
		echo ""
		sleep 2
		echo " Some commands may not even work..."
	fi
	echo ""
	sleep 2
	echo " ..and you may have issues such as bootloops..."
	echo ""
	sleep 2
	echo "                  ...proceed at your own risk!!"
	echo ""
	sleep 2
	echo " Get BusyBox from the V6 SuperCharger Thread!"
	echo ""
	load_page qM6yR
fi
echo $line
terms(){
	cat >> "$1" <<EOF
ver=$ver
#
# When using scripting tricks, ideas, or code snippets from here, GIVE PROPER CREDIT.
# There are many things may look simple, but actually took a lot of time, trial, and error to get perfected.
# So DO NOT remove credits, put your name on top, and pretend it's your creation.
# That's called kanging and makes you a dumbass.
#
# This script can be used freely and can even be modified for PERSONAL USE ONLY.
# It can be freely incorporated into ROMs - provided that proper credit is given WITH a link back to the XDA SuperCharger thread.
# If you want to share it or make a thread about it, just provide a link to the main thread.
#      - This ensures that users will always be getting the latest versions.
# Prohibited: Any modification (excluding personal use), repackaging, redistribution, or mirrors of my work are NOT PERMITTED.
# Thanks, zeppelinrox.
#
EOF
}
script_version_check(){
	for regen in /data/99SuperCharger.sh /data/97BulletProof_Apps.sh /data/V6_SuperCharger/*\.sh /data/V6_SuperCharger/BulletProof_One_Shots/* /data/V6_SuperCharger/PowerShift_Scripts/*; do
		if [ -f "$regen" ]; then
			if [ ! "$1" ] && [ ! "$didtitle" ] && [ ! "`grep $ver "$regen"`" ]; then
				if [ -d "/sqlite_stmt_journals" ]; then madesqlitefolder=0
				else mkdir /sqlite_stmt_journals; madesqlitefolder=1
				fi
				echo ""
				$sleep
				echo " Doh... I found outdated script thingies..."
				echo ""
				$sleep
				echo "                      ...so going to run the..."
				echo ""
				$sleep
				echo $line
				echo "    \\\\\\\\ Super Smart Script Re-Generator ////"
				echo "     ======================================="
				echo ""
				$sleep
				didtitle=yes
			fi
			if [ "$1" ] || [ ! "`grep $ver "$regen"`" ]; then
				if [ "`echo "$regen" | grep "1Shot"`" ]; then
					if [ ! "$did1shottitle" ]; then
						echo $line
						echo " Re-Generating BulletProof One-Shot Scripts!"
						echo $line
						did1shottitle=yes
					fi
					echo " Re-Generating `basename "$regen"`..."
					Re_Generate_BulletProof_1Shot "`echo "$regen" | sed 's/.*-\|\.sh$//g'`"
				elif [ "`echo "$regen" | grep "PowerShift"`" ]; then
					if [ ! "$didshifttitle" ]; then
						echo $line
						echo " Re-Generating PowerShift Scripts!"
						echo $line
						didshifttitle=yes
					fi
					echo " Re-Generating `basename "$regen"`..."
					Re_Generate_PowerShift_Script "`basename "$regen"`"
				else
					echo " Re-Generating `basename "$regen"`..."
					Re_Generate_"`echo "$regen" | sed 's/.*\/\|!\|\.sh$//g'`" echo
				fi
				$sleep
			fi
		fi
	done
	if [ "$1" ] || [ "$didtitle" ]; then
		echo ""
		echo $line
		if [ "$checkedspace" ]; then
			echo " WARNING: There were ERRORS copying to /system!"
			echo $line
			echo ""
			$sleep
			echo " Got enough free space?"
			echo ""
			$sleep
			echo $line
			echo " System Partition has `busybox df -m | awk '/ \/system/{print $(NF-2),"MB Free ("$(NF-1)" Used)"}'`"
		else echo " Hey that was easy! (well... for YOU it was :P )"
		fi
		if [ "$didtitle" ]; then
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
			echo ""
			echo $line
			if [ "$madesqlitefolder" -eq 1 ]; then rm -fr /sqlite_stmt_journals; fi
		fi
	fi
	didtitle=; did1shottitle=; didshifttitle=; checkedspace=
}
get_oomadj_info(){
	currentminfree=`cat $minfreefile`
	ram2=`$low$memory "$0" | awk '{print $1}'`
	if [ -f "/data/V6_SuperCharger/SuperChargerAdj" ]; then scadj=`cat /data/V6_SuperCharger/SuperChargerAdj`; fi
	if [ -f "/data/V6_SuperCharger/SuperChargerMinfree" ]; then scminfree=`cat /data/V6_SuperCharger/SuperChargerMinfree`; fi
	if [ -f "/data/V6_SuperCharger/SuperChargerCustomMinfree" ]; then sccminfree=`cat /data/V6_SuperCharger/SuperChargerCustomMinfree`; fi
	if [ -f "/data/V6_SuperCharger/BulletProof_Apps_HitList" ]; then bpapplist=`cat /data/V6_SuperCharger/BulletProof_Apps_HitList`; fi
	if [ -f "/sys/module/lowmemorykiller/parameters/adj" ] && [ "`awk -F, '$2<=1000{print $6}' /sys/module/lowmemorykiller/parameters/adj`" ]; then adjfile="/sys/module/lowmemorykiller/parameters/adj"
	elif [ -f "/data/V6_SuperCharger/SuperChargerAdj" ]; then adjfile="/data/V6_SuperCharger/SuperChargerAdj"
	fi
	if [ ! "$adjfile" ]; then oomadj1=0;oomadj2=1;oomadj3=2;oomadj4=4;oomadj5=9;oomadj6=15;currentadj="0,1,2,4,9,15"
	elif [ "`awk -F, '$2>15' $adjfile`" ]; then
		oomadj1=`awk -F, '{printf "%.0f\n", $1*17/1000}' $adjfile`;oomadj2=`awk -F, '{printf "%.0f\n", $2*17/1000}' $adjfile`;oomadj3=`awk -F, '{printf "%.0f\n", $3*17/1000}' $adjfile`;oomadj4=`awk -F, '{printf "%.0f\n", $4*17/1000}' $adjfile`;oomadj5=`awk -F, '{printf "%.0f\n", $5*17/1000}' $adjfile`;oomadj6=15
		currentadj="$oomadj1,$oomadj2,$oomadj3,$oomadj4,$oomadj5,$oomadj6"
		newscadj2="0,176,352,588,705,1000"
	else
		oomadj1=`awk -F, '{print $1}' $adjfile`;oomadj2=`awk -F, '{print $2}' $adjfile`;oomadj3=`awk -F, '{print $3}' $adjfile`;oomadj4=`awk -F, '{print $4}' $adjfile`;oomadj5=`awk -F, '{print $5}' $adjfile`;oomadj6=`awk -F, '{print $6}' $adjfile`
		currentadj=`cat $adjfile`
	fi
}
get_launcher_status(){
	if [ ! "$lname" ]; then
		launcherloader=; llist=
		for i in `busybox ps | awk '!/]/{print $1}'`; do
			if [ -f "/proc/$i/$oom_adj" ] && [ "`awk '/launcher-loader/' /proc/$i/task/*/comm 2>/dev/null`" ]; then
					launcherloader="$launcherloader `cat /proc/$i/cmdline`"
			fi
		done
		for launchers in $launcherloader `awk -F [\"\/] '/set.*\/*.Launcher/{print $2}' /d*/system/packages.xml` `awk -F \" '/package name/&&/adwfreak|zeam|tw3|tw4|tw5|nextgen|shell|home|trebuchet|lemon.flower|launcher/{print $2}' /d*/system/packages.xml` adwfreak zeam tw3 tw4 tw5 nextgen shell home trebuchet lemon.flower launcher acore; do
			validlauncher=`pgrep -l $launchers | awk '!/\/|notification|gowidget|downloadservice/{print $2}'`
			if [ "$validlauncher" ] && [ ! "`echo $llist | grep $validlauncher`" ]; then llist="$llist $validlauncher"; fi
		done
		for l in $llist; do
		  for lpid in `pgrep $l`; do loom_adj=`cat /proc/$lpid/$oom_adj 2>/dev/null`
			if [ "$loom_adj" -le -1000 ]; then loom_adj=-17
			elif [ "$loom_adj" -ge 1000 ]; then loom_adj=15
			elif [ "${loom_adj#-}" -gt 20 ]; then loom_adj=`echo $loom_adj | awk '{printf "%.0f\n", $1*17/1000}'`
			fi
			if [ "$l" = "android.process.acore" ] && [ "$loom_adj" -lt 0 ]; then continue
			elif [ ! "$HL" ] || [ "$HL" -gt "$loom_adj" ]; then
				if [ "$lname" ] && [ "$lname" != "android.process.acore" ] && [ "$l" = "android.process.acore" ] && [ "$1" ]; then
					echo ""
					$sleep
					echo " Erm... Is $lname the launcher?"
					echo ""
					$sleep
					echo -n " Enter N for No, any key for Yes: "
					read islauncher
					echo ""
					echo $line
					case $islauncher in
					  n|N);;
						*)continue;;
					esac
				fi
				HL=$loom_adj
				lname=$l
				if [ "$preics" ] && [ "$HL" -eq "$homeadj" ] && [ "$HL" -lt "$VA" ] && [ "$HL" -eq "$((FA+1))" ]; then diehard=yes; break; fi
			fi
		  done
		done
	fi
	if [ "$postics" ]; then
		adjs1=0; adjs3=0; adjs5=0; adjs6=0; adjs7=0
		if [ -f "/system/framework/services.odex" ]; then odex=yes; fi
		for i in `busybox ps | awk '!/]/{print $1}'`; do
			if [ -f "/proc/$i/$oom_adj" ]; then
				adj=`cat /proc/$i/$oom_adj 2>/dev/null`
				if [ "$adj" -le -1000 ]; then adj=-17
				elif [ "$adj" -ge 1000 ]; then adj=15
				elif [ "${adj#-}" -gt 20 ]; then adj=`echo $adj | awk '{printf "%.0f\n", $1*17/1000}'`
				fi
				if [ "$adj" -eq 1 ]; then adjs1=$((adjs1+1)); fi
				if [ "$adj" -eq 3 ]; then adjs3=$((adjs3+1)); fi
				if [ "$adj" -eq 5 ]; then adjs5=$((adjs5+1)); fi
				if [ "$adj" -eq 6 ]; then adjs6=$((adjs6+1)); fi
				if [ "$adj" -eq 7 ]; then adjs7=$((adjs7+1)); fi
			fi
		done
		if [ ! "$HL" ]; then HL=6; fi
		if [ "$HL" -eq 1 ] && [ "$adjs1" -eq 1 ] || [ "$adjs3" -gt 0 ]; then servicesjarpatched=hellzyeah; VA=3
		elif [ "$HL" -eq 0 ] || [ "$HL" -eq 2 ] && [ "$adjs1" -eq 0 ]; then servicesjarpatched=hellzyeah; VA=3
		else VA=1
			if [ "$odex" ] || [ "$jb" -eq 1 ] && [ "$adjs1" -gt 1 ]; then showparlor=yes
			elif [ "$HL" -gt 2 ]; then
				if [ "$adjs5" -gt 1 ] && [ "$adjs6" -gt 1 ]; then showparlor=yes
				elif [ "$adjs7" -gt 0 ] || [ "$adjs5" -gt 0 ] && [ "$adjs6" -eq 1 ]; then showparlor=yes
				elif [ "$adjs7" -gt 0 ] || [ "$adjs6" -gt 0 ] && [ "$adjs5" -eq 1 ]; then showparlor=yes
				else servicesjarpatched=hellzyeah; usedwebapp=yes
				fi
			elif [ "$HL" -eq 1 ]; then servicesjarpatched=hellzyeah; usedwebapp=yes
			elif [ "$adjs7" -gt 0 ] || [ "$adjs5" -gt 0 ] && [ "$adjs6" -eq 0 ]; then showparlor=yes
			elif [ "$adjs7" -gt 0 ] || [ "$adjs6" -gt 0 ] && [ "$adjs5" -eq 0 ]; then showparlor=yes
			else servicesjarpatched=hellzyeah; usedwebapp=yes
			fi
			if [ -f "$storage/ultimatic.tmp" ]; then showparlor=; rm -f $storage/ultimatic.tmp; fi
		fi
	fi
}
get_ram_info(){
	ramfree=$((`awk '/^MemFree/{print $2}' /proc/meminfo`/1024))
	ramcached=$((`awk '/^Cached/{print $2}' /proc/meminfo`/1024))
	rambuffers=$((`awk '/^Buffers/{print $2}' /proc/meminfo`/1024))
	rambufferscached=$((ramcached+rambuffers))
	ramreportedfree=$((ramfree+ramcached+rambuffers))
	echo $line
	echo "True Free $ramfree MB = Free $ramreportedfree - Buffers/Cached $rambufferscached"
	echo $line
}
MFK_Calculator(){
	#
	# MFK Calculator (for min_free_kbytes) created by zeppelinrox.
	#
	if [ "$slot" ] && [ "$postics" ] && [ ! "$servicesjarpatched" ]; then SSADJ=5
	elif [ "$slot" ]; then SSADJ=$adj3
	fi
	if [ "$slot" ] && [ "$SL3" -gt 0 ]; then SSMF=$SL3
	elif [ "$scminfree" ]; then SSMF=`echo $scminfree | awk -F, '{print $3}'`
	else SSMF=`awk -F, '{print $3}' $minfreefile`
	fi
	MFK=$((SSMF*4/5))
}
info_free_space_error(){
	echo $line
	echo " WARNING: Copy ERROR to $1/$2!"
	echo $line
	if [ ! "$3" ]; then
		echo ""
		$sleep
		echo " Got enough free space?"
		echo ""
		$sleep
		echo " System Partition has `busybox df -m | awk '/ \/system/{print $(NF-2),"MB Free ("$(NF-1)" Used)"}'`"
	fi
}
info_ADJs_no_worky(){
	echo " This CAN'T SuperCharge ADJs on POST-ICS ROMS!"
	echo ""
	$sleep
	echo " It can only apply adj/Grouping Fixes..."
	echo ""
	$sleep
	echo "                           ...and other tweaks!"
	echo ""
	$sleep
	echo $line
}
info_missing_binary(){
	echo " Doh... $1 binary was NOT found..."
	echo ""
	$sleep
	echo $line
	echo "                    ...No $2 For You!!"
	echo $line
	echo ""
	$sleep
	echo " Load the XDA SuperCharger thread..."
	echo ""
	$sleep
	echo "   ...and install The SuperCharger Starter Kit!"
	echo ""
	$sleep
	echo -n " Press The Enter Key... "
	read enter
	echo ""
	load_page qM6yR
}
info_build_prop(){
	echo ""
	$sleep
	echo " You can apply MEM and ADJ values..."
	echo ""
	$sleep
	echo "        ...to build.prop instead of local.prop!"
	echo ""
	$sleep
	echo " This is more likely to stick but is riskier..."
	echo ""
	$sleep
	echo $line
	echo " WARNING: There is a small chance of bootloops!"
	echo ""
	$sleep
	echo "                 ...so have a backup available!"
	echo $line
	echo ""
	$sleep
}
info_launcher_warning(){
	echo "     ======================================="
	echo "      \\\\\\ BULLETPROOF LAUNCHER WARNING! ///"
	echo "       ==================================="
	echo ""
	$sleep
	echo $line
	echo "    This Breaks \"Long-Press Back To Kill\"!"
	echo $line
	echo ""
	$sleep
	echo " If you don't have or don't use this feature..."
	echo ""
	$sleep
	echo "                 ...or don't know what it is..."
	echo ""
	$sleep
	echo "                     ...don't worry about it ;)"
	echo ""
	$sleep
	echo $line
	echo " Note 1: This is NOT for Gamers! (Less Free RAM)"
	echo $line
	$sleep
	echo " Note 2: It also does not play nice with Tasker!"
}
info_bb_no_nohup(){
	echo " Oh wait... you don't have either busybox..."
	echo ""
	$sleep
	echo "     ...\"nohup\" or \"start-stop-daemon\" applets!"
	echo ""
	$sleep
	echo " If I run it for you right now..."
	echo ""
	$sleep
	echo "       ...you can't be returned to this script!"
	echo ""
	$sleep
	echo " So just do it yourself... haha... oh and..."
	echo ""
	$sleep
	echo $line
	echo "   Install a BusyBox build with MORE features!"
	echo $line
	echo ""
	$sleep
}
Apply_KVM_Tweaks(){
	echo -n "           ";busybox sysctl -w vm.oom_kill_allocating_task=0
	echo -n "                       ";busybox sysctl -w vm.panic_on_oom=0
	echo -n "                 ";busybox sysctl -w vm.vfs_cache_pressure=10
	echo -n "                  ";busybox sysctl -w vm.overcommit_memory=1
	echo -n "                         ";busybox sysctl -w vm.swappiness=20
	if [ "$panicmode" -gt 0 ]; then
		echo -n "                  ";busybox sysctl -w kernel.panic_on_oops=$kpoops
		echo -n "                          ";busybox sysctl -w kernel.panic=$kpanic
	fi
	if [ "$pyness" -ne 0 ]; then
		echo -n "  ";busybox sysctl -w kernel.random.write_wakeup_threshold=128
		echo -n "   ";busybox sysctl -w kernel.random.read_wakeup_threshold=1376
		echo ""
		$sleep
		echo $line
		echo " Note: Last one's the -=Entropy-ness Enlarger=-!"
		echo $line
	fi
	if [ "$deduper" -ne 0 ] && [ "$ksmdir" ]; then
		echo ""
		$sleep
		echo $line
		echo " Applying the -=Super Duper DeDuper=-...!"
		echo $line
		echo ""
		$sleep
		echo 1 > /sys/kernel/mm/$ksmdir/run
		echo "               " /sys/kernel/mm/$ksmdir/run "= 1"
		if [ -f "/sys/kernel/mm/$ksmdir/cpu_governor" ]; then
			echo 240 > /sys/kernel/mm/$ksmdir/sleep_millisecs
			echo "   " /sys/kernel/mm/$ksmdir/sleep_millisecs "= 240"
		else
			echo 6000 > /sys/kernel/mm/$ksmdir/sleep_millisecs
			echo "   " /sys/kernel/mm/$ksmdir/sleep_millisecs "= 6000"
		fi
		if [ -f "/sys/kernel/mm/$ksmdir/pages_to_scan" ]; then
			echo 1536 > /sys/kernel/mm/$ksmdir/pages_to_scan
			echo "     " /sys/kernel/mm/$ksmdir/pages_to_scan "= 1536"
		fi
		if [ -f "/sys/kernel/mm/$ksmdir/scan_batch_pages" ]; then
			echo 1536 > /sys/kernel/mm/$ksmdir/scan_batch_pages
			echo "  " /sys/kernel/mm/$ksmdir/scan_batch_pages "= 1536"
		fi
		if [ -f "/sys/kernel/mm/$ksmdir/abundant_threshold" ]; then
			echo 0 > /sys/kernel/mm/$ksmdir/abundant_threshold
			echo "" /sys/kernel/mm/$ksmdir/abundant_threshold "= 0"
		fi
		if [ -f "/sys/kernel/mm/$ksmdir/cpu_governor" ]; then
			echo full > /sys/kernel/mm/$ksmdir/cpu_governor
			echo "      " /sys/kernel/mm/$ksmdir/cpu_governor "= full"
		fi
		if [ -f "/sys/kernel/mm/$ksmdir/max_cpu_percentage" ]; then
			echo 95 > /sys/kernel/mm/$ksmdir/max_cpu_percentage
			echo "" /sys/kernel/mm/$ksmdir/max_cpu_percentage "= 95"
		fi
	fi
	echo ""
	$sleep
	if [ -f "/system/lib/modules/frandom.ko" ] && [ ! "$frandomtype" ]; then insmod /system/lib/modules/frandom.ko; fi
	if [ -e "/dev/frandom" ]; then chmod 666 /dev/frandom; chmod 666 /dev/erandom
		frandomtype=`stat /dev/frandom | awk '/type/{print $NF}'`
		erandomtype=`stat /dev/erandom | awk '/type/{print $NF}'`
		echo $line
		echo "     Applying the -=Fentropy enForcer=-...";
		echo $line
		echo ""
		$sleep
		for dom in /dev/*random; do
			if [ "$dom" != "/dev/frandom" ] && [ "$dom" != "/dev/erandom" ]; then domtype=`stat $dom | awk '/type/{print $NF}'`
				if [ "$domtype" != "$frandomtype" ] && [ "$domtype" != "$erandomtype" ]; then
					mv $dom $dom.unsuper
					if [ "$dom" = "/dev/random" ]; then ln /dev/frandom $dom
					else ln /dev/erandom $dom
					fi
				fi
			fi
		done
	fi
}
Apply_Accessories(){
	echo " Applying System Property Accessory Tweaks..."
	echo ""
	$sleep
	echo "  ...based on the $ram MB of RAM on your device!"
	echo ""
	$sleep
	if [ "`getprop | grep heapgrowthlimit`" ]; then
		setprop dalvik.vm.heapgrowthlimit $heapgrowthlimit"m"
		echo "        dalvik.vm.heapgrowthlimit = $heapgrowthlimit MB"
	fi
	setprop dalvik.vm.heapsize $heapsize"m"
	echo "               dalvik.vm.heapsize = $heapsize MB"
	if [ "`getprop | grep persist.sys.vm.heapsize`" ]; then
		setprop persist.sys.vm.heapsize $heapsize"m"
		echo "          persist.sys.vm.heapsize = $heapsize MB"
	fi
	setprop persist.sys.purgeable_assets 1
	echo "     persist.sys.purgeable_assets = 1"
	setprop wifi.supplicant_scan_interval 180
	echo "    wifi.supplicant_scan_interval = 180"
	setprop windowsmgr.max_events_per_sec 90
	echo "    windowsmgr.max_events_per_sec = 90"
	echo ""
}
Apply_3G_TCE(){
	echo " Applying 3G TurboCharger Enhancement..."
	echo ""
	$sleep
	setprop net.dns1 8.8.8.8
	setprop net.dns2 8.8.4.4
	setprop net.tcp.buffersize.default 6144,87380,110208,6144,16384,110208
	setprop net.tcp.buffersize.wifi 262144,524288,1048576,262144,524288,1048576
	setprop net.tcp.buffersize.lte 262144,524288,3145728,262144,524288,3145728
	setprop net.tcp.buffersize.hsdpa 6144,262144,1048576,6144,262144,1048576
	setprop net.tcp.buffersize.evdo_b 6144,262144,1048576,6144,262144,1048576
	setprop net.tcp.buffersize.umts 6144,87380,110208,6144,16384,110208
	setprop net.tcp.buffersize.hspa 6144,87380,262144,6144,16384,262144
	setprop net.tcp.buffersize.gprs 6144,8760,11680,6144,8760,11680
	setprop net.tcp.buffersize.edge 6144,26280,35040,6144,16384,35040
	echo -n "            ";busybox sysctl -w net.core.wmem_max=1048576
	echo -n "            ";busybox sysctl -w net.core.rmem_max=1048576
	echo -n "          ";busybox sysctl -w net.core.optmem_max=20480
	echo -n " ";busybox sysctl -w net.ipv4.tcp_moderate_rcvbuf=1
	echo -n "         ";busybox sysctl -w net.ipv4.route.flush=1
	echo -n "        ";busybox sysctl -w net.ipv4.udp_rmem_min=6144
	echo -n "        ";busybox sysctl -w net.ipv4.udp_wmem_min=6144
	echo -n "       ";busybox sysctl -w net.ipv4.tcp_rmem='6144 87380 1048576'
	echo -n "       ";busybox sysctl -w net.ipv4.tcp_wmem='6144 87380 1048576'
	echo ""
}
Apply_SD_Speed(){
	echo " Applying SD Read Speed Tweak..."
	echo ""
	$sleep
	echo "  ...based on the $ram MB of RAM on your device!"
	echo ""
	$sleep
	if [ "`ls /sys/devices/virtual/bdi/179*/read_ahead_kb`" ]; then read_ahead=yes
		for i in /sys/devices/virtual/bdi/179*/read_ahead_kb; do echo $sdtweak > $i; done
	fi 2>/dev/null
	if [ -f "/sys/block/mmcblk0/bdi/read_ahead_kb" ]; then read_ahead=yes
		echo $sdtweak > /sys/block/mmcblk0/bdi/read_ahead_kb
	fi
	if [ -f "/sys/block/mmcblk0/queue/read_ahead_kb" ]; then read_ahead=yes
		echo $sdtweak > /sys/block/mmcblk0/queue/read_ahead_kb
	fi
	if [ "$read_ahead" ]; then echo "              SD Read Speed Tweak = $sdtweak KB"
	else
		echo $line
		echo "     Sorry! Can't Apply SD Read Speed Tweak!"
		echo $line
	fi
	echo ""
}
backup_system_stuff(){
	for p in /data/local.prop /system/build.prop /system/bin/build.prop /system/etc/ram.conf; do
		if [ -f "$p" ]; then chown 0.0 $p; chmod 644 $p
			backup_prop $p
			echo ""
			$sleep
		fi
	done 2>/dev/null
	echo $line
	if [ -f "$initrcpath1" ] && [ ! -f "$initrcpath" ]; then cp -r $initrcpath1 $initrcpath; fi
	for rc in $initrcpath1 $allrcpaths /system/etc/hw_config.sh; do
		if [ -f "$rc" ] && [ "$rc" = "$initrcpath1" ] && [ ! -f "$initrcbackup" ]; then backedup=yes
			echo ""
			backup_rc $rc $initrcbackup
			$sleep
		elif [ -f "$rc" ] && [ "$rc" != "$initrcpath1" ] && [ ! -f "$rc.unsuper" ]; then backedup=yes
			echo ""
			backup_rc $rc $rc.unsuper
			$sleep
		fi
	done 2>/dev/null
	if [ "$backedup" ]; then echo ""; echo $line; fi
}
backup_prop(){
	if [ -f "$1.unsuper" ]; then echo " Leaving ORIGINAL ${1##*/} backup intact..."
	else
		echo " Backing up ORIGINAL ${1##*/}..."
		echo ""
		$sleep
		cp -r $1 $1.unsuper
		if [ ! "`diff $1 $1.unsuper`" ]; then
			sed -i '/SuperCharger Installation/d' $1.unsuper
			echo "          ...as $1.unsuper!"
		else echo " ERROR BACKING UP $1!"
		fi
	fi
}
backup_rc(){
	echo " Backing up ORIGINAL $1..."
	cp -r $1 $2
	if [ ! -f "$2" ] || [ "`diff $1 $2`" ]; then
		echo ""
		$sleep
		echo " ERROR BACKING UP $1!"
	fi
}
integrate_initrc(){
	sed -i '/busybox mount.*data/ i\
if [ -f "'$initrcpath'" ] && [ "\`grep "SuperCharger" /system/build.prop\`" ] && [ "\`diff '$initrcpath' '$initrcpath1'\`" ]; then\
	mount -o remount,rw / 2>/dev/null;\
	mount -o remount,rw rootfs 2>/dev/null;\
	busybox mount -o remount,rw / 2>/dev/null;\
	busybox mount -o remount,rw rootfs 2>/dev/null;\
	cp -fr '$initrcpath' '$initrcpath1';\
	mount -o remount,ro / 2>/dev/null;\
	mount -o remount,ro rootfs 2>/dev/null;\
	busybox mount -o remount,ro / 2>/dev/null;\
	busybox mount -o remount,ro rootfs 2>/dev/null;\
fi 2>/dev/null; # System Integration Marker' $1
}
install_sc_service(){
	for scs in $initrcpath $allrcpaths; do
		cat >> $scs <<EOF
# SuperCharger_Service created by -=zeppelinrox=-
#
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!
#
  ################################
 #  SuperCharger Service Notes  #
################################
# To restart the SuperCharger Service so it stays running, run Terminal Emulator and type...
# "su" and Enter.
# "start super_service" and Enter.
#
# To stop the SuperCharger Service, type...
# "su" and Enter.
# "stop super_service" and Enter.
#
# If the service is running and you type: "grep -h [S]uper /proc/*/cmdline".
# The output would be "/data/99SuperCharger.sh".
#
# Similar results can be had with: "busybox ps | grep [S]uper".
#
service super_service /system/bin/sh /data/99SuperCharger.sh
    class post-zygote_services
    user root
    group root
#
# End of SuperCharged_Service Entries.
EOF
		if [ "$scs" != "$initrcpath" ] && [ ! "$scsinfo" ]; then echo "   ...$scs!"; fi
		if [ ! "$scservice" ]; then $sleep; fi
	done
}
install_bp_service(){
	if [ "$1" ]; then
		echo " Installing BulletProof Apps Service to..."
		echo $line
		echo ""
		$sleep
	fi
	for bps in $initrcpath $allrcpaths; do
		sed -i '/BulletProof_Apps_Service/,/BulletProofed_Apps_Service/d' $bps
		cat >> $bps <<EOF
# BulletProof_Apps_Service created by -=zeppelinrox=-
#
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!
#
  ####################################
 #  BulletProof Apps Service Notes  #
####################################
# To stop the BulletProof Apps Service, run Terminal Emulator and type...
# "su" and Enter.
# "stop bullet_service" and Enter.
#
# To restart the BulletProof Apps Service, type...
# "su" and Enter.
# "start bullet_service" and Enter.
#
# If the service is running and you type: "grep -h [B]ullet /proc/*/cmdline".
# The output would be 2 items:
#     a. "/data/97BulletProof_Apps.sh"
#     b. "BulletProof Apps is In Effect!" (sleep message)
#
# Similar results can be had with: "busybox ps | grep [B]ullet".
#
service bullet_service /system/bin/sh /data/97BulletProof_Apps.sh
    class post-zygote_services
    user root
    group root
#
# End of BulletProofed_Apps_Service Entries.
EOF
		mkdir $storage/V6_SuperCharger`dirname $bps` 2>/dev/null
		cp -fr $bps $storage/V6_SuperCharger`dirname $bps`
		if [ "$bps" != "$initrcpath" ] && [ "$1" ]; then echo "   ...$bps!"; $sleep; fi
	done
}
blurb_was_created(){
	echo "$1"
	echo ""
	$sleep
	echo "$2"
	echo ""
	$sleep
	echo "                                ...was created!"
	echo ""
}
blurb_Quick_Widget(){
	$sleep
	echo " With Script Manager..."
	echo ""
	$sleep
	echo "       ...you can make a \"Quick Widget\" for it."
	echo ""
}
blurb_Terminal(){
	echo ""
	$sleep
	echo " To use this script with Terminal Emulator..."
	echo ""
	$sleep
	echo "                    ...Run Terminal Emulator..."
	echo ""
	$sleep
	echo "             ...type \"su\" and Enter..."
	echo "                    =="
	echo ""
	$sleep
	echo " ...type \"$1\" and Enter..."
	echo "          $2"
	echo ""
	$sleep
	echo "                  THAT'S IT!"
}
blurb_boot_script(){
	echo " $1 can run automatically on boot!"
	echo ""
	$sleep
	echo $line
	echo " Just check /data/BootLog_$2.log!"
	echo $line
	echo ""
	$sleep
	echo " The script is VERY sophisticated..."
	echo ""
	$sleep
	echo "           ...so boot time would be unaffected!"
	echo ""
	$sleep
}
blurb_BulletProof_Apps(){
	echo " This attempts to lock apps in memory!"
	echo ""
	$sleep
	echo " Use it only for apps that..."
	echo ""
	$sleep
	echo "      ...you NEED to keep running all the time."
	echo ""
	$sleep
	echo $line
	echo " Kick Ass Bonus Feature: \"Auto-BOOM\"! "
	echo $line
	echo ""
	$sleep
	echo " ie. Auto-BulletProof OOM of current in use app!"
	echo ""
	$sleep
	echo " It will automatically BulletProof the..."
	echo ""
	$sleep
	echo "                   ...oom_adj priority of..."
	echo ""
	$sleep
	echo "         ...whatever app you're actively using!"
	echo ""
	$sleep
	echo " This should make any app you're using snappier!"
	echo ""
	echo $line
	echo ""
	$sleep
}
blurb_Detailing(){
	echo " You have many SQLite databases that become..."
	echo ""
	$sleep
	echo " ...fragmented and unoptimized over a few days."
	echo ""
	$sleep
	echo " This tool will optimize them with..."
	echo ""
	$sleep
	echo "                  ...SQLite VACUUM and REINDEX!"
	echo ""
	echo $line
	echo ""
	$sleep
}
blurb_WheelAlignment(){
	echo " ZipAlign optimizes ALL your APKs..."
	echo ""
	$sleep
	echo "  ...which means less RAM comsumption..."
	echo ""
	$sleep
	echo "                   ...better battery life..."
	echo ""
	$sleep
	echo "                       ...and a faster device!!"
	echo ""
	$sleep
	echo $line
	echo " If you get Force Closes, run Fix Emissions too!"
	echo $line
	echo ""
	$sleep
}
blurb_FixEmissions(){
	echo " This should fix app Force Closes!"
	echo ""
	$sleep
	echo " FCs usually happen due to permission errors..."
	echo ""
	$sleep
	echo " This tool will ensure that ALL apps..."
	echo ""
	$sleep
	echo "               ...have the correct permissions!"
	echo ""
	echo $line
	echo ""
	$sleep
}
blurb_FixAlignment(){
	echo " This combines two scripts into one..."
	echo ""
	$sleep
	echo "          ...Wheel Alignment AND Fix Emissions!"
	echo ""
	$sleep
	echo " ZipAlign optimizes ALL your APKs..."
	echo ""
	$sleep
	echo "  ...which means less RAM comsumption..."
	echo ""
	$sleep
	echo "   ...better battery life and a faster device!!"
	echo ""
	$sleep
	echo " But sometimes... Force Closes can result..."
	echo ""
	$sleep
	echo "  ...so this Fixes Permissions of each app..."
	echo ""
	$sleep
	echo "           ...immediately after zipaligning it!"
	echo ""
	$sleep
	echo " It's REALLY FAST and..."
	echo ""
	$sleep
	echo $line
	echo "      It's the ONLY script of it's kind ;^]"
	echo $line
	echo ""
	$sleep
}
blurb_FastEngineFlush(){
	echo " Your device may get laggy after a day or two.."
	echo ""
	$sleep
	echo "                  ...or merely several hours..."
	echo ""
	$sleep
	echo "                    ...if you haven't rebooted."
	echo ""
	$sleep
	echo " It happens when system caches keep growing..."
	echo ""
	$sleep
	echo "            ...and free RAM keeps shrinking..."
	echo ""
	$sleep
	echo "           ...and apps are starved for memory!"
	echo ""
	$sleep
	echo $line
	echo " This Engine Flush will give you a Quick Boost!"
	echo $line
	echo ""
	$sleep
	echo " The system will drop all file system caches..."
	echo ""
	$sleep
	echo "       ...which means more free RAM and no lag!"
	echo ""
	$sleep
	echo "                        ..so no need to reboot!"
	echo ""
}
blurb_unsupercharge(){
	echo " Out Of Memory (OOM) Groupings UnFixed..."
	echo ""
	$sleep
	echo "                ...OOM Priorities UnFixed..."
	echo ""
	$sleep
	echo "                  Weak Ass Launcher Restored :("
	echo ""
	$sleep
	echo $line
	echo "           UnSuperCharging Complete!"
	echo $line
	echo ""
	$sleep
}
Configure_BulletProof_Apps(){
	echo " Current Status..."
	echo ""
	$sleep
	echo $line
	if [ "$bpwait" -gt 0 ]; then echo " BulletProof Apps is ON @ $bpwait second intervals!"
	else echo " BulletProof Apps is Currently OFF!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change BulletProof Apps Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo ""
		  $sleep
		  echo " You can turn BulletProof Apps on or off..."
		  echo ""
		  $sleep
		  echo "        ...or just change how often it runs ;^]"
		  echo ""
		  $sleep
		  echo $line
		  echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Note that if enabled, the script will exit..."
		  echo ""
		  $sleep
		  echo "   ...if you haven't BulletProofed any apps ;^]"
		  echo ""
		  $sleep
		  if [ -d "/system/etc/init.d" ]; then
			echo " Also note that when it's enabled..."
			echo ""
			$sleep
			echo $line
			echo " BulletProof Apps on boot is AUTOMAGIC!"
			echo $line
			echo ""
			$sleep
			echo " Just check /data/BootLog_BulletProof_Apps.log!"
			echo ""
			$sleep
		  fi
		  echo " Enable BulletProof Apps?"
		  echo " ========================"
		  while :; do
			echo ""
			$sleep
			echo -n " Enter E to Enable, D to Disable: "
			read bullet
			echo ""
			echo $line
			case $bullet in
			  e|E)if [ ! -f "/data/97BulletProof_Apps.sh" ]; then
					echo " BulletProof Apps has to run once from the menu!"
					echo $line
				  fi
				  echo ""
				  $sleep
				  echo " How often do you want to BulletProof Apps?"
				  echo ""
				  $sleep
				  echo " Note that values are in seconds..."
				  echo ""
				  $sleep
				  echo " Too low a value may suck battery faster than..."
				  echo ""
				  $sleep
				  echo "                ...an Armstrong on a steroid...."
				  echo ""
				  $sleep
				  echo "                           ...so don't be a nut!"
				  echo ""
				  $sleep
				  echo " btw 14s is likely the lowest you should go..."
				  echo ""
				  $sleep
				  echo "           ...and nothing gets killed at 14s ;^]"
				  while :; do
					echo ""
					$sleep
					echo -n " Enter any whole number (no decimals) over 0: "
					read bpwait
					echo ""
					echo $line
					if [ "$bpwait" ] && [ "`echo $bpwait | awk '!/[^0-9]/ && $1>0'`" ]; then
						echo " BulletProof Apps Set To Run Every $bpwait seconds!"
						break 2
					fi
					echo "      Invalid entry... Please try again :p"
					echo $line
				  done;;
			  d|D)bpwait=0
				  echo "           BulletProof Apps DISABLED!!"
				  break;;
				*)echo "      Invalid entry... Please try again :p"
				  echo $line;;
			esac
		  done
		  update_options_in_scripts bulletproof
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Configure_Detailing(){
	echo " AND you can specify how often it runs..."
	echo ""
	$sleep
	echo "  ...so if you input 4, it runs every 4th boot!"
	echo ""
	$sleep
	echo $line
	echo -n " Current Status: Detailing "
	if [ "$detailinterval" -eq 0 ]; then echo "DOES NOT Run On Boot!"
	else echo "Runs Every $detailinterval Boots!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change Detailing Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Run Detailing on boot?"
		  echo " ======================"
		  echo ""
		  $sleep
		  echo -n " Enter Y for Yes, any key for No: "
		  read bootdetailing
		  echo ""
		  echo $line
		  case $bootdetailing in
			y|Y)if [ ! -f "/data/V6_SuperCharger/!Detailing.sh" ]; then
					echo " Detailing has to run once from the menu!"
					echo $line
				fi
				while :; do
					echo ""
					$sleep
					echo -n " How often? 1=every boot to 9=every 9th boot: "
					read detailinterval
					echo ""
					echo $line
					case $detailinterval in
					  [1-9])echo "       Detailing Set To Run Every $detailinterval Boots!"
							break;;
						  *)echo "      Invalid entry... Please try again :p"
							echo $line;;
					esac
				done;;
			  *)detailinterval=0
				echo "           Declined Detailing On Boot!";;
		  esac
		  update_options_in_scripts vac
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Configure_WheelAlignment(){
	echo $line
	echo -n " Status: Wheel Alignment "
	if [ "$zepalign" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change Wheel Alignment Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Run Wheel Alignment on boot?"
		  echo " ============================"
		  echo ""
		  $sleep
		  echo " Note: If you say Yes, Fix Alignment On Boot..."
		  echo "      ...gets disabled (avoids overlapping mods)"
		  echo ""
		  $sleep
		  echo -n " Enter Y for Yes, any key for No: "
		  read bootzepalign
		  echo ""
		  echo $line
		  case $bootzepalign in
		    y|Y)zepalign=1; fixalign=0
				if [ ! -f "/data/V6_SuperCharger/!WheelAlignment.sh" ]; then
					echo " Wheel Alignment has to run once from the menu!"
					echo $line
					echo ""
					$sleep
					echo $line
				fi
				echo "       Wheel Alignment Set To Run On Boot!";;
			  *)zepalign=0
				echo "     Boot Align Declined... does that rhyme?";;
		  esac
		  update_options_in_scripts zepalign
		  update_options_in_scripts fixalign
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Configure_FixEmissions(){
	echo $line
	echo -n " Status: Fix Emissions "
	if [ "$fixemissions" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change Fix Emissions Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Run Fix Emissions on boot?"
		  echo " =========================="
		  echo ""
		  $sleep
		  echo " Note: If you say Yes, Fix Alignment On Boot..."
		  echo "      ...gets disabled (avoids overlapping mods)"
		  echo ""
		  $sleep
		  echo -n " Enter Y for Yes, any key for No: "
		  read bootfixemissions
		  echo ""
		  echo $line
		  case $bootfixemissions in
			y|Y)fixemissions=1; fixalign=0
				if [ ! -f "/data/V6_SuperCharger/!FixEmissions.sh" ]; then
					echo " Fix Emissions has to run once from the menu!"
					echo $line
					echo ""
					$sleep
					echo $line
				fi
				echo "        Fix Emissions Set To Run On Boot!";;
			  *)fixemissions=0
				echo "          No FCing Fix On Boot For You!";;
		  esac
		  update_options_in_scripts fixfc
		  update_options_in_scripts fixalign
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Configure_FixAlignment(){
	echo $line
	echo -n " Status: Fix Alignment "
	if [ "$fixalign" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change Fix Alignment Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Run Fix Alignment on boot?"
		  echo " =========================="
		  echo ""
		  $sleep
		  echo " Note 1: If you say Yes..."
		  echo "         Wheel Alignment and Fix Emissions..."
		  echo "         ...On Boot are automatically disabled!"
		  echo ""
		  $sleep
		  echo " Note 2: If you say No..."
		  echo "         Wheel Alignment and Fix Emissions..."
		  echo "              ...boot options become available!"
		  echo ""
		  $sleep
		  echo -n " Enter Y for Yes, any key for No: "
		  read bootfixalign
		  echo ""
		  echo $line
		  case $bootfixalign in
			y|Y)fixalign=1; zepalign=0; fixemissions=0
				if [ ! -f "/data/V6_SuperCharger/!FixAlignment.sh" ]; then
					echo " Fix Alignment has to run once from the menu!"
					echo $line
					echo ""
					$sleep
					echo $line
				fi
				echo "        Fix Alignment Set To Run On Boot!";;
			  *)fixalign=0
				echo "   Boot Fix Align Declined... does that rhyme?";;
		  esac
		  update_options_in_scripts zepalign
		  update_options_in_scripts fixfc
		  update_options_in_scripts fixalign
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Configure_FastEngineFlush(){
	echo " Current Status..."
	echo ""
	$sleep
	echo $line
	if [ "`echo $flushOmaticHours | awk '$1>0'`" ]; then echo " Engine Flush-O-Matic is ON @ $flushOmaticHours hr intervals!"
	else echo " Engine Flush-O-Matic is Currently OFF!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Change Engine Flush-O-Matic Options?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
	  y|Y)echo ""
		  $sleep
		  echo " You can turn Engine Flush-O-Matic on or off..."
		  echo ""
		  $sleep
		  echo "        ...or just change how often it runs ;^]"
		  echo ""
		  $sleep
		  echo $line
		  echo " You can also configure this within the script!"
		  echo $line
		  echo ""
		  $sleep
		  echo " Note that if enabled, caches are dumped..."
		  echo ""
		  $sleep
		  echo "                ...only when the screen is off!"
		  echo ""
		  $sleep
		  echo " This is cuz you don't want your device to..."
		  echo ""
		  $sleep
		  echo " ...take a big dump and flush..."
		  echo ""
		  $sleep
		  echo "        ...when you're taking care of business!"
		  echo ""
		  $sleep
		  if [ -d "/system/etc/init.d" ]; then
			echo " Also note that when it's enabled..."
			echo ""
			$sleep
			echo $line
			echo " -=Engine Flush-O-Matic=- on boot is AUTOMAGIC!"
			echo $line
			echo ""
			$sleep
			echo " If disabled, it will Flush once after boot up!"
			echo ""
			$sleep
			echo " Just check /data/BootLog_FastEngineFlush.log!"
			echo ""
			$sleep
		  fi
		  echo " Enable Engine Flush-O-Matic?"
		  echo " ============================"
		  while :; do
			echo ""
			$sleep
			echo -n " Enter E to Enable, D to Disable: "
			read able
			echo ""
			echo $line
			case $able in
			  e|E)if [ ! -f "/data/V6_SuperCharger/!FastEngineFlush.sh" ]; then
					echo " Engine Flush has to run once from the menu!"
					echo $line
					echo ""
					$sleep
					echo $line
				  fi
				  echo "       -=Engine Flush-O-Matic=- ENABLED!!"
				  echo $line
				  echo ""
				  $sleep
				  echo " Note that you CAN enter a decimal value!"
				  echo ""
				  $sleep
				  echo " ie. \".1\"=6 mins, \".25\"=15 mins, \"2.5\"=2.5 hrs"
				  echo ""
				  $sleep
				  echo " Low values like .1 MAY benefit Gamers... ? :P"
				  echo ""
				  $sleep
				  echo " How often do you want it to flush?"
				  while :; do
					echo ""
					$sleep
					echo -n " Enter a value from 1 to 24 (hours): "
					read flushOmaticHours
					echo ""
					echo $line
					if [ "$flushOmaticHours" ] && [ "`echo $flushOmaticHours | awk '!/[^\.0-9]/ && $1<=24'`" ]; then
						flushOmaticHours=`echo $flushOmaticHours | awk '{print $1*1}'`
						echo " Engine Flush-O-Matic Set To Run Every $flushOmaticHours Hours!"
						break 2
					fi
					echo "      Invalid entry... Please try again :p"
					echo $line
				  done;;
			  d|D)flushOmaticHours=0
				  echo "       -=Engine Flush-O-Matic=- DISABLED!!"
				  pkill -9 "Flush|\/flush|superflush"
				  break;;
				*)echo "      Invalid entry... Please try again :p"
				  echo $line;;
			esac
		  done
		  update_options_in_scripts flush
		  update_options;;
		*)echo "               No Change For You!";;
	esac
}
Re_Generate_99SuperCharger(){
	echo "#!/system/bin/sh" > /data/99SuperCharger.sh
	echo "#" >> /data/99SuperCharger.sh
	for sc in /data/99SuperCharger.sh /system/etc/hw_config.sh; do
		if [ -f "$sc" ]; then cat >> $sc <<EOF
# V6 SuperCharger, OOM Grouping & Priority Fixes created by -=zeppelinrox=-
#
EOF
			terms $sc
			cat >> $sc <<EOF
# SuperMinFree Calculator & MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]
# Entropy-ness Enlarger (sysctl tweak for kernel.random.read_wakeup_threshold that keeps entropy_avail full) discovered by zeppelinrox.
#
# See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article!
# See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why 'Free RAM' Is NOT Wasted RAM!"
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.
# See http://goo.gl/P8Bvu - How Entropy-ness Enlarger works.
# See http://goo.gl/Zc85j - Possible reasons why it may actually do something :p
#
# Note: To customize the SD Card read ahead cache, change the "sdtweak" variable to the number of KB you want.
#       Valid values are from 64 and above.
#       If 0, the tweak is disabled.
#       If the value is invalid or missing, it defaults to using a value based on the device's RAM.
#       Example: If you want it to be 512 KB, make the line read "sdtweak=512;".
#
EOF
			if [ "$sc" = "/data/99SuperCharger.sh" ]; then cat >> $sc <<EOF
  ################################
 #  SuperCharger Service Notes  #
################################
# To leave the SuperCharger Service running, insert a # at the beginning of the "stop super_service" entry near the bottom of this script (3rd or 4th last line).
#
# To stop the SuperCharger Service, run Terminal Emulator and type...
# "su" and Enter.
# "stop super_service" and Enter.
#
# To restart the SuperCharger Service so it stays running, type...
# "su" and Enter.
# "start super_service" and Enter.
#
# If the service is running and you type: "grep -h [S]uper /proc/*/cmdline".
# The output would be "/data/99SuperCharger.sh".
#
# Similar results can be had with: "busybox ps | grep [S]uper".
#
EOF
				if [ ! "$allrcpaths" ]; then cat >> $sc <<EOF
# Ummm... this service won't work on your current ROM. Sorry :P
# Instead use Script Manager to run this script if you're on a stock ROM OR settings don't stick via the SuperCharger boot script found in /system/etc/init.d!
#
EOF
				fi
				cat >> $sc <<EOF
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_SuperCharger.log file to see what may have fubarred.
# set -x;
# exec > /data/Debug_SuperCharger.log 2>&1;
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin;
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi;
line=================================================;
mount -o remount,rw /data 2>/dev/null;
busybox mount -o remount,rw /data 2>/dev/null;
LOG_FILE=/data/Ran_SuperCharger.log;
bootloopcookie=/data/!!SuperChargerBootLoopMessage.log;
if [ -t 0 ]; then interactive=yes; fi;
if [ -f "\$bootloopcookie" ]; then
	if [ "\`echo \$0 | grep -v "init\.d"\`" ]; then stop super_service;
	else echo " \`date | awk '{print \$1,\$2,\$3,\$4}'\`: \$0 Detected A BootLoop... ABORTING..." >> \$LOG_FILE;
	fi;
	exit 69;
elif [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then echo " Delete this file to Re-Enable *99SuperCharger to run on boot..." > \$bootloopcookie;
fi;
ram=\$((\`awk '/MemTotal/{print \$2}' /proc/meminfo\`/1024));
# To set the next line manually, see comments at the top for instuctions!
sdtweak=$sdtweak;
if [ ! "\$sdtweak" ] || [ "\`echo \$sdtweak | awk '/[^0-9]/ || \$1>0 && \$1<64'\`" ]; then sdtweak=\$(((ram/64+1)*128)); fi;
# On the next line, "TCE=0;" will disable 3G TurboCharger Enhancement. Anything else enables it.
TCE=$tc3g;
# On the next line, "panicmode=0;" will disable the kernel panic settings. Anything else enables them.
panicmode=$panicmode;
# On the next line, "pyness=0;" will disable the Entropy-ness Enlarger. Anything else enables it.
pyness=$pyness;
# On the next line, "deduper=0;" will disable the Super Duper DeDuper. Anything else enables it.
deduper=$deduper;
MFK=$MFK
StartMeUp(){
	echo "";
	echo \$line;
	echo "   The -=V6 SuperCharger=- by -=zeppelinrox=-";
	echo \$line;
	echo "";
	echo " Version: $ver";
	echo "";
	echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`";
	echo "";
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*};
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		echo " You are NOT running this script as root...";
		echo "";
		echo \$line;
		echo "                      ...No SuperUser For You!!";
		echo \$line;
		echo "";
		echo "         ...Please Run as Root and try again...";
		echo "";
		echo \$line;
		echo "";
		exit 69;
	fi;
	echo " To verify application of settings...";
	echo "";
	echo "       ...check out \$LOG_FILE!";
	echo "";
	if [ -d "/system/etc/init.d" ]; then
		echo \$line;
		echo "   Also check /data/BootLog_SuperCharger.log!";
		for i in \`busybox ls -r /system/etc/init.d | grep -v SuperCharger\`; do
			if [ "\$j" ]; then break; fi;
			j=\$i;
		done;
		if [ "\`echo \$j | grep KickAssKernel\`" ] && [ "\$i" \\< "99SuperCharger" ] || [ "\$j" \\< "99SuperCharger" ]; then desiredname="/system/etc/init.d/99SuperCharger";
		elif [ "\`echo \$j | grep KickAssKernel\`" ] && [ "\$i" \\< "S99SuperCharger" ] || [ "\$j" \\< "S99SuperCharger" ]; then desiredname="/system/etc/init.d/S99SuperCharger";
		else desiredname="/system/etc/init.d/SS99SuperCharger";
		fi;
	fi;
	if [ "\`echo \$0 | grep "/init\.d"\`" ] && [ ! "\$interactive" ]; then Smart_Rename; fi;
};
remount(){
	mount -o remount,\$1 /system 2>/dev/null;
	busybox mount -o remount,\$1 /system 2>/dev/null;
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null;
};
install(){
	remount rw
	for i in /system/etc/init.d/*; do
		if [ -f "\$i" ]; then
			if [ "\`awk '/lowmemorykiller/&&!/Re-Enable this script/' "\$i"\`" ] && [ "\`echo "\$i" | awk '!/SuperCharger|super|disabled/'\`" ]; then
				sed -i '1 a\\
#\\
# SuperCharger script disabled this script for additional optimization.\\
# To Re-Enable this script, delete the lowmemorykiller stuff in here and rename this file.\\
#' "\$i";
				mv "\$i" "\$i.disabled_due_to_lowmemorykiller-Read_Comment_Inside_For_Fix";
			fi;
			if [ "\`echo "\$i" | awk '/oopy/&&!/zzloopy/'\`" ]; then
				sed -i '1 a\\
#\\
# Hey you should try BulletProofing Apps from within V6 SuperCharger instead!\\
#' "\$i";
				mv "\$i" /system/etc/init.d/zzloopy_runs_last_so_others_do_too;
			fi;
		fi;
	done
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo \$line;
		echo "";
		echo " Installing myself to \${1#*etc}";
		echo "";
		sleep 2;
		dd if=\$0 of=\$1;
		chown 0.0 \$1; chmod 777 \$1;
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo \$line;
		echo "";
		echo " \$1 is already up to date...";
		sleep 2;
	fi 2>/dev/null;
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo "";
		echo " To run, type in Terminal: \"su -c \${1##*/}\"";
		sleep 2;
	fi;
	remount ro;
};
Smart_Rename(){
	remount rw;
	echo \$line;
	echo "";
	echo " SuperCharger to run on boot as...";
	echo "";
	echo \$line;
	echo "        ...\$desiredname!";
	if [ "\$0" != "\$desiredname" ]; then
		mv \$0 \$desiredname;
		rm \$bootloopcookie;
		\$desiredname & exit 0;
	fi 2>/dev/null;
	echo \$line;
	echo "";
	remount ro;
};
EOF
			else cat >> $sc <<EOF
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin;
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi;
line=================================================;
mount -o remount,rw /data 2>/dev/null;
busybox mount -o remount,rw /data 2>/dev/null;
if [ -t 0 ]; then interactive=yes; fi;
ram=\$((\`awk '/MemTotal/{print \$2}' /proc/meminfo\`/1024));
# To set the next line manually, see comments at the top for instuctions!
sdtweak=$sdtweak;
if [ ! "\$sdtweak" ] || [ "\`echo \$sdtweak | awk '/[^0-9]/ || \$1>0 && \$1<64'\`" ]; then sdtweak=\$(((ram/64+1)*128)); fi;
# On the next line, "TCE=0;" will disable 3G TurboCharger Enhancement. Anything else enables it.
TCE=$tc3g;
# On the next line, "panicmode=0;" will disable the kernel panic settings. Anything else enables them.
panicmode=$panicmode;
# On the next line, "pyness=0;" will disable the Entropy-ness Enlarger. Anything else enables it.
pyness=$pyness;
# On the next line, "deduper=0;" will disable the Super Duper DeDuper. Anything else enables it.
deduper=$deduper;
MFK=$MFK
echo "";
EOF
			fi
			cat >> $sc <<EOF
KVM_Tweaks(){
	if [ "\`cat /proc/sys/vm/min_free_kbytes\`" -ne \$MFK ] || [ "\`cat /proc/sys/vm/vfs_cache_pressure\`" -ne 10 ]; then
		  ####################################
		 #  Kernel & Virtual Memory Tweaks  #
		####################################
		echo \$line;
		echo " Applying Kernel & Virtual Memory Tweaks...";
		echo \$line;
		echo -n "                    ";busybox sysctl -w vm.min_free_kbytes=\$MFK;
		echo -n "           ";busybox sysctl -w vm.oom_kill_allocating_task=0;
		echo -n "                       ";busybox sysctl -w vm.panic_on_oom=0;
		echo -n "                 ";busybox sysctl -w vm.vfs_cache_pressure=10;
		echo -n "                  ";busybox sysctl -w vm.overcommit_memory=1;
		echo -n "                         ";busybox sysctl -w vm.swappiness=20;
		if [ "\$panicmode" != 0 ]; then
			echo -n "                  ";busybox sysctl -w kernel.panic_on_oops=$kpoops;
			echo -n "                          ";busybox sysctl -w kernel.panic=$kpanic;
		fi;
		if [ "\$pyness" != 0 ]; then
			echo -n "  ";busybox sysctl -w kernel.random.write_wakeup_threshold=128;
			echo -n "   ";busybox sysctl -w kernel.random.read_wakeup_threshold=1376; # Entropy-ness Enlarger - keeps entropy_avail full - MAY save battery and/or boost responsiveness
		fi;
		echo "";
	fi;
	if [ -d "/sys/kernel/mm/uksm" ]; then ksmdir=uksm
	elif [ -d "/sys/kernel/mm/ksm" ]; then ksmdir=ksm
	fi
	if [ "\$deduper" != 0 ] && [ "$ksmdir" ] && [ ! "\`awk '/240|6000/' /sys/kernel/mm/$ksmdir/sleep_millisecs\`" ]; then
		echo \$line;
		echo " Applying the -=Super Duper DeDuper=-...!";
		echo \$line;
		echo ""
		echo 1 > /sys/kernel/mm/\$ksmdir/run;
		echo "               " /sys/kernel/mm/\$ksmdir/run "= 1";
		if [ -f "/sys/kernel/mm/\$ksmdir/cpu_governor" ]; then
			echo 240 > /sys/kernel/mm/\$ksmdir/sleep_millisecs;
			echo "   " /sys/kernel/mm/\$ksmdir/sleep_millisecs "= 240";
		else
			echo 6000 > /sys/kernel/mm/\$ksmdir/sleep_millisecs;
			echo "   " /sys/kernel/mm/\$ksmdir/sleep_millisecs "= 6000";
		fi
		if [ -f "/sys/kernel/mm/\$ksmdir/pages_to_scan" ]; then
			echo 1536 > /sys/kernel/mm/\$ksmdir/pages_to_scan;
			echo "     " /sys/kernel/mm/\$ksmdir/pages_to_scan "= 1536";
		fi;
		if [ -f "/sys/kernel/mm/\$ksmdir/scan_batch_pages" ]; then
			echo 1536 > /sys/kernel/mm/\$ksmdir/scan_batch_pages;
			echo "  " /sys/kernel/mm/\$ksmdir/scan_batch_pages "= 1536";
		fi;
		if [ -f "/sys/kernel/mm/\$ksmdir/abundant_threshold" ]; then
			echo 0 > /sys/kernel/mm/\$ksmdir/abundant_threshold;
			echo "" /sys/kernel/mm/\$ksmdir/abundant_threshold "= 0";
		fi;
		if [ -f "/sys/kernel/mm/\$ksmdir/cpu_governor" ]; then
			echo full > /sys/kernel/mm/\$ksmdir/cpu_governor;
			echo "      " /sys/kernel/mm/\$ksmdir/cpu_governor "= full";
		fi;
		if [ -f "/sys/kernel/mm/\$ksmdir/max_cpu_percentage" ]; then
			echo 95 > /sys/kernel/mm/\$ksmdir/max_cpu_percentage;
			echo "" /sys/kernel/mm/\$ksmdir/max_cpu_percentage "= 95";
		fi;
		echo "";
	fi;
	if [ -f "/system/lib/modules/frandom.ko" ] && [ ! -e "/dev/frandom" ]; then insmod /system/lib/modules/frandom.ko; fi;
	if [ -e "/dev/frandom" ]; then chmod 666 /dev/frandom; chmod 666 /dev/erandom;
		frandomtype=\`stat /dev/frandom | awk '/type/{print \$NF}'\`;
		erandomtype=\`stat /dev/erandom | awk '/type/{print \$NF}'\`;
		for dom in /dev/*random; do
			if [ "\$dom" != "/dev/frandom" ] && [ "\$dom" != "/dev/erandom" ]; then domtype=\`stat \$dom | awk '/type/{print \$NF}'\`;
				if [ "\$domtype" != "\$frandomtype" ] && [ "\$domtype" != "\$erandomtype" ]; then
					if [ ! "\$enforcedtitle" ]; then enforcedtitle=yes;
						echo \$line;
						echo " Applying the -=Fentropy enForcer=-...";
						echo \$line;
						echo "";
					fi;
					mv \$dom \$dom.unsuper;
					if [ "\$dom" = "/dev/random" ]; then ln /dev/frandom \$dom;
					else ln /dev/erandom \$dom;
					fi;
				fi;
			fi;
		done;
		enforcedtitle=;
	fi;
};
TCE(){
	if [ "\`cat /proc/sys/net/core/rmem_max\`" -ne 1048576 ] && [ "\$TCE" != 0 ]; then
		  ##################################
		 #  3G TurboCharger Enhancement!  #
		##################################
		echo \$line;
		echo " Applying 3G TurboCharger Enhancement...";
		echo \$line;
		echo -n "            ";busybox sysctl -w net.core.wmem_max=1048576;
		echo -n "            ";busybox sysctl -w net.core.rmem_max=1048576;
		echo -n "          ";busybox sysctl -w net.core.optmem_max=20480;
		echo -n " ";busybox sysctl -w net.ipv4.tcp_moderate_rcvbuf=1;                 # Be sure that autotuning is in effect
		echo -n "         ";busybox sysctl -w net.ipv4.route.flush=1;
		echo -n "        ";busybox sysctl -w net.ipv4.udp_rmem_min=6144;
		echo -n "        ";busybox sysctl -w net.ipv4.udp_wmem_min=6144;
		echo -n "       ";busybox sysctl -w net.ipv4.tcp_rmem='6144 87380 1048576';
		echo -n "       ";busybox sysctl -w net.ipv4.tcp_wmem='6144 87380 1048576';
		echo "";
	fi;
};
SD_Speed(){
	if [ "\`cat /sys/block/mmcblk0/bdi/read_ahead_kb\`" -ne \$sdtweak ] && [ "\$sdtweak" != 0 ]; then
		  #########################
		 #  SD Read Speed Tweak  #
		#########################
		echo \$line;
		echo " Applying SD Read Speed Tweak...";
		echo \$line;
		if [ "\`ls /sys/devices/virtual/bdi/179*/read_ahead_kb\`" ]; then
			for i in /sys/devices/virtual/bdi/179*/read_ahead_kb; do echo \$sdtweak > \$i; done;
		fi 2>/dev/null;
		echo \$sdtweak > /sys/block/mmcblk0/bdi/read_ahead_kb 2>/dev/null;
		echo \$sdtweak > /sys/block/mmcblk0/queue/read_ahead_kb 2>/dev/null;
		echo "";
	fi;
};
SuperCharge(){
	applyscminfree=; applyscadj=;
	currentadj=\`cat /sys/module/lowmemorykiller/parameters/adj\` 2>/dev/null;
	currentminfree=\`cat /sys/module/lowmemorykiller/parameters/minfree\` 2>/dev/null;
	scadj=\`cat /data/V6_SuperCharger/SuperChargerAdj\`;
	scminfree=\`cat /data/V6_SuperCharger/SuperChargerMinfree\`;
	if [ "\$scminfree" ] && [ "\$currentminfree" != "\$scminfree" ]; then applyscminfree=yes; fi;
	if [ "\$scadj" ] && [ "\$currentadj" != "\$scadj" ]; then applyscadj=yes; fi;
	echo \$line;
	if [ "\$applyscminfree" ] || [ "\$applyscadj" ]; then
		  ###########################
		 #  Get 50% SuperCharged!  #
		###########################
		echo " Gonna Get 50% SuperCharged...";
		echo \$line;
		echo "";
		remount rw;
		chmod 777 /sys/module/lowmemorykiller/parameters/adj 2>/dev/null;
		chmod 777 /sys/module/lowmemorykiller/parameters/minfree 2>/dev/null;
		if [ "\$scadj" ]; then echo \$scadj > /sys/module/lowmemorykiller/parameters/adj; fi 2>/dev/null;
		if [ "\$scminfree" ]; then echo \$scminfree > /sys/module/lowmemorykiller/parameters/minfree; fi 2>/dev/null;
EOF
			if [ "$buildprop" -eq 0 ]; then cat >> $sc <<EOF
		sed -i '/.*_ADJ/d;
				/.*_MEM/d' /system/build.prop;
EOF
				if [ -f "/system/bin/build.prop" ]; then cat >> $sc <<EOF
		sed -i '/.*_ADJ/d;
				/.*_MEM/d' /system/bin/build.prop;
EOF
				fi
			fi
			cat >> $sc <<EOF
		remount ro;
		echo " \`date | awk '{print \$1,\$2,\$3,\$4}'\`: Applied settings from \$0!" >> \$LOG_FILE;
		echo "         SuperCharger Settings Applied!";
	else
		echo "";
		echo " \`date | awk '{print \$1,\$2,\$3,\$4}'\`: No need to reapply settings from \$0!" >> \$LOG_FILE;
		echo " SuperCharger Settings Were ALREADY Applied...";
		echo "";
		echo "            ...there's no need to reapply them!";
	fi;
	echo "";
};
EOF
			if [ "$sc" = "/data/99SuperCharger.sh" ]; then cat >> $sc <<EOF
OhYeah(){
	KVM_Tweaks;
	TCE;
	SD_Speed;
	SuperCharge;
};
HellzYeah(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done;
	rm \$bootloopcookie 2>/dev/null;
	pkill -9 systemui;
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then
		echo \$line;
		echo "";
		echo " Now that Android is loaded...";
		echo "";
		echo "    ...I'll wait 2 minutes... then if need be...";
		echo "";
		echo "            ...Gonna SuperCharge this Android...";
		echo "";
		echo "              ...All Over Again... zoOM... zOOM!";
		echo "";
		sleep 120;
	fi;
	OhYeah;
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then
		echo \$line;
		echo "";
		echo " Oh what the heck...";
		echo "";
		echo " ...Some kernels and apps are very stubborn...";
		echo "";
		echo "                      ...but NOT more than me...";
		echo "";
		echo "             ...so in 6 mintues... if need be...";
		echo "";
		echo "   ...I'm goin' for three! zooM... zoOM... zOOM!";
		echo "";
		sleep 360;
		SuperCharge;
	fi;
	echo \$line;
	echo "";
	echo " \$0 Executed...";
	echo "";
	echo "          ===========================";
	echo "           ) SuperCharge Complete! (";
	echo "          ===========================";
	echo "";
	if [ -d "/system/etc/init.d" ] && [ "\`echo \$0 | grep -v "init\.d"\`" ]; then install \$desiredname; echo ""; fi;
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/99super; echo ""; fi;
	if [ "\`echo \$0 | grep -v "init\.d"\`" ]; then stop super_service; fi;
};
if [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; then exec > /data/BootLog_SuperCharger.log 2>&1; fi;
StartMeUp;
if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then OhYeah; fi;
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then HellzYeah;
else HellzYeah &
fi;
exit 0;
EOF
			else cat >> $sc <<EOF
HellzYeah(){
	KVM_Tweaks;
	TCE;
	SD_Speed;
	SuperCharge;
	echo \$line;
	echo "";
	echo " \$0 Executed...";
	echo "";
};
HellzYeah &
EOF
			fi
			echo "# End of V6 SuperCharged Entries." >> $sc
			if [ "$initrc" -eq 1 ]; then integrate_initrc $sc; fi
		fi
	done 2>/dev/null
	chown 0.0 /data/99SuperCharger.sh; chmod 777 /data/99SuperCharger.sh
	cp -fr /data/99SuperCharger.sh $storage/V6_SuperCharger/data
	cp -frp /data/99SuperCharger.sh /system/xbin/99super
	cp -fr /data/99SuperCharger.sh $storage/V6_SuperCharger/system/xbin/99super
	if [ "$1" ]; then echo " Re-Generating /system/xbin/99super..."
		if [ ! -f "/system/xbin/99super" ] || [ "`diff /data/99SuperCharger.sh /system/xbin/99super`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin 99super slim
		fi
	fi
	if [ "`ls /system/etc/hw_config.sh*`" ]; then cp -fr /system/etc/hw_config.sh* $storage/V6_SuperCharger/system/etc; fi 2>/dev/null
	if [ -d "/system/etc/init.d" ]; then rm -f /system/etc/init.d/*SuperCharger*
		j=
		for i in `busybox ls -r /system/etc/init.d`; do
			if [ "$j" ]; then break; fi
			j=$i
		done
		if [ "`echo $j | grep KickAssKernel`" ] && [ "$i" \< "99SuperCharger" ] || [ "$j" \< "99SuperCharger" ]; then desiredname="/system/etc/init.d/99SuperCharger"
		elif [ "`echo $j | grep KickAssKernel`" ] && [ "$i" \< "S99SuperCharger" ] || [ "$j" \< "S99SuperCharger" ]; then desiredname="/system/etc/init.d/S99SuperCharger"
		else desiredname="/system/etc/init.d/SS99SuperCharger"
		fi
		cp -frp /data/99SuperCharger.sh $desiredname
		rm $storage/V6_SuperCharger/system/etc/init.d/*SuperCharger*
		cp -fr $desiredname $storage/V6_SuperCharger/system/etc/init.d
		if [ "$1" ]; then echo " Re-Generating ${desiredname#*etc}..."
			if [ ! -f "$desiredname" ] || [ "`diff /data/99SuperCharger.sh $desiredname`" ]; then
				checkedspace=yes
				info_free_space_error init.d `basename $desiredname` slim
			fi
		fi
	fi
}
Re_Generate_97BulletProof_Apps(){
	cat > /data/97BulletProof_Apps.sh <<EOF
#!/system/bin/sh
#
# BulletProof Apps Boot Script created by -=zeppelinrox=-
#
EOF
	terms /data/97BulletProof_Apps.sh
	cat >> /data/97BulletProof_Apps.sh <<EOF
# Usage: 1. Runs automatically via custom rom's init.d folder or BulletProof Apps Service.
#        2. Type in Terminal: "su" and enter, "/data/97*" and enter.
#        3. Script Manager: launch it once like any other script OR with a widget (DO NOT PUT IT ON A SCHEDULE!)
#
# Important! Whether you run this with Terminal or Script Manager or widget, the script relaunches and kills itself after $bpwait seconds (default is 30 seconds).
#            So you can close the app after that time and BulletProof Apps continues in the background!
#
# Note: To customize BulletProof frequency, change the "bpwait" variable to the number of seconds you want.
#       Valid value is any whole number (no decimals) over 0.
#       If 0, it won't re-execute :P heh.
#       If the value is invalid or missing, it defaults to running every 30 seconds.
#       Example: If you want it to run every minute, make the line read "bpwait=60;".
#       WARNING: Making it too low may suck your battery faster than an Armstrong on a steroid. So don't be a nut.
#                14s is likely the lowest you should need to go so that nothing ever gets killed.
#
# To verify that it's running, type in Terminal:
# 1. "pstree | grep Bullet" - for init.d script or usage option 2 (with Terminal)
# 2. "pstree | grep sleep" - if using the service or usage option 3 (with Script Manager)
# 3. "grep -h [B]ullet /proc/*/cmdline" - Sure-Fire method ;^]
#     The output should be 2 items:
#         a. "/path/to/*97BulletProof_Apps*"
#         b. "BulletProof Apps is In Effect!" (sleep message)
# 4. "busybox ps | grep [B]ullet" would give similar results as 3.
#
# This script loads a list of apps via /data/V6_SuperCharger/BulletProof_Apps_HitList.
# You can easily add to or edit the HitList right from your device!
# Just enter a unique segment of the proces name! However, the more info you give, the better ;^]
#
# This ALSO loads /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh.
# Read the comments in that file for "Fine Tuning" instrucions!
#
# BONUS FEATURE: Auto-BOOM! (Auto-BulletProof OOM of currently in use app.)
#                It will automatically BulletProof the oom_adj priority of whatever app you're actively using!
#                So... if you're browsing, the browser gets "Auto-BOOMed".
#                Then if you switch to playing a game... the game gets Auto-BOOMed next!
#                This should make any app you're using snappier!
#
  ####################################
 #  BulletProof Apps Service Notes  #
####################################
# To leave the BulletProof Apps Service running, insert a # at the beginning of the "stop bullet_service" entry near the middle of this script.
#
# To stop the BulletProof Apps Service, run Terminal Emulator and type...
# "su" and Enter.
# "stop bullet_service" and Enter.
#
# To restart the BulletProof Apps Service, type...
# "su" and Enter.
# "start bullet_service" and Enter.
#
# If the service is running and you type: "grep -h [B]ullet /proc/*/cmdline".
# The output would be 2 items:
#     a. "/data/97BulletProof_Apps.sh"
#     b. "BulletProof Apps is In Effect!" (sleep message)
#
# Similar results can be had with: "busybox ps | grep [B]ullet".
#
EOF
	if [ ! "$allrcpaths" ]; then
		cat >> /data/97BulletProof_Apps.sh <<EOF
# Ummm... this service won't work on your current ROM. Sorry :P
# Instead use Script Manager to run this script if you're on a stock ROM and/or don't have init.d support.
#
EOF
	fi
	cat >> /data/97BulletProof_Apps.sh <<EOF
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_BulletProof_Apps.log file to see what may have fubarred.
# set -x;
# exec > /data/Debug_BulletProof_Apps.log 2>&1;
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin;
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi;
clear;
line=================================================;
mount -o remount,rw /data 2>/dev/null;
busybox mount -o remount,rw /data 2>/dev/null;
# To set the next line manually, see comments at the top for instuctions!
bpwait=$bpwait;
if [ ! "\$bpwait" ] || [ "\`echo \$bpwait | grep "[^0-9]"\`" ]; then bpwait=30; fi;
bpinterval="sleep \$bpwait";
bpapplist=\`cat /data/V6_SuperCharger/BulletProof_Apps_HitList\` 2>/dev/null;
if [ -t 0 ]; then interactive=yes; fi;
if [ "\`busybox ps -w\`" ]; then w=" -w"; fi 2>/dev/null;
remount(){
	mount -o remount,\$1 /system 2>/dev/null;
	busybox mount -o remount,\$1 /system 2>/dev/null;
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null;
};
Configure(){
	echo " BulletProof Apps Options...";
	echo " ===========================";
	echo "";
	sleep 1;
	echo " Current Status...";
	echo "";
	sleep 1;
	echo \$line;
	if [ "\$bpwait" -gt 0 ]; then echo " BulletProof Apps is ON @ \$bpwait second intervals!";
	else echo " BulletProof Apps is Currently OFF!";
	fi;
	echo \$line;
	echo "";
	sleep 1;
	if [ ! "\`busybox ps | grep "[B]ulletProof Apps is"\`" ]; then
		echo " If desired, you can change options for...";
		echo "";
		sleep 1;
		echo "                           ...BulletProof Apps!";
		echo "";
		sleep 1;
		echo " You can turn it on or off...";
		echo "";
		sleep 1;
		echo "        ...or just change how often it runs ;^]";
		echo "";
		sleep 1;
		echo \$line;
		echo " You can also configure this in Driver Options!";
		echo \$line;
		echo "";
		sleep 1;
		echo " Note that if enabled, the script will exit...";
		echo "";
		sleep 1;
		echo "   ...if you haven't BulletProofed any apps ;^]";
		echo "";
		sleep 1;
		if [ -d "/system/etc/init.d" ]; then
			echo " Also note that when it's enabled...";
			echo "";
			sleep 1;
			echo \$line;
			echo " BulletProof Apps on boot is AUTOMAGIC!";
			echo \$line;
			echo "";
			sleep 1;
			echo " Just check /data/BootLog_BulletProof_Apps.log!";
			echo "";
			$sleep;
		fi;
		echo \$line;
		echo "   Also READ THE COMMENTS inside this script!";
		echo \$line;
		echo "";
		sleep 1;
	fi;
	echo " Change BulletProof Apps Options?";
	echo "";
	sleep 1;
	echo -n " Enter Y for Yes, any key for No: ";
	read changeoptions
	echo "";
	echo \$line;
	case \$changeoptions in
	  y|Y)remount rw;
		  echo "";
		  sleep 1;
		  echo " Enable BulletProof Apps?";
		  while :; do
			echo "";
			sleep 1;
			echo -n " Enter E to Enable, D to Disable: ";
			read bullet
			echo "";
			echo \$line;
			case \$bullet in
				e|E)echo "";
					sleep 1;
					echo " How often do you want to BulletProof Apps?";
					echo "";
					sleep 1;
					echo " Note that values are in seconds...";
					echo "";
					sleep 1;
					echo " Too low a value may suck battery faster than...";
					echo "";
					sleep 1;
					echo "                ...an Armstrong on a steroid....";
					echo "";
					sleep 1;
					echo "                           ...so don't be a nut!";
					echo "";
					sleep 1;
					echo " btw 14s is likely the lowest you should go...";
					echo "";
					sleep 1;
					echo "           ...and nothing gets killed at 14s ;^]";
					while :; do
						echo "";
						sleep 1;
						echo -n " Enter any whole number (no decimals) over 0: ";
						read bpwait
						echo "";
						echo \$line;
						if [ "\$bpwait" ] && [ "\`echo \$bpwait | awk '!/[^0-9]/ && \$1>0'\`" ]; then
							echo " BulletProof Apps Set To Run Every \$bpwait seconds!";
							break 2;
						fi;
						echo "      Invalid entry... Please try again :p";
						echo \$line;
					done;;
				d|D)bpwait=0;
					echo "           BulletProof Apps DISABLED!!";
					break;;
				  *)echo "      Invalid entry... Please try again :p";
					echo \$line;;
			esac;
		  done;
		  sed -i '/^bpwait=/s/=.*/='\$bpwait'/' \$0;
		  for bproof in /data/97BulletProof_Apps.sh /system/etc/init.d/*BulletProof_Apps*; do
			if [ "\$0" != "\$bproof" ]; then sed -i '/^bpwait=/s/=.*/='\$bpwait'/' \$bproof; fi;
		  done 2>/dev/null;
		  if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
			awk 'BEGIN{OFS=FS=","}{\$12='\$bpwait';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp;
			mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions;
		  fi;
		  remount ro;;
		*)echo "               No Change For You!";;
	esac;
	echo \$line;
	echo "";
	sleep 1;
};
install(){
	if [ ! "\`grep \$ver "\$1"\`" ]; then
		echo "";
		echo " Installing myself to \${1#*etc}";
		sleep 2;
		remount rw;
		dd if=\$0 of=\$1;
		chown 0.0 \$1; chmod 777 \$1;
		remount ro;
	fi 2>/dev/null;
};
BulletProof_Apps(){
	if [ "\`echo \$0 | grep -v "\.sh"\`" ] && [ "\`busybox ps\$w | grep "/[d]ata/97BulletProof_Apps\.sh"\`" ]; then stop bullet_service; fi;
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done;
	if [ -d "/system/etc/init.d" ] && [ "\`echo \$0 | grep -v "init\.d"\`" ]; then
		if [ "\`ls /system/etc/init.d/S*\`" ]; then install /system/etc/init.d/S97BulletProof_Apps;
		else install /system/etc/init.d/97BulletProof_Apps;
		fi 2>/dev/null;
	fi;
	LOG_FILE=/data/Ran_BulletProof_Apps.log;
	echo "" | tee \$LOG_FILE;
	if [ "\$bpwait" -gt 0 ]; then echo " This should update every \$bpwait seconds!" >> \$LOG_FILE; fi;
	if [ "easyloglulz" ]; then
		echo " BulletProofing Apps with \$0!";
		echo "";
		echo \$line;
		echo " -=BulletProof Apps=- script by -=zeppelinrox=-";
		echo \$line;
		echo "";
		echo " Version: $ver";
		echo "";
		echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`";
		echo "";
	fi | tee -a \$LOG_FILE;
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*};
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo \$line | tee -a \$LOG_FILE;
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE;
		echo \$line | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo \$line | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		exit 69;
	elif [ "\`busybox ps | grep "[B]ulletProof Apps is"\`" ]; then
		echo " BulletProof Apps is already running!" | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		sleep 1;
		if [ "\$interactive" ]; then Configure; fi;
		exit 69;
	elif [ ! "\$bpapplist" ] && [ ! "\`grep "BulletProofing" /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh\`" ]; then
		echo " Uh... nothing is being bulletproofed... LOL" | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo " Both \"BulletProof_Apps_HitList\" AND..." | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo "        ...BulletProof_Apps_Fine_Tuner.sh..." | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo "                         ...are NOT configured!" | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
		echo \$line | tee -a \$LOG_FILE;
		echo " So I'll just \"Auto-BOOM\" any app you're using!" | tee -a \$LOG_FILE;
		echo \$line | tee -a \$LOG_FILE;
		echo "" | tee -a \$LOG_FILE;
	fi;
	if [ "easyloglulz" ]; then
		if [ "\`pgrep scriptmanager\`" ] && [ "\$bpwait" -gt 0 ]; then
			sleep 2;
			echo "         DO NOT PUT THIS ON A SCHEDULE!";
			echo "";
			sleep 2;
			echo "    It runs every \$bpwait seconds automatically!";
			echo "    =======================================";
			echo "";
			sleep 2;
		fi 2>/dev/null;
		echo " To verify that it's working...";
		echo "";
		echo "   ...check out \$LOG_FILE!";
		echo "";
		echo \$line;
		echo " zOOM... zOOM...";
		echo \$line;
		echo "";
		if [ "\$bpapplist" ]; then
			for bpapp in \$bpapplist; do
				if [ "\`pgrep \$bpapp\`" ]; then
					for bp in \`pgrep \$bpapp\`; do
						echo -17 > /proc/\$bp/oom_adj;
						echo -1000 > /proc/\$bp/oom_score_adj;
						renice -10 \$bp;
						echo " BulletProofed \$bpapp!";
						echo " \$bpapp's oom score is \`cat /proc/\$bp/oom_score\`";
						echo -n " \$bpapp's oom priority is ";
						if [ -f "/proc/\$bp/oom_adj" ]; then cat /proc/\$bp/oom_adj;
						else cat /proc/\$bp/oom_score_adj;
						fi;
						echo "";
					done 2>/dev/null;
				else
					echo " Can't find \$bpapp running...";
					echo "             ...so it can't be BulletProofed :(";
					echo "";
				fi;
			done;
		fi
		echo \$line;
		echo " Auto-BulletProofing OOM Of Current In Use App!";
		echo \$line;
		echo "";
		for aboom in \`busybox ps | awk '!/]|\//&&/\./{print \$1}'\`; do
			if [ "\`awk '\$1==0 || \$1==-17' /proc/\$aboom/oom_adj\`" ] || [ "\`awk '\$1==0 || \$1==-1000' /proc/\$aboom/oom_score_adj\`" ]; then
				aboomapp=\`cat /proc/\$aboom/cmdline\`;
				echo -17 > /proc/\$aboom/oom_adj;
				echo -1000 > /proc/\$aboom/oom_score_adj;
				renice -10 \$aboom;
				echo " Auto-BOOMed \$aboomapp!!";
				echo "";
				echo " \$aboomapp's oom score is \`cat /proc/\$aboom/oom_score\`";
				echo -n " \$aboomapp's oom priority is ";
				if [ -f "/proc/\$aboom/oom_adj" ]; then cat /proc/\$aboom/oom_adj;
				else cat /proc/\$aboom/oom_score_adj;
				fi;
				echo "";
			fi 2>/dev/null;
		done;
		if [ "\`grep "BulletProofing" /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh\`" ]; then sh /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh; fi;
		echo "         ==============================";
		echo "          ) BulletProofing Complete! (";
		echo "         ==============================";
		echo "";
	fi | tee -a \$LOG_FILE;
	if [ "\$interactive" ]; then Configure; fi;
	if [ "\$bpwait" -eq 0 ]; then
		if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then
			echo " And Hey! Init.d Start Up Scripts Are Working!";
			echo "";
		fi;
		exit 0;
	fi;
	echo " Waiting \$bpwait seconds to re-execute... then...";
	echo "";
	echo "                ...Gonna BulletProof Some More!";
	echo "";
	echo \$line;
	echo "    When this happens you can close this app!";
	echo \$line;
	echo "";
	echo " Hold on....";
	echo "";
	\$bpinterval | grep "BulletProof Apps is In Effect!";
	echo \$line;
	echo "        Ok done! You can close this App!";
	echo \$line;
	echo "";
	if [ "\`busybox --help | grep nohup\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then (busybox nohup \$0 > /dev/null &); exit 0;
	elif [ "\`busybox --help | grep start-stop-daemon\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then busybox start-stop-daemon -S -b -x \$0; exit 0;
	else \$0 > /dev/null & exit 0;
	fi;
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then BulletProof_Apps;
else exec > /data/BootLog_BulletProof_Apps.log 2>&1;
	BulletProof_Apps &
fi;
exit 0;
EOF
	chown 0.0 /data/97BulletProof_Apps.sh; chmod 777 /data/97BulletProof_Apps.sh
	cp -fr /data/97BulletProof_Apps.sh $storage/V6_SuperCharger/data
	if [ -d "/system/etc/init.d" ]; then rm -f /system/etc/init.d/*BulletProof_Apps*
		for i in /system/etc/init.d/S*; do Sfiles=$i; break; done
		if [ "$Sfiles" != "/system/etc/init.d/S*" ]; then bpname="/system/etc/init.d/S97BulletProof_Apps"
		else bpname="/system/etc/init.d/97BulletProof_Apps"
		fi
		cp -frp /data/97BulletProof_Apps.sh $bpname
		rm $storage/V6_SuperCharger/system/etc/init.d/*BulletProof_Apps*
		cp -fr $bpname $storage/V6_SuperCharger/system/etc/init.d
		if [ "$1" ]; then echo " Re-Generating ${bpname#*etc}..."
			if [ ! -f "$bpname" ] || [ "`diff /data/97BulletProof_Apps.sh $bpname`" ]; then
				checkedspace=yes
				info_free_space_error init.d `basename $bpname` slim
			fi
		fi
	fi
}
Re_Generate_PowerShift_Script(){
	if [ ! "$slot" ]; then
		psminfree=`echo $1 | awk '{gsub(/[^0-9,]/,"");print}'`
		MB1=`echo $psminfree | awk -F, '{print $1}'`;MB2=`echo $psminfree | awk -F, '{print $2}'`;MB3=`echo $psminfree | awk -F, '{print $3}'`;MB4=`echo $psminfree | awk -F, '{print $4}'`;MB5=`echo $psminfree | awk -F, '{print $5}'`;MB6=`echo $psminfree | awk -F, '{print $6}'`
		scminfree="$((MB1*256)),$((MB2*256)),$((MB3*256)),$((MB4*256)),$((MB5*256)),$((MB6*256))"
		MFK_Calculator
	fi
	cat > "/data/V6_SuperCharger/PowerShift_Scripts/$1" <<EOF
#!/system/bin/sh
#
# PowerShift Script for use with The V6 SuperCharger created by -=zeppelinrox=-
#
EOF
	terms "/data/V6_SuperCharger/PowerShift_Scripts/$1"
	cat >> "/data/V6_SuperCharger/PowerShift_Scripts/$1" <<EOF
# SuperMinFree Calculator & MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]
#
# See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article!
# See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why 'Free RAM' Is NOT Wasted RAM!"
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
clear
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
MFK=$MFK
echo ""
echo \$line
echo "    -=PowerShift=- script by -=zeppelinrox=-"
echo \$line
echo ""
sleep 1
echo " Version: $ver"
echo ""
sleep 1
echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
echo ""
sleep 1
id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
	sleep 2
	echo " You are NOT running this script as root..."
	echo ""
	sleep 3
	echo \$line
	echo "                      ...No SuperUser For You!!"
	echo \$line
	echo ""
	sleep 3
	echo "         ...Please Run as Root and try again..."
	echo ""
	echo \$line
	echo ""
	sleep 3
	exit 69
fi
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
remount rw
echo " PowerShifting to a different gear!"
echo ""
sleep 1
echo \$line
awk -F, '{OFMT="%.0f"; print "   Current Minfrees = "\$1/256","\$2/256","\$3/256","\$4/256","\$5/256","\$6/256" MB"}' /sys/module/lowmemorykiller/parameters/minfree
echo \$line
echo ""
sleep 1
echo " Setting LowMemoryKiller to..."
echo ""
sleep 1
echo \$line
echo "         ...$MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB"
echo \$line
echo ""
sleep 1
echo $scminfree > /sys/module/lowmemorykiller/parameters/minfree
echo $scminfree > /data/V6_SuperCharger/SuperChargerMinfree
echo " OOM Minfree levels are now set to..."
echo ""
sleep 1
echo "         ...\`cat /sys/module/lowmemorykiller/parameters/minfree\`"
echo ""
sleep 1
echo "  They are also your new SuperCharger values!"
echo ""
echo \$line
echo ""
sleep 1
echo " Updating Kernel & Virtual Memory Tweaks..."
echo ""
sleep 1
echo -n "         ...";busybox sysctl -w vm.min_free_kbytes=\$MFK
echo ""
sleep 1
echo \$line
echo " Updating MFK in *99SuperCharger Boot Scripts..."
echo \$line
echo ""
sleep 1
for mfk in /data/99SuperCharger.sh /system/xbin/99super /system/etc/init.d/*SuperCharger* /system/etc/hw_config.sh; do
	if [ -f "\$mfk" ]; then sed -i 's/^MFK=.*/MFK=$MFK/' \$mfk; fi
done
remount ro
echo "          ==========================="
echo "           ) PowerShift Completed! ("
echo "          ==========================="
echo ""
sleep 1
exit 0
EOF
	chown 0.0 "/data/V6_SuperCharger/PowerShift_Scripts/$1"; chmod 777 "/data/V6_SuperCharger/PowerShift_Scripts/$1"
	cp -fr "/data/V6_SuperCharger/PowerShift_Scripts/$1" $storage/V6_SuperCharger/data/V6_SuperCharger/PowerShift_Scripts
}
Re_Generate_BulletProof_1Shot(){
	bpappname=$1
	if [ -f "$1" ]; then bpwa1t=`awk '/^bpwa1t=/{gsub(/[^0-9]/,"");print}' $1`;fi
	if [ ! "$bpwa1t" ] || [ "`echo $bpwa1t | grep "[^0-9]"`" ]; then bpwa1t=30; fi
	cat > /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh <<EOF
#!/system/bin/sh
#
# BulletProof "One-Shot" Script created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh
	cat >> /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh <<EOF
# Usage: 1. Type in Terminal: "su" and enter, "/data/V6*/Bullet*/1Shot*" and enter. (This runs all 1Shot scripts)
#        2. Script Manager: launch it once like any other script OR with a widget (DO NOT PUT IT ON A SCHEDULE!)
#
# Important! Whether you run this with Terminal or Script Manager or widget, the script relaunches and kills itself after $bpwa1t seconds (default is 30 seconds).
#            So you can close the app after that time and the BulletProof "One-Shot" continues in the background!
#
# Note: To customize BulletProof frequency, change the "bpwa1t" variable to the number of seconds you want.
#       Valid value is any whole number (no decimals) over 0.
#       If 0, it won't re-execute :P heh.
#       If the value is invalid or missing, it defaults to running every 30 seconds.
#       Example: If you want it to run every minute, make the line read "bpwa1t=60;".
#       WARNING: Making it too low may suck your battery faster than an Armstrong on a steroid. So don't be a nut.
#                14s is likely the lowest you should need to go so that nothing ever gets killed.
#
# To verify that it's running, just run the script again!
# OR you can type in Terminal:
# 1. "pstree | grep 1Shot" - for usage option 1 (with Terminal)
# 2. "pstree | grep sleep" - for usage option 2 (with Script Manager)
# 3. "grep -h [1]Shot /proc/*/cmdline" - Sure-Fire method ;^]
#     The output should be 2 items:
#         a. "/data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh"
#         b. "1Shot-$bpappname is In Effect!" (sleep message).
# 4. "busybox ps | grep [1]Shot" would give similar results as 3.
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
clear
line=================================================
# To set the next line manually, see comments at the top for instuctions!
bpwa1t=$bpwa1t
if [ ! "\$bpwa1t" ] || [ "\`echo \$bpwa1t | grep "[^0-9]"\`" ]; then bpwa1t=30; fi
bpinterval="sleep \$bpwa1t"
echo ""
echo \$line
echo " -=BulletProof=- \"One-Shot\" by -=zeppelinrox=-"
echo \$line
echo ""
sleep 1
echo " Version: $ver"
echo ""
sleep 1
echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
echo ""
sleep 1
echo " You can change how often this script runs..."
echo ""
sleep 1
echo "          ...or have it run just this ONE time!"
echo ""
sleep 1
echo " To tweak this setting..."
echo ""
sleep 1
echo \$line
echo "      READ THE COMMENTS inside this script!"
echo \$line
echo ""
sleep 1
echo -n " Oh btw, its currently "
if [ "\$bpwa1t" -eq 0 ]; then echo "set to run just once..."
else echo "on a \$bpwa1t second delay..."
fi
echo ""
echo \$line
echo ""
sleep 1
if [ "\`busybox ps -w\`" ]; then w=" -w"; fi 2>/dev/null
id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
	sleep 2
	echo " You are NOT running this script as root..."
	echo ""
	sleep 3
	echo \$line
	echo "                      ...No SuperUser For You!!"
	echo \$line
	echo ""
	sleep 3
	echo "         ...Please Run as Root and try again..."
	echo ""
	echo \$line
	echo ""
	sleep 3
	exit 69
elif [ "\`busybox ps\$w | awk '/'$bpappname'/&&/ [i]s/'\`" ]; then
	echo " This 1Shot is already running!"
	echo ""
	exit 69
else
	if [ "\`pgrep $bpappname\`" ]; then
		for bp in \`pgrep $bpappname\`; do
			echo -17 > /proc/\$bp/oom_adj
			echo -1000 > /proc/\$bp/oom_score_adj
			renice -10 \$bp
			echo " BulletProofed $bpappname!"
			echo ""
			echo " $bpappname's oom score is \`cat /proc/\$bp/oom_score\`"
			echo ""
			echo -n " $bpappname's oom priority is "
			if [ -f "/proc/\$bp/oom_adj" ]; then cat /proc/\$bp/oom_adj
			else cat /proc/\$bp/oom_score_adj
			fi
			echo ""
		done 2>/dev/null
	else
		echo " Can't find $bpappname running..."
		echo ""
		echo "             ...so it can't be BulletProofed :("
		echo ""
	fi
	sleep 1
	echo "    ======================================="
	echo "     ) BulletProof \"One-Shot\" Completed! ("
	echo "    ======================================="
	echo ""
	sleep 1
	if [ "\$bpwa1t" -eq 0 ]; then exit 0; fi
	echo " Waiting \$bpwa1t seconds to re-execute... then..."
	echo ""
	sleep 1
	echo " Gonna BulletProof $bpappname again!"
	echo ""
	sleep 1
	echo \$line
	echo "    When this happens you can close this app!"
	echo \$line
	echo ""
	sleep 1
	echo " Hold on...."
	echo ""
	\$bpinterval | grep "1Shot-$bpappname is In Effect!"
	echo \$line
	echo "        Ok done! You can close this App!"
	echo \$line
	echo ""
	sleep 1
	if [ "\`busybox --help | grep nohup\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then (busybox nohup \$0 > /dev/null &); exit 0
	elif [ "\`busybox --help | grep start-stop-daemon\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then busybox start-stop-daemon -S -b -x \$0; exit 0
	fi
fi
\$0 > /dev/null & exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh; chmod 777 /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh
	cp -fr /data/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_One_Shots
}
Re_Generate_BulletProof_Apps_Fine_Tuner(){
	if [ -f "/data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh" ]; then sed -n '/# Begin/,$p' /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh > /data/bpaft.tmp 2>/dev/null; fi
	cat > /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh <<EOF
#!/system/bin/sh
#
# BulletProof Apps Fine Tuner created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh
	cat >> /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh <<EOF
# Use this file to "Fine Tune" App Priorities to your liking!
#
# The possible values of oom_adj range from -17 to 15.
# Newer kernels use oom_score_adj instead with values from -1000 to 1000.
# The higher the score, more likely the associated process is to be killed by OOM-killer.
# Basically, the conversion to the new system is oldstyle*1000/17 and the decimal is truncated.
# So if something had an ADJ of 6, it would now be 6*1000/17=352.94118... which truncates down to 352.
#
# A niceness (effects CPU Time) of -20 is the highest priority and 19 is the lowest priority.
# A higher priority process will get a larger chunk of the CPU time than a lower priority process.
# 0 is usually the default niceness for processes and is inherited from its parent process.
#
# In this script, by default, all apps have priorities applied as follows:
# echo -17 > /proc/\`pgrep *com.app.name*\`/oom_adj
# echo -1000 > /proc/\`pgrep *com.app.name*\`/oom_score_adj (one or the other will apply lol)
# renice -10 \`pgrep *com.app.name*\`
# The renice of -10 should be sufficient to keep it snappy but not interfere with other apps that you're using ;^]
#
# At the opposite end, if you wanted something to get killed off easily, you can change it to:
# echo 15 > /proc/\`pgrep *com.app.name*\`/oom_adj
# echo 1000 > /proc/\`pgrep *com.app.name*\`/oom_score_adj (for newer kernels)
# renice 19 \`pgrep *com.app.name*\`
#
# Typically, an app's (Secondary Servers) values (when SuperCharged) are:
# echo 6 > /proc/\`pgrep *com.app.name*\`/oom_adj
# echo 352 > /proc/\`pgrep *com.app.name*\`/oom_score_adj (for newer kernels)
# renice 0 \`pgrep *com.app.name*\`
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================;
echo \$line;
echo "     -=BulletProof Apps Fine Tuner Module=-";
echo \$line;
echo "";
echo " Version: $ver";
echo "";
echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`";
echo "";
echo " Find this in /data/V6_SuperCharger folder...";
echo "";
echo "                       ...read its comments...";
echo "";
echo "             ...and \"Fine Tune\" App Priorities!";
echo "";
echo \$line;
echo "";
id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*};
if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
	echo " You are NOT running this script as root...";
	echo "";
	echo \$line;
	echo "                      ...No SuperUser For You!!";
	echo \$line;
	echo "";
	echo "         ...Please Run as Root and try again...";
	echo "";
	echo \$line;
	echo "";
	exit 69;
fi
`cat /data/bpaft.tmp 2>/dev/null`
EOF
	rm -f /data/bpaft.tmp
	chown 0.0 /data/V6_SuperCharger/BulletProof_Apps*; chmod 777 /data/V6_SuperCharger/BulletProof_Apps*
	cp -fr /data/V6_SuperCharger/BulletProof_Apps* $storage/V6_SuperCharger/data/V6_SuperCharger
}
Re_Generate_BulletProof_Fine_Tunes(){
	bpappname=$1
	sed -i '/Begin '$bpappname'/,/End '$bpappname'/d' /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh
	cat >> /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh <<EOF
# Begin $bpappname BulletProofing
if [ "\`pgrep $bpappname\`" ]; then
	for bp in \`pgrep $bpappname\`; do
		echo -17 > /proc/\$bp/oom_adj;
		echo -1000 > /proc/\$bp/oom_score_adj;
		renice -10 \$bp;
		echo " BulletProofed $bpappname!";
		echo " $bpappname's oom score is \`cat /proc/\$bp/oom_score\`";
		echo -n " $bpappname's oom priority is ";
		if [ -f "/proc/\$bp/oom_adj" ]; then cat /proc/\$bp/oom_adj;
		else cat /proc/\$bp/oom_score_adj;
		fi;
		echo "";
	done 2>/dev/null;
else
	echo " Can't find $bpappname running...";
	echo "             ...so it can't be BulletProofed :(";
	echo "";
fi;
# End $bpappname BulletProofing
EOF
	cp -fr /data/V6_SuperCharger/BulletProof_Apps* $storage/V6_SuperCharger/data/V6_SuperCharger
}
Re_Generate_Detailing(){
	cat > /data/V6_SuperCharger/!Detailing.sh <<EOF
#!/system/bin/sh
#
# Detailing Script (SQLite VACUUM & REINDEX to optimize databases) created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/\!Detailing.sh
	cat >> /data/V6_SuperCharger/!Detailing.sh <<EOF
# This will optimize (defrag, reindex, debloat) ALL sqlite3 databases found on your device.
# Resulting in faster database access and less ram usage for smoother performance.
#
# Option 1. By default, this will optimize only databases which were recently changed and probably need it.
#           ie. It won't bother with those that have a modification time older than the log file!
# Option 2. Or, when asked, you can force it to optimize all apps! (Obviously, like other sqlite scripts, this takes longer).
#
# The code is HIGHLY optimized... so it's REALLY FAST!
#
# Get full stats from the log file!
#
# Note: You can change the "detailinterval" variable to any valid value that you want.
#       Valid values are from 1 to 9 (boots).
#       If 0, it won't run on boot.
#       If the value is invalid or missing, it defaults to running every 3rd boot.
#       Example: If you want it to run every 4th boot, make the line read "detailinterval=4".
#
# Props: avgjoemomma (from XDA) for the added reindex bit :)
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_Detailing.log file to see what may have fubarred.
# set -x
# exec > /data/Debug_Detailing.log 2>&1
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
# To set the next line manually, see comments at the top for instuctions!
detailinterval=$detailinterval
if [ ! "\$detailinterval" ] || [ "\`echo \$detailinterval | awk '/[^0-9]/ || \$1>9'\`" ]; then detailinterval=3; fi
counterfile=/data/!Detailing_Counter.log
if [ -f "\$counterfile" ]; then counter=\`awk '/Counter/{print \$NF}' \$counterfile\`; fi
if [ ! "\$counter" ]; then counter=\$((detailinterval-1)); fi
if [ -t 0 ]; then interactive=yes; fi
title(){
	echo \$line
	echo "    -=Detailing=- script by -=zeppelinrox=-"
	echo \$line
	echo ""
	sleep 2
	echo " Version: $ver"
	echo ""
	sleep 2
	echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
	echo ""
	sleep 2
}
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
Configure(){
	echo " Detailing On Boot..."
	echo " ===================="
	echo ""
	sleep 1
	echo \$line
	echo -n " Current Status: Detailing "
	if [ "\$detailinterval" -eq 0 ]; then echo "DOES NOT Run On Boot!"
	else echo "Runs Every \$detailinterval Boots!"
	fi
	echo \$line
	echo ""
	sleep 1
	echo " Just check /data/BootLog_Detailing.log!"
	echo ""
	sleep 1
	echo " If desired, you can change Detailing options.."
	echo ""
	sleep 1
	echo "        ...this script is VERY sophisticated..."
	echo ""
	sleep 1
	echo "           ...so boot time would be unaffected!"
	echo ""
	sleep 1
	echo " AND you can specify how often it runs..."
	echo ""
	sleep 1
	echo "  ...so if you input 4, it runs every 4th boot!"
	echo ""
	sleep 1
	echo " You can also configure this in Driver Options!"
	echo ""
	sleep 1
	echo \$line
	echo "   Also READ THE COMMENTS inside this script!"
	echo \$line
	echo ""
	sleep 1
	echo " Change Detailing Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo \$line
	case \$changeoptions in
		y|Y)remount rw
			echo ""
			sleep 1
			echo " Run Detailing on boot?"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootdetailing
			echo ""
			case \$bootdetailing in
			  y|Y)while :; do
					echo \$line
					echo ""
					sleep 1
					echo -n " How often? 1=every boot to 9=every 9th boot: "
					read detailinterval
					echo ""
					echo \$line
					case \$detailinterval in
					  [1-9])echo "       Detailing Set To Run Every \$detailinterval Boots!"
							echo \$line
							echo ""
							sleep 1
							echo " After every boot..."
							echo ""
							sleep 1
							echo " ..\$counterfile will be updated!"
							echo ""
							break;;
						  *)echo "      Invalid entry... Please try again :p";;
					esac
				  done;;
				*)detailinterval=0
				  echo "           Declined Detailing On Boot!";;
			esac
			sed -i '/^detailinterval=/s/=.*/='\$detailinterval'/' \$0
			for cav in /data/V6_SuperCharger/!Detailing.sh /system/xbin/vac /system/etc/init.d/92vac; do
				if [ "\$0" != "\$cav" ]; then sed -i '/^detailinterval=/s/=.*/='\$detailinterval'/' \$cav; fi
			done 2>/dev/null
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				awk 'BEGIN{OFS=FS=","}{\$14='\$detailinterval';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
			fi
			remount ro;;
		  *)echo "               No Change For You!";;
	esac
	echo \$line
	echo ""
	sleep 1
}
install(){
	remount rw
	for i in /system/etc/init.d/*; do
		if [ -f "\$i" ] && [ "\`awk '/VACUUM/&&!/Re-Enable this script/' "\$i"\`" ] && [ "\`echo "\$i" | awk '!/etail|vac|disabled/'\`" ]; then
			sed -i '1 a\\
#\\
# Detailing (aka "vac") script disabled this script for additional optimization.\\
# To Re-Enable this script, delete the sqlite VACUUM stuff in here and rename this file.\\
#' "\$i"
			mv "\$i" "\$i.disabled_due_to_slow_VACUUM-Read_Comment_Inside_For_Fix"
		fi
	done
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo ""
		echo " Installing myself to \${1#*etc}"
		sleep 2
		dd if=\$0 of=\$1
		chown 0.0 \$1; chmod 777 \$1
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " \$1 is already up to date..."
		sleep 2
	fi 2>/dev/null
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " To run, type in Terminal: \"su -c \${1##*/}\""
		sleep 2
	fi
	remount ro
}
Details_Details(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/vac; fi
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then counter=\$((counter+1))
		if [ "\$detailinterval" -eq 0 ]; then echo ""; title
			echo " Current Status: Detailing DOES NOT Run On Boot!"
			echo ""
			echo " But Hey! Init.d Start Up Scripts Are Working!"
			echo ""
			exit 0
		elif [ "\$counter" -lt "\$detailinterval" ]; then echo ""; title
			sed -i 's/Counter.*/Counter: '\$counter'/' \$counterfile
			echo " Current Status: Detailing Runs Every \$detailinterval Boots!"
			echo " Detailing last ran \$counter reboots ago..." | tee -a \$counterfile
			echo " It exited peacefully on \`date | awk '{print \$1,\$2,\$3,\$4}'\`" >> \$counterfile
			echo "" | tee -a \$counterfile
			exit 0
		fi
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/92vac
	fi
	LOG_FILE=/data/Ran_Detailing.log
	lastran=/data/!Detailing_Last_Ran.log
	mv \$LOG_FILE \$lastran 2>/dev/null
	if [ "easyloglulz" ]; then
		echo "" | tee \$counterfile
		title | tee -a \$counterfile
		echo "   Boot Counter: 0" >> \$counterfile
		echo " Current Status: Detailing Runs Every \$detailinterval Boots!" | tee -a \$counterfile
		echo "" | tee -a \$counterfile
		sleep 2
		if [ "\$interactive" ]; then echo " Detailing last ran manually - counter reset!" | tee -a \$counterfile
		else echo " Detailing ran on the most recent boot..." | tee -a \$counterfile
		fi
		echo " It was executed on \`date | awk '{print \$1,\$2,\$3,\$4}'\`" | tee -a \$counterfile
		echo "" | tee -a \$counterfile
		echo \$line
		echo ""
		sleep 2
	fi | tee \$LOG_FILE
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		sleep 1
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		exit 69
	elif [ ! "\`which sqlite3\`" ]; then
		sleep 1
		echo " Doh... sqlite3 binary was NOT found..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No Vacuuming For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo " Load the XDA SuperCharger thread..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "   ...and install The SuperCharger Starter Kit!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!SuperCharger.html | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		if [ ! "\$interactive" ] && [ -f "/data/BootLog_Detailing.log" ]; then
			LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -d file:///data/BootLog_Detailing.log -t text/plain
			echo ""
			echo \$line
			echo ""
			sleep 3
		fi | tee -a \$LOG_FILE
		exit 69
	fi
	if [ "easyloglulz" ]; then
		if [ -f "\$lastran" ] && [ "\$interactive" ]; then
			echo " Optimize ALL databases or recently changed?"
			echo ""
			sleep 1
			echo -n " Enter (A)LL, any key for recently modified: "
			read how
			echo ""
			case \$how in
				a|A)rm \$lastran;;
				  *);;
			esac
			echo \$line
			echo ""
			sleep 1
		fi
		echo " Commencing SQLite VACUUM & REINDEX!"
		echo ""
		sleep 1
		echo " Please IGNORE any errors that say..."
		echo "        ======"
		echo ""
		sleep 1
		echo " \"malformed database\" OR \"collation sequence\"!"
		echo "  ==================      =================="
		echo ""
		sleep 1
		echo "   ...as they won't effect SQLite Optimization!"
		echo ""
		sleep 1
		echo \$line
		echo " This may take awhile... please wait..."
		echo \$line
		echo ""
	fi | tee -a \$LOG_FILE
	sqlite3version=\`sqlite3 -version | awk '{print \$1}'\`
	busybox find /*d*/ -iname "*.db" | grep -v \/sdcard > /data/dbs.tmp
	TOTAL=\`grep -c . /data/dbs.tmp\`
	START=\`date +%s\`
	BEGAN=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	OPTIMIZED=0
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	echo " Start Detailing: \$BEGAN" >> \$LOG_FILE
	echo "" >> \$LOG_FILE
	busybox sync
	while read db; do
		PROGRESS=\$((PROGRESS+1))
		PERCENT=\$((PROGRESS*100/TOTAL ))
		if [ "\$interactive" ]; then
			if [ "\$PERCENT" -eq "\$INCREMENT" ]; then
				INCREMENT=\$((INCREMENT+3))
				PROGRESS_BAR="\$PROGRESS_BAR="
			fi
			clear
			echo ""
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
			echo "        -=Detailing=- by -=zeppelinrox=-"
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
		fi
		echo ""
		echo "        Processing DBs - \$PERCENT% (\$PROGRESS of \$TOTAL)"
		echo ""
		if [ ! -f "\$lastran" ] || [ "\$db" -nt "\$lastran" ]; then OPTIMIZED=\$((OPTIMIZED+1)); doit=yes; fi
		echo "     Needed Optimizing - \$OPTIMIZED"
		echo ""
		if [ "\$doit" ]; then doit=
			OPTIMIZED=\$((OPTIMIZED+1))
			if [ "\$sqlite3version" = 3.7.4 ] && [ "\`echo \$db | awk '/providers\.media/&&/external.*\.db/'\`" ]; then
				echo "   SKIPPING: \$db (Problematic)" | tee -a \$LOG_FILE
			else
				echo "  VACUUMING: \$db" | tee -a \$LOG_FILE
				sqlite3 \$db 'VACUUM;' | tee -a \$LOG_FILE;
				echo " REINDEXING: \$db" | tee -a \$LOG_FILE
				sqlite3 \$db 'REINDEX;' | tee -a \$LOG_FILE;
			fi
		fi
	done < /data/dbs.tmp
	busybox sync
	rm /data/dbs.tmp
	rm \$lastran 2>/dev/null
	STOP=\`date +%s\`
	ENDED=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	RUNTIME=\$((STOP-START))
	HOURS=\$((RUNTIME/3600)); MINS=\$((RUNTIME/60%60)); SECS=\$((RUNTIME%60))
	RUNTIME=\`printf "%d:%02d:%02d\n" \$HOURS \$MINS \$SECS\`
	echo "" | tee -a \$LOG_FILE
	echo \$line | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " ALL \$TOTAL Databases for ALL Apps are Optimized!" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	echo " Optimized \$OPTIMIZED! (Were modified since last run)" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo "                 ...Say Hello To Optimized DBs!"
	echo ""
	echo \$line
	echo ""
	sleep 1
	echo "      Start Time: \$BEGAN" | tee -a \$LOG_FILE
	echo "       Stop Time: \$ENDED" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	echo " Completion Time: \$RUNTIME" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " See \$LOG_FILE for more details!"
	echo ""
	sleep 1
	echo "           ==========================" | tee -a \$LOG_FILE
	echo "            ) Detailing Completed! (" | tee -a \$LOG_FILE
	echo "           ==========================" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	if [ -d "/system/etc/init.d" ] && [ "\$interactive" ]; then Configure; fi
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then Details_Details
else exec > /data/BootLog_Detailing.log 2>&1
	Details_Details &
fi
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!Detailing.sh; chmod 777 /data/V6_SuperCharger/!Detailing.sh
	cp -fr /data/V6_SuperCharger/!Detailing.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!Detailing.sh /system/xbin/vac
	cp -fr /data/V6_SuperCharger/!Detailing.sh $storage/V6_SuperCharger/system/xbin/vac
	if [ "$1" ]; then echo " Re-Generating /system/xbin/vac..."
		if [ ! -f "/system/xbin/vac" ] || [ "`diff /data/V6_SuperCharger/!Detailing.sh /system/xbin/vac`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin vac slim
		fi
	fi
	if [ -d "/system/etc/init.d" ]; then
		for i in /system/etc/init.d/*; do
			if [ -f "$i" ] && [ "`awk '/VACUUM/&&!/Re-Enable this script/' "$i"`" ] && [ "`echo "$i" | awk '!/etail|vac|disabled/'`" ]; then
				sed -i '1 a\
#\
# Detailing (aka "vac") script disabled this script for additional optimization.\
# To Re-Enable this script, delete the sqlite VACUUM stuff in here and rename this file.\
#' "$i"
				mv "$i" "$i.disabled_due_to_slow_VACUUM-Read_Comment_Inside_For_Fix"
			fi
		done
		cp -frp /data/V6_SuperCharger/!Detailing.sh /system/etc/init.d/92vac
		cp -fr /data/V6_SuperCharger/!Detailing.sh $storage/V6_SuperCharger/system/etc/init.d/92vac
		if [ "$1" ]; then echo " Re-Generating /init.d/92vac..."
			if [ ! -f "/system/etc/init.d/92vac" ] || [ "`diff /data/V6_SuperCharger/!Detailing.sh /system/etc/init.d/92vac`" ]; then
				checkedspace=yes
				info_free_space_error /etc/init.d 92vac slim
			fi
		fi
	fi
}
Re_Generate_WheelAlignment(){
	cat > /data/V6_SuperCharger/!WheelAlignment.sh <<EOF
#!/system/bin/sh
#
# "ZepAlign" / Wheel Alignment Script (ZipAlign) created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/\!WheelAlignment.sh
	cat >> /data/V6_SuperCharger/!WheelAlignment.sh <<EOF
# ZipAligns all data, system and asec apks (apps) that have not yet been ZipAligned.
# ZipAlign optimizes all your apps, resulting in less RAM comsumption and a faster device! ;^]
#
# Option 1. By default, this will check and/or zipalign only apks which were recently added and may need it.
# Option 2. Or, when asked, you can force it to zipalign all apks! (Obviously, this takes a bit longer).
#
# The code is HIGHLY optimized... so it's REALLY FAST!
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Added BRAINS: By default, it will only check apks that were added since last run (ie. newer than the log file!)
#      - Added support for /vendor/app (POST-ICS).
#      - Added support for /mnt/asec.
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging.
#      - Enhanced logging!
#      - Tweaked interface... just a wittle bit ;^]
#
# Props: Automatic ZipAlign by Wes Garner (original script)
#        oknowton for the change from MD5 to zipalign -c 4
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_ZepAlign.log file to see what may have fubarred.
# set -x
# exec > /data/Debug_ZepAlign.log 2>&1
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
# Next line only applies to the init.d boot script. "bootzepalign=1" means run on boot. Anything else disables it.
bootzepalign=$zepalign
bootupdelay="sleep 180"
if [ -t 0 ]; then interactive=yes; fi
title(){
	echo \$line
	echo "  -=Wheel Alignment=- script by -=zeppelinrox=-"
	echo \$line
	echo ""
	sleep 2
	echo " Version: $ver"
	echo ""
	sleep 2
	echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
	echo ""
	sleep 2
}
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
Configure(){
	echo " Wheel Alignment On Boot..."
	echo " =========================="
	echo ""
	sleep 1
	echo \$line
	echo -n " Status: Wheel Alignment "
	if [ "\$bootzepalign" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo \$line
	echo ""
	sleep 1
	echo " Just check /data/BootLog_ZepAlign.log!"
	echo ""
	sleep 1
	echo " If desired, you can change boot options..."
	echo ""
	sleep 1
	echo "        ...this script is VERY sophisticated..."
	echo ""
	sleep 1
	echo "           ...so boot time would be unaffected!"
	echo ""
	sleep 1
	echo " You can also configure this in Driver Options!"
	echo ""
	sleep 1
	echo \$line
	echo "   Also READ THE COMMENTS inside this script!"
	echo \$line
	echo ""
	sleep 1
	echo " Change Wheel Alignment Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo \$line
	case \$changeoptions in
		y|Y)remount rw
			echo ""
			sleep 1
			echo " Run Wheel Alignment on boot?"
			echo ""
			sleep 1
			echo " Note: If you say Yes, Fix Alignment On Boot..."
			echo "      ...gets disabled (avoids overlapping mods)"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootzepalign
			echo ""
			echo \$line
			case \$bootzepalign in
			  y|Y)zepalign=1; fixalign=0
				  echo "       Wheel Alignment Set To Run On Boot!";;
				*)zepalign=0
				  echo "     Boot Align Declined... does that rhyme?";;
			esac
			sed -i '/^bootzepalign=/s/=.*/='\$zepalign'/' \$0
			for ngilapez in /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign /system/etc/init.d/93zepalign; do
				if [ "\$0" != "\$ngilapez" ]; then sed -i '/^bootzepalign=/s/=.*/='\$zepalign'/' \$ngilapez; fi
			done 2>/dev/null
			if [ "\$fixalign" ]; then
				for ngilaxif in /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign /system/etc/init.d/95fixalign; do
					if [ -f "\$ngilaxif" ]; then sed -i '/^bootfixalign=/s/=.*/='\$fixalign'/' \$ngilaxif; fi
				done
			fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				if [ "\$fixalign" ]; then awk 'BEGIN{OFS=FS=","}{\$15='\$zepalign',\$17='\$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				else awk 'BEGIN{OFS=FS=","}{\$15='\$zepalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				fi
				mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
			fi
			remount ro;;
		  *)echo "               No Change For You!";;
	esac
	echo \$line
	echo ""
	sleep 1
}
install(){
	remount rw
	for i in /system/etc/init.d/*; do
		if [ -f "\$i" ] && [ "\`awk '/zipalign/&&!/Re-Enable this script/' "\$i"\`" ] && [ "\`echo "\$i" | awk '!/Alignment|zepalign|fixalign|disabled/'\`" ]; then
			sed -i '1 a\\
#\\
# Wheel Alignment (aka "zepalign") script disabled this script for additional optimization.\\
# To Re-Enable this script, delete the zipalign stuff in here and rename this file.\\
#' "\$i"
			mv "\$i" "\$i.disabled_due_to_slow_zipalign-Read_Comment_Inside_For_Fix"
		fi
	done
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo ""
		echo " Installing myself to \${1#*etc}"
		sleep 2
		dd if=\$0 of=\$1
		chown 0.0 \$1; chmod 777 \$1
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " \$1 is already up to date..."
		sleep 2
	fi 2>/dev/null
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " To run, type in Terminal: \"su -c \${1##*/}\""
		sleep 2
	fi
	remount ro
}
Get_PWN (){ PWN=\`busybox stat "\$1" | awk -F [\(\/] '/Uid/{gsub(/ /,"");print \$4,\$6,substr(\$2,2,3)}'\`; }
apply_permissions(){
	echo "    chown \$1:\$2 \$4" | tee -a \$LOG_FILE
	chown \$1:\$2 "\$4" 2>&1 | tee -a \$LOG_FILE
	echo "    chmod \$3 \$4" | tee -a \$LOG_FILE
	chmod \$3 "\$4" 2>&1 | tee -a \$LOG_FILE
}
ZepAlign(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/zepalign; fi
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then echo ""
		if [ "\$bootzepalign" -ne 1 ]; then
			title
			echo " Current Status: Wheel Alignment DOES NOT Run On Boot!"
			echo ""
			echo " But Hey! Init.d Start Up Scripts Are Working!"
			echo ""
			exit 0
		else echo \$bootupdelay | awk '{print " Waiting for "\$NF" seconds..."}'; \$bootupdelay
		fi
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/93zepalign
	fi
	LOG_FILE=/data/Ran_ZepAlign.log
	lastran=/data/!ZepAlign_Last_Ran.log
	mv \$LOG_FILE \$lastran 2>/dev/null
	echo "" | tee \$LOG_FILE
	title | tee -a \$LOG_FILE
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		sleep 1
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		exit 69
	elif [ ! "\`which zipalign\`" ]; then
		sleep 1
		echo " Doh... zipalign binary was NOT found..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                    ...No ZepAligning For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo " Load the XDA SuperCharger thread..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "   ...and install The SuperCharger Starter Kit!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!SuperCharger.html | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		if [ ! "\$interactive" ] && [ -f "/data/BootLog_ZepAlign.log" ]; then
			LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -d file:///data/BootLog_ZepAlign.log -t text/plain
			echo ""
			echo \$line
			echo ""
			sleep 3
		fi | tee -a \$LOG_FILE
		exit 69
	fi
	if [ "easyloglulz" ]; then
		if [ -f "\$lastran" ] && [ "\$interactive" ]; then
			echo " ZipAlign ALL Apps or only recently installed?"
			echo ""
			sleep 1
			echo -n " Enter (A)LL, any key for recently added: "
			read how
			echo ""
			case \$how in
				a|A)rm \$lastran;;
				  *);;
			esac
			echo \$line
			echo ""
			sleep 1
		fi
	fi | tee -a \$LOG_FILE
	remount rw
	START=\`date +%s\`
	BEGAN=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	TOTAL=\$((\`ls /*/*/*.apk 2>/dev/null | wc -l\`+\`ls /*/*/*/*.apk 2>/dev/null | wc -l\`+\`ls /*/*/*/*/*.apk 2>/dev/null | wc -l\`))
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	NEW=0; ALIGNED=0; ALREADY=0; FAILED=0
	echo " Start Wheel Alignment ( \"ZepAlign\" ): \$BEGAN" >> \$LOG_FILE
	echo "" >> \$LOG_FILE
	busybox sync
	for ApkFile in /*/*/*.apk /*/*/*/*.apk /*/*/*/*/*.apk; do
		if [ ! -f "\$ApkFile" ]; then continue; fi
		PROGRESS=\$((PROGRESS+1))
		PERCENT=\$((PROGRESS*100/TOTAL ))
		if [ "\$interactive" ]; then
			if [ "\$PERCENT" -eq "\$INCREMENT" ]; then
				INCREMENT=\$((INCREMENT+3))
				PROGRESS_BAR="\$PROGRESS_BAR="
			fi
			clear
			echo ""
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
			echo "       Wheel Alignment by -=zeppelinrox=-"
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
		fi
		echo ""
		echo "       Processing APKs - \$PERCENT% (\$PROGRESS of \$TOTAL)"
		echo ""
		ApkDir="\`busybox dirname "\$ApkFile"\`"
		if [ ! -f "\$lastran" ] || [ "\$ApkFile" -nt "\$lastran" ]; then NEW=\$((NEW+1))
			echo " Checking ZipAlignment of \$ApkFile..." | tee -a \$LOG_FILE
			zipalign -c 4 "\$ApkFile"
			if [ "\$?" -gt 0 ]; then Get_PWN "\$ApkFile"
				echo "    \$ApkFile needs zipaligning!" | tee -a \$LOG_FILE
				apkzipaligned="\`busybox basename "\$ApkFile"\`"
				zipalign -f 4 "\$ApkFile" "/cache/\$apkzipaligned"
				if [ "\$?" -eq 0 ]; then
					if [ -e "/cache/\$apkzipaligned" ]; then
						echo "    ZipAligning \$ApkFile... SUCCESSFUL!" | tee -a \$LOG_FILE
						if [ "\`echo \$ApkDir | grep asec\`" ]; then mount -o remount,rw "\$ApkDir"; fi
						cp -f "/cache/\$apkzipaligned" "\$ApkFile" | tee -a \$LOG_FILE
						ALIGNED=\$((ALIGNED+1))
						if [ "\`echo \$ApkDir | grep asec\`" ] && [ "\`mount | awk '/'\$PkgName'/&&!/vfat/'\`" ] || [ "\`echo \$ApkDir | awk '!/asec|sdcard/'\`" ]; then
							echo "    Applying same permissions as ORIGINAL file..." | tee -a \$LOG_FILE
							apply_permissions \$PWN "\$ApkFile"
						fi
					else
						echo "    ZipAligning \$ApkFile... Failed (No Output File!)" | tee -a \$LOG_FILE
						FAILED=\$((FAILED+1))
						failedapp=\`echo "\$failedapp, \$apkzipaligned" | sed 's/^, //'\`
					fi
				else echo "    ZipAligning \$ApkFile... Failed (rc: \$rc!)" | tee -a \$LOG_FILE
					FAILED=\$((FAILED+1))
					failedapp=\`echo "\$failedapp, \$apkzipaligned" | sed 's/^, //'\`
				fi
				rm "/cache/\$apkzipaligned" 2>/dev/null
			else
				echo "    ZipAlign not needed for \$ApkFile" | tee -a \$LOG_FILE
				ALREADY=\$((ALREADY+1))
			fi
		fi
	done
	busybox sync
	rm \$lastran 2>/dev/null
	remount ro
	STOP=\`date +%s\`
	ENDED=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	RUNTIME=\$((STOP-START))
	HOURS=\$((RUNTIME/3600)); MINS=\$((RUNTIME/60%60)); SECS=\$((RUNTIME%60))
	RUNTIME=\`printf "%d:%02d:%02d\n" \$HOURS \$MINS \$SECS\`
	echo "" | tee -a \$LOG_FILE
	echo \$line | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " Done \"ZepAligning\" ALL data and system APKs..." | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " \$NEW	Apps were checked (added since last run)" | tee -a \$LOG_FILE
	echo " \$ALIGNED	Apps were zipaligned" | tee -a \$LOG_FILE
	echo " \$ALREADY	Apps were already zipaligned" | tee -a \$LOG_FILE
	echo " \$FAILED	Apps were NOT zipaligned due to error" | tee -a \$LOG_FILE
	if [ "\$failedapp" ]; then echo "    (\$failedapp)" | tee -a \$LOG_FILE; fi
	echo "" | tee -a \$LOG_FILE
	echo " \$TOTAL	Apps were processed!" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo "                ...Say Hello To Optimized Apps!"
	echo ""
	echo \$line
	echo ""
	sleep 1
	echo "      Start Time: \$BEGAN" | tee -a \$LOG_FILE
	echo "       Stop Time: \$ENDED" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	echo " Completion Time: \$RUNTIME" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " See \$LOG_FILE for more details!"
	echo ""
	sleep 1
	echo "        ================================" | tee -a \$LOG_FILE
	echo "         ) Wheel Alignment Completed! (" | tee -a \$LOG_FILE
	echo "        ================================" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	if [ -d "/system/etc/init.d" ] && [ "\$interactive" ]; then Configure; fi
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then ZepAlign
else exec > /data/BootLog_ZepAlign.log 2>&1
	ZepAlign &
fi
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!WheelAlignment.sh; chmod 777 /data/V6_SuperCharger/!WheelAlignment.sh
	cp -fr /data/V6_SuperCharger/!WheelAlignment.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign
	cp -fr /data/V6_SuperCharger/!WheelAlignment.sh $storage/V6_SuperCharger/system/xbin/zepalign
	if [ "$1" ]; then echo " Re-Generating /system/xbin/zepalign..."
		if [ ! -f "/system/xbin/zepalign" ] || [ "`diff /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin zepalign slim
		fi
	fi
	if [ -d "/system/etc/init.d" ]; then
		for i in /system/etc/init.d/*; do
			if [ -f "$i" ] && [ "`awk '/zipalign/&&!/Re-Enable this script/' "$i"`" ] && [ "`echo "$i" | awk '!/Alignment|zepalign|fixalign|disabled/'`" ]; then
				sed -i '1 a\
#\
# Wheel Alignment (aka "zepalign") script disabled this script for additional optimization.\
# To Re-Enable this script, delete the zipalign stuff in here and rename this file.\
#' "$i"
				mv "$i" "$i.disabled_due_to_slow_zipalign-Read_Comment_Inside_For_Fix"
			fi
		done
		cp -frp /data/V6_SuperCharger/!WheelAlignment.sh /system/etc/init.d/93zepalign
		cp -fr /data/V6_SuperCharger/!WheelAlignment.sh $storage/V6_SuperCharger/system/etc/init.d/93zepalign
		if [ "$1" ]; then echo " Re-Generating /init.d/93zepalign..."
			if [ ! -f "/system/etc/init.d/93zepalign" ] || [ "`diff /data/V6_SuperCharger/!WheelAlignment.sh /system/etc/init.d/93zepalign`" ]; then
				checkedspace=yes
				info_free_space_error /etc/init.d 93zepalign slim
			fi
		fi
	fi
}
Re_Generate_FixEmissions(){
	cat > /data/V6_SuperCharger/!FixEmissions.sh <<EOF
#!/system/bin/sh
#
# Fix Emissions Script (Fix Permissions) created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/\!FixEmissions.sh
	cat >> /data/V6_SuperCharger/!FixEmissions.sh <<EOF
# Sets permissions for android data directories and apks.
# This should fix app force closes (FCs).
#
# The code is HIGHLY optimized... so it's REALLY FAST! - setting permissions for 300 apps in approximately 1 minute.
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Added BRAINS: Only applies permissions if they are not what they're supposed to be!
#      - Removed the usage of the "pm list packages" command - it didn't work on boot.
#      - Added support for /vendor/app (POST-ICS).
#      - Added support for /mnt/asec.
#      - No longer excludes framework-res.apk or com.htc.resources.apk
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging.
#      - Enhanced logging!
#      - Tweaked interface... just a wittle bit ;^]
#
# Props: Originally and MOSTLY (erm... something like 75% of it lol) by Jared Rummler (JRummy16).
# However, I actually meshed together 3 different Fix Permissions scripts and added my own spices ;^]
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_FixEmissions.log file to see what may have fubarred.
# set -x
# exec > /data/Debug_FixEmissions.log 2>&1
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
# Next line only applies to the init.d boot script. "bootfixemissions=1" means run on boot. Anything else disables it.
bootfixemissions=$fixemissions
bootupdelay="sleep 300"
if [ -t 0 ]; then interactive=yes; fi
title(){
	echo \$line
	echo "   -=Fix Emissions=- script by -=zeppelinrox=-"
	echo \$line
	echo ""
	sleep 2
	echo " Version: $ver"
	echo ""
	sleep 2
	echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
	echo ""
	sleep 2
}
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
Configure(){
	echo " Fix Emissions On Boot..."
	echo " ========================"
	echo ""
	sleep 1
	echo \$line
	echo -n " Status: Fix Emissions "
	if [ "\$bootfixemissions" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo \$line
	echo ""
	sleep 1
	echo " Just check /data/BootLog_FixEmissions.log!"
	echo ""
	sleep 1
	echo " If desired, you can change boot options..."
	echo ""
	sleep 1
	echo "        ...this script is VERY sophisticated..."
	echo ""
	sleep 1
	echo "           ...so boot time would be unaffected!"
	echo ""
	sleep 1
	echo " You can also configure this in Driver Options!"
	echo ""
	sleep 1
	echo \$line
	echo "   Also READ THE COMMENTS inside this script!"
	echo \$line
	echo ""
	sleep 1
	echo " Change Fix Emissions Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo \$line
	case \$changeoptions in
		y|Y)remount rw
			echo ""
			sleep 1
			echo " Run Fix Emissions on boot?"
			echo ""
			sleep 1
			echo " Note: If you say Yes, Fix Alignment On Boot..."
			echo "      ...gets disabled (avoids overlapping mods)"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootfixemissions
			echo ""
			echo \$line
			case \$bootfixemissions in
			  y|Y)fixemissions=1; fixalign=0
				  echo "        Fix Emissions Set To Run On Boot!";;
				*)fixemissions=0
				  echo "          No FCing Fix On Boot For You!";;
			esac
			sed -i '/^bootfixemissions=/s/=.*/='\$fixemissions'/' \$0
			for cfxif in /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc /system/etc/init.d/94fixfc; do
				if [ "\$0" != "\$cfxif" ]; then sed -i '/^bootfixemissions=/s/=.*/='\$fixemissions'/' \$cfxif; fi
			done 2>/dev/null
			if [ "\$fixalign" ]; then
				for ngilaxif in /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign /system/etc/init.d/95fixalign; do
					if [ -f "\$ngilaxif" ]; then sed -i '/^bootfixalign=/s/=.*/='\$fixalign'/' \$ngilaxif; fi
				done
			fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				if [ "\$fixalign" ]; then awk 'BEGIN{OFS=FS=","}{\$16='\$fixemissions',\$17='\$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				else awk 'BEGIN{OFS=FS=","}{\$16='\$fixemissions';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				fi
				mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
			fi
			remount ro;;
		  *)echo "               No Change For You!";;
	esac
	echo \$line
	echo ""
	sleep 1
}
install(){
	remount rw
	for i in /system/etc/init.d/*; do
		if [ -f "\$i" ] && [ "\`echo "\$i" | awk '!/Alignment|Emission|fixfc|fixalign|disabled/'\`" ] && [ "\`awk '/771/&&/packages\.xml|pm list packages/' "\$i"\`" ]; then
			sed -i '1 a\\
#\\
# Fix Emissions (aka "fixfc") script disabled this script for additional optimization.\\
# To Re-Enable this script, delete the fix permissions stuff in here and rename this file.\\
#' "\$i"
			mv "\$i" "\$i.disabled_due_to_slow_fix_permissions-Read_Comment_Inside_For_Fix"
		fi
	done
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo ""
		echo " Installing myself to \${1#*etc}"
		sleep 2
		dd if=\$0 of=\$1
		chown 0.0 \$1; chmod 777 \$1
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " \$1 is already up to date..."
		sleep 2
	fi 2>/dev/null
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " To run, type in Terminal: \"su -c \${1##*/}\""
		sleep 2
	fi
	remount ro
}
Get_PWN (){ PWN=\`busybox stat "\$1" | awk -F [\(\/] '/Uid/{gsub(/ /,"");print \$4,\$6,substr(\$2,2,3)}'\`; }
apply_permissions(){
	if [ "\`echo \$PWN | awk '{print \$1":"\$2}'\`" != "\$1:\$2" ]; then
		echo "    chown \$1:\$2 \$4 ( was \`echo \$PWN | awk '{print \$1":"\$2}'\` )" | tee -a \$LOG_FILE
		chown \$1:\$2 "\$4" 2>&1 | tee -a \$LOG_FILE
	fi
	if [ "\`echo \$PWN | awk '{print \$3}'\`" != "\$3" ]; then
		echo "    chmod \$3 \$4 ( was \`echo \$PWN | awk '{print \$3}'\` )" | tee -a \$LOG_FILE
		chmod \$3 "\$4" 2>&1 | tee -a \$LOG_FILE
	fi
}
Fix_Emissions(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/fixfc; fi
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then echo ""
		if [ "\$bootfixemissions" -ne 1 ]; then
			title
			echo " Current Status: Fix Emissions DOES NOT Run On Boot!"
			echo ""
			echo " But Hey! Init.d Start Up Scripts Are Working!"
			echo ""
			exit 0
		else echo \$bootupdelay | awk '{print " Waiting for "\$NF" seconds..."}'; \$bootupdelay
		fi
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/94fixfc
	fi
	LOG_FILE=/data/Ran_FixEmissions.log
	echo "" | tee \$LOG_FILE
	title | tee -a \$LOG_FILE
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		sleep 1
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		exit 69
	fi
	remount rw
	START=\`date +%s\`
	BEGAN=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	TOTAL=\`grep -c "package name" /d*/system/packages.xml\`
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	echo " Start Fix Emissions: \$BEGAN" >> \$LOG_FILE
	echo "" >> \$LOG_FILE
	echo " Checking Permissions For..." >> \$LOG_FILE
	echo "" >> \$LOG_FILE
	busybox sync
	grep "package name" /d*/system/packages.xml | while read pkgline; do
		ApkFile=\`echo \$pkgline | awk -F \" '{print \$4}'\`
		if [ ! -f "\$ApkFile" ]; then continue; fi
		PROGRESS=\$((PROGRESS+1))
		PERCENT=\$((PROGRESS*100/TOTAL ))
		if [ "\$interactive" ]; then
			if [ "\$PERCENT" -eq "\$INCREMENT" ]; then
				INCREMENT=\$((INCREMENT+3))
				PROGRESS_BAR="\$PROGRESS_BAR="
			fi
			clear
			echo ""
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
			echo "       \"Fix Emissions\" by -=zeppelinrox=-"
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
		fi
		echo ""
		echo "       Processing Apps - \$PERCENT% (\$PROGRESS of \$TOTAL)"
		echo ""
		PkgName=\`echo \$pkgline | awk -F \" '{print \$2}'\`
		ApkDir="\`busybox dirname "\$ApkFile"\`"
		DataDir=/d*/d*/\$PkgName
		PkgID=\`echo \$pkgline | sed 's/.*serId="\|".*//g'\`
		echo " Checking Permissions For..."
		echo ""
		echo " ...\$PkgName"
		echo " \$PkgName (\$ApkFile)" >> \$LOG_FILE
		Get_PWN "\$ApkFile"
		if [ "\$ApkDir" = "/system/framework" ]; then ApkFilePERM="0 0 666"
		elif [ "\$ApkDir" = "/system/app" ] || [ "\$ApkDir" = "/vendor/app" ]; then ApkFilePERM="0 0 644"
		elif [ "\$ApkDir" = /d*/app ]; then ApkFilePERM="1000 1000 644"
		elif [ "\$ApkDir" = /d*/app-private ]; then ApkFilePERM="1000 \$PkgID 640"
		elif [ "\`echo \$ApkDir | grep asec\`" ] && [ "\`mount | awk '/'\$PkgName'/&&!/vfat/'\`" ]; then mount -o remount,rw "\$ApkDir"; ApkFilePERM="1000 \$PkgID 640"
		fi
		if [ "\$ApkFilePERM" ] && [ "\$PWN" != "\$ApkFilePERM" ]; then apply_permissions \$ApkFilePERM "\$ApkFile"; ApkFilePERM=;fi
		if [ -d \$DataDir ]; then Get_PWN \$DataDir; DataDirPERM="\$PkgID \$PkgID 755"
			if [ "\$PWN" != "\$DataDirPERM" ]; then apply_permissions \$DataDirPERM \$DataDir; fi
			busybox find \$DataDir -mindepth 1 -type d | while read SubDir; do Get_PWN "\$SubDir"
				SubDirName=\`busybox basename "\$SubDir"\`
				if [ "\$SubDirName" = "lib" ]; then SubDirPERM="1000 1000 755"; DataFilePERM=\$SubDirPERM
				else SubDirPERM="\$PkgID \$PkgID 771"
					if [ "\$SubDirName" = "shared_prefs" ] && [ "\`echo \$DataDir | grep "robv.*appsettings\|android\.calendar"\`" ]; then DataFilePERM="\$PkgID \$PkgID 664"
					elif [ "\$SubDirName" = "shared_prefs" ] || [ "\$SubDirName" = "databases" ]; then DataFilePERM="\$PkgID \$PkgID 660"
					elif [ "\$SubDirName" = "cache" ]; then DataFilePERM="\$PkgID \$PkgID 600"
					elif [ "\$SubDirName" = "files" ]; then DataFilePERM="\$PkgID \$PkgID 775"
					else DataFilePERM=\$SubDirPERM
					fi
				fi
				if [ "\$PWN" != "\$SubDirPERM" ]; then apply_permissions \$SubDirPERM "\$SubDir"; fi
				busybox find "\$SubDir" -type f -maxdepth 1 | while read DataFile; do Get_PWN "\$DataFile"
					if [ "\$PWN" != "\$DataFilePERM" ]; then apply_permissions \$DataFilePERM "\$DataFile"; fi
				done
			done
		fi
	done
	busybox sync
	remount ro
	STOP=\`date +%s\`
	ENDED=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	RUNTIME=\$((STOP-START))
	HOURS=\$((RUNTIME/3600)); MINS=\$((RUNTIME/60%60)); SECS=\$((RUNTIME%60))
	RUNTIME=\`printf "%d:%02d:%02d\n" \$HOURS \$MINS \$SECS\`
	echo "" | tee -a \$LOG_FILE
	echo \$line | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " FIXED Permissions For ALL \$TOTAL Apps..." | tee -a \$LOG_FILE
	echo ""| tee -a \$LOG_FILE
	sleep 1
	echo "          ...Say Buh Bye To Force Close Errors!"
	echo ""
	echo \$line
	echo ""
	sleep 1
	echo "      Start Time: \$BEGAN" | tee -a \$LOG_FILE
	echo "       Stop Time: \$ENDED" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	echo " Completion Time: \$RUNTIME" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " See \$LOG_FILE for more details!"
	echo ""
	sleep 1
	echo "         ==============================" | tee -a \$LOG_FILE
	echo "          ) Fix Emissions Completed! (" | tee -a \$LOG_FILE
	echo "         ==============================" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	if [ -d "/system/etc/init.d" ] && [ "\$interactive" ]; then Configure; fi
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then Fix_Emissions
else exec > /data/BootLog_FixEmissions.log 2>&1
	Fix_Emissions &
fi
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!FixEmissions.sh; chmod 777 /data/V6_SuperCharger/!FixEmissions.sh
	cp -fr /data/V6_SuperCharger/!FixEmissions.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc
	cp -fr /data/V6_SuperCharger/!FixEmissions.sh $storage/V6_SuperCharger/system/xbin/fixfc
	if [ "$1" ]; then echo " Re-Generating /system/xbin/fixfc..."
		if [ ! -f "/system/xbin/fixfc" ] || [ "`diff /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin fixfc slim
		fi
	fi
	if [ -d "/system/etc/init.d" ]; then
		for i in /system/etc/init.d/*; do
			if [ -f "$i" ] && [ "`echo "$i" | awk '!/Alignment|Emission|fixfc|fixalign|disabled/'`" ] && [ "`awk '/771/&&/packages\.xml|pm list packages/' "$i"`" ]; then
				sed -i '1 a\
#\
# Fix Emissions (aka "fixfc") script disabled this script for additional optimization.\
# To Re-Enable this script, delete the fix permissions stuff in here and rename this file.\
#' "$i"
				mv "$i" "$i.disabled_due_to_slow_fix_permissions-Read_Comment_Inside_For_Fix"
			fi
		done
		cp -frp /data/V6_SuperCharger/!FixEmissions.sh /system/etc/init.d/94fixfc
		cp -fr /data/V6_SuperCharger/!FixEmissions.sh $storage/V6_SuperCharger/system/etc/init.d/94fixfc
		if [ "$1" ]; then echo " Re-Generating /init.d/94fixfc..."
			if [ ! -f "/system/etc/init.d/94fixfc" ] || [ "`diff /data/V6_SuperCharger/!FixEmissions.sh /system/etc/init.d/94fixfc`" ]; then
				checkedspace=yes
				info_free_space_error /etc/init.d 94fixfc slim
			fi
		fi
	fi
}
Re_Generate_FixAlignment(){
	cat > /data/V6_SuperCharger/!FixAlignment.sh <<EOF
#!/system/bin/sh
#
# Fix Alignment Script (ZipAlign AND Fix Permissions) created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/\!FixAlignment.sh
	cat >> /data/V6_SuperCharger/!FixAlignment.sh <<EOF
# Combines my "ZepAlign" / Wheel Alignment Script (ZipAlign) with my Fix Emissions Script (Fix Permissions).
# Due to the combining of tools and enhancements... it's STUPIDLY FAST!
#
  ###############################
 # Wheel Alignment Information #
###############################
# ZipAligns all data, system and asec apks (apps) that have not yet been ZipAligned.
# ZipAlign optimizes all your apps, resulting in less RAM comsumption and a faster device! ;^]
#
# Option 1. By default, this will check and/or zipalign only apks which were recently added and may need it.
# Option 2. Or, when asked, you can force it to zipalign all apks! (Obviously, this takes a bit longer).
#
# The code is HIGHLY optimized... so it's REALLY FAST!
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Added BRAINS: By default, it will only check apks that were added since last run (ie. newer than the log file!)
#      - Added support for /vendor/app (POST-ICS).
#      - Added support for /mnt/asec.
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging.
#      - Enhanced logging!
#      - Tweaked interface... just a wittle bit ;^]
#
# Props: Automatic ZipAlign by Wes Garner (original script)
#        oknowton for the change from MD5 to zipalign -c 4
#
  #############################
 # Fix Emissions Information #
#############################
# Sets permissions for android data directories and apks.
# This should fix app force closes (FCs).
#
# The code is HIGHLY optimized... so it's REALLY FAST! - setting permissions for 300 apps in approximately 1 minute.
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Added BRAINS: Only applies permissions if they are not what they're supposed to be!
#      - Removed the usage of the "pm list packages" command - it didn't work on boot.
#      - Added support for /vendor/app (POST-ICS).
#      - Added support for /mnt/asec.
#      - No longer excludes framework-res.apk or com.htc.resources.apk
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging.
#      - Enhanced logging!
#      - Tweaked interface... just a wittle bit ;^]
#
# Props: Originally and MOSTLY (erm... something like 75% of it lol) by Jared Rummler (JRummy16).
# However, I actually meshed together 3 different Fix Permissions scripts and added my own spices ;^]
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_FixAlign.log file to see what may have fubarred.
# set -x
# exec > /data/Debug_FixAlign.log 2>&1
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
# Next line only applies to the init.d boot script. "bootfixalign=1" means run on boot. Anything else disables it.
bootfixalign=$fixalign
bootupdelay="sleep 180"
if [ -t 0 ]; then interactive=yes; fi
title(){
	echo \$line
	echo "   -=Fix Alignment=- script by -=zeppelinrox=-"
	echo \$line
	echo ""
	sleep 2
	echo " Version: $ver"
	echo ""
	sleep 2
	echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
	echo ""
	sleep 2
}
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
Configure(){
	echo " Fix Alignment On Boot..."
	echo " ========================"
	echo ""
	sleep 1
	echo \$line
	echo -n " Status: Fix Alignment "
	if [ "\$bootfixalign" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo \$line
	echo ""
	sleep 1
	echo " Just check /data/BootLog_FixAlign.log!"
	echo ""
	sleep 1
	echo " If desired, you can change boot options..."
	echo ""
	sleep 1
	echo "        ...this script is VERY sophisticated..."
	echo ""
	sleep 1
	echo "           ...so boot time would be unaffected!"
	echo ""
	sleep 1
	echo " You can also configure this in Driver Options!"
	echo ""
	sleep 1
	echo \$line
	echo "   Also READ THE COMMENTS inside this script!"
	echo \$line
	echo ""
	sleep 1
	echo " Change Fix Alignment Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo \$line
	case \$changeoptions in
		y|Y)remount rw
			echo ""
			sleep 1
			echo " Run Fix Alignment on boot?"
			echo ""
			sleep 1
			echo " Note 1: If you say Yes..."
			echo "         Wheel Alignment and Fix Emissions..."
			echo "         ...On Boot are automatically disabled!"
			echo ""
			sleep 1
			echo " Note 2: If you say No..."
			echo "         Wheel Alignment and Fix Emissions..."
			echo "              ...boot options become available!"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootfixalign
			echo ""
			echo \$line
			case \$bootfixalign in
			  y|Y)fixalign=1; zepalign=0; fixemissions=0
				  echo "        Fix Alignment Set To Run On Boot!";;
				*)fixalign=0
				  echo "   Boot Fix Align Declined... does that rhyme?";;
			esac
			sed -i '/^bootfixalign=/s/=.*/='\$fixalign'/' \$0
			for ngilaxif in /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign /system/etc/init.d/95fixalign; do
				if [ "\$0" != "\$ngilaxif" ]; then sed -i '/^bootfixalign=/s/=.*/='\$fixalign'/' \$ngilaxif; fi
			done 2>/dev/null
			if [ "\$zepalign" ]; then
				for ngilapez in /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign /system/etc/init.d/93zepalign; do
					if [ -f "\$ngilapez" ]; then sed -i '/^bootzepalign=/s/=.*/='\$zepalign'/' \$ngilapez; fi
				done
				for cfxif in /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc /system/etc/init.d/94fixfc; do
					if [ -f "\$cfxif" ]; then sed -i '/^bootfixemissions=/s/=.*/='\$fixemissions'/' \$cfxif; fi
				done
			fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				if [ "\$zepalign" ]; then awk 'BEGIN{OFS=FS=","}{\$15='\$zepalign',\$16='\$fixemissions',\$17='\$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				else awk 'BEGIN{OFS=FS=","}{\$17='\$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				fi
				mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
			fi
			remount ro;;
		  *)echo "               No Change For You!";;
	esac
	echo \$line
	echo ""
	sleep 1
}
install(){
	remount rw
	for i in /system/etc/init.d/*; do
		if [ -f "\$i" ] && [ "\`echo "\$i" | awk '!/Alignment|Emission|zepalign|fixfc|fixalign|disabled/'\`" ] && [ "\`awk '/771/&&/zipalign|packages\.xml|pm list packages/&&!/Re-Enable this script/' "\$i"\`" ]; then
			sed -i '1 a\\
#\\
# Fix Alignment (aka "fixalign") script disabled this script for additional optimization.\\
# To Re-Enable this script, delete the zipalign and/or fix permissions stuff in here and rename this file.\\
#' "\$i"
			mv "\$i" "\$i.disabled_due_to_slow_zipalign_or_fix_permissions-Read_Comment_Inside_For_Fix"
		fi
	done
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo ""
		echo " Installing myself to \${1#*etc}"
		sleep 2
		dd if=\$0 of=\$1
		chown 0.0 \$1; chmod 777 \$1
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " \$1 is already up to date..."
		sleep 2
	fi 2>/dev/null
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo ""
		echo " To run, type in Terminal: \"su -c \${1##*/}\""
		sleep 2
	fi
	remount ro
}
Get_PWN (){ PWN=\`busybox stat "\$1" | awk -F [\(\/] '/Uid/{gsub(/ /,"");print \$4,\$6,substr(\$2,2,3)}'\`; }
apply_permissions(){
	if [ "\`echo \$PWN | awk '{print \$1":"\$2}'\`" != "\$1:\$2" ]; then
		echo "    chown \$1:\$2 \$4 ( was \`echo \$PWN | awk '{print \$1":"\$2}'\` )" | tee -a \$LOG_FILE
		chown \$1:\$2 "\$4" 2>&1 | tee -a \$LOG_FILE
	fi
	if [ "\`echo \$PWN | awk '{print \$3}'\`" != "\$3" ]; then
		echo "    chmod \$3 \$4 ( was \`echo \$PWN | awk '{print \$3}'\` )" | tee -a \$LOG_FILE
		chmod \$3 "\$4" 2>&1 | tee -a \$LOG_FILE
	fi
}
Fix_Align(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/fixalign; fi
	if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then echo ""
		if [ "\$bootfixalign" -ne 1 ]; then
			title
			echo " Current Status: Fix Alignment DOES NOT Run On Boot!"
			echo ""
			echo " But Hey! Init.d Start Up Scripts Are Working!"
			echo ""
			exit 0
		else echo \$bootupdelay | awk '{print " Waiting for "\$NF" seconds..."}'; \$bootupdelay
		fi
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/95fixalign
	fi
	LOG_FILE=/data/Ran_FixAlign.log
	lastran=/data/!FixAlign_Last_Ran.log
	if [ "\`grep "zipaligned" \$LOG_FILE\`" ]; then mv \$LOG_FILE \$lastran; fi 2>/dev/null
	zipalign="yes"
	echo "" | tee \$LOG_FILE
	title | tee -a \$LOG_FILE
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		sleep 1
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		exit 69
	fi
	if [ "easyloglulz" ]; then
		if [ ! "\`which zipalign\`" ]; then
			sleep 1
			echo " Doh... zipalign binary was NOT found..."
			echo ""
			sleep 3
			echo \$line
			echo "                    ...No ZepAligning For You!!"
			echo \$line
			echo ""
			sleep 3
			echo " Load the XDA SuperCharger thread..."
			echo ""
			sleep 3
			echo "   ...and install The SuperCharger Starter Kit!"
			echo ""
			echo \$line
			echo ""
			sleep 3
			LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!SuperCharger.html
			echo ""
			echo \$line
			sleep 3
			if [ ! "\$interactive" ] && [ -f "/data/BootLog_FixAlign.log" ]; then
				echo ""
				LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -d file:///data/BootLog_FixAlign.log -t text/plain
				echo ""
				echo \$line
				sleep 3
			fi
			echo "    So... for now... can ONLY Fix Emissions!"
			echo \$line
			echo ""
			sleep 3
		elif [ -f "\$lastran" ] && [ "\$interactive" ]; then
			echo " ZipAlign ALL Apps or only recently installed?"
			echo ""
			sleep 1
			echo -n " Enter (A)LL, any key for recently added: "
			read how
			echo ""
			case \$how in
				a|A)rm \$lastran;;
				  *);;
			esac
			echo \$line
			echo ""
			sleep 1
		fi
	fi | tee -a \$LOG_FILE
	if [ ! "\`which zipalign\`" ]; then zipalign=; fi
	remount rw
	START=\`date +%s\`
	BEGAN=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	TOTAL=\`grep -c "package name" /d*/system/packages.xml\`
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	NEW=0; ALIGNED=0; ALREADY=0; FAILED=0
	echo " Start Fix Alignment: \$BEGAN" >> \$LOG_FILE
	grep "package name" /d*/system/packages.xml > /data/pkgline.tmp
	busybox sync
	while read pkgline; do
		ApkFile=\`echo \$pkgline | awk -F \" '{print \$4}'\`
		if [ ! -f "\$ApkFile" ]; then continue; fi
		PROGRESS=\$((PROGRESS+1))
		PERCENT=\$((PROGRESS*100/TOTAL ))
		if [ "\$interactive" ]; then
			if [ "\$PERCENT" -eq "\$INCREMENT" ]; then
				INCREMENT=\$((INCREMENT+3))
				PROGRESS_BAR="\$PROGRESS_BAR="
			fi
			clear
			echo ""
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
			echo "       \"Fix Alignment\" by -=zeppelinrox=-"
			echo -n "                                        >"
			echo -e "\r       \$PROGRESS_BAR>"
		fi
		echo ""
		echo "       Processing Apps - \$PERCENT% (\$PROGRESS of \$TOTAL)"
		echo "" | tee -a \$LOG_FILE
		PkgName=\`echo \$pkgline | awk -F \" '{print \$2}'\`
		ApkDir="\`busybox dirname "\$ApkFile"\`"
		DataDir=/d*/d*/\$PkgName
		PkgID=\`echo \$pkgline | sed 's/.*serId="\|".*//g'\`
		echo " Fix Aligning \$PkgName..." | tee -a \$LOG_FILE
		if [ ! -f "\$lastran" ] || [ "\$ApkFile" -nt "\$lastran" ] && [ "\$zipalign" ]; then NEW=\$((NEW+1))
			echo " Checking ZipAlignment..." | tee -a \$LOG_FILE
			zipalign -c 4 "\$ApkFile"
			if [ "\$?" -gt 0 ]; then Get_PWN "\$ApkFile"
				echo "    \$ApkFile needs zipaligning!" | tee -a \$LOG_FILE
				apkzipaligned="\`busybox basename "\$ApkFile"\`"
				zipalign -f 4 "\$ApkFile" "/cache/\$apkzipaligned"
				if [ "\$?" -eq 0 ]; then
					if [ -e "/cache/\$apkzipaligned" ]; then
						echo "    ZipAligning \$ApkFile... SUCCESSFUL!" | tee -a \$LOG_FILE
						if [ "\`echo \$ApkDir | grep asec\`" ]; then mount -o remount,rw "\$ApkDir"; fi
						cp -f "/cache/\$apkzipaligned" "\$ApkFile" | tee -a \$LOG_FILE
						ALIGNED=\$((ALIGNED+1))
						if [ "\`echo \$ApkDir | grep asec\`" ] && [ "\`mount | awk '/'\$PkgName'/&&!/vfat/'\`" ] || [ "\`echo \$ApkDir | awk '!/asec|sdcard/'\`" ]; then
							echo "    Applying same permissions as ORIGINAL file..." | tee -a \$LOG_FILE
							apply_permissions \$PWN "\$ApkFile"
						fi
					else
						echo "    ZipAligning \$ApkFile... Failed (No Output File!)" | tee -a \$LOG_FILE
						FAILED=\$((FAILED+1))
						failedapp=\`echo "\$failedapp, \$apkzipaligned" | sed 's/^, //'\`
					fi
				else echo "    ZipAligning \$ApkFile... Failed (rc: \$rc!)" | tee -a \$LOG_FILE
					FAILED=\$((FAILED+1))
					failedapp=\`echo "\$failedapp, \$apkzipaligned" | sed 's/^, //'\`
				fi
				rm "/cache/\$apkzipaligned" 2>/dev/null
			else
				echo "    ZipAlign not needed for \$ApkFile" | tee -a \$LOG_FILE
				ALREADY=\$((ALREADY+1))
			fi
		fi
		echo " Checking Permissions..." | tee -a \$LOG_FILE
		Get_PWN "\$ApkFile"
		if [ "\$ApkDir" = "/system/framework" ]; then ApkFilePERM="0 0 666"
		elif [ "\$ApkDir" = "/system/app" ] || [ "\$ApkDir" = "/vendor/app" ]; then ApkFilePERM="0 0 644"
		elif [ "\$ApkDir" = /d*/app ]; then ApkFilePERM="1000 1000 644"
		elif [ "\$ApkDir" = /d*/app-private ]; then ApkFilePERM="1000 \$PkgID 640"
		elif [ "\`echo \$ApkDir | grep asec\`" ] && [ "\`mount | awk '/'\$PkgName'/&&!/vfat/'\`" ]; then mount -o remount,rw "\$ApkDir"; ApkFilePERM="1000 \$PkgID 640"
		fi
		if [ "\$ApkFilePERM" ] && [ "\$PWN" != "\$ApkFilePERM" ]; then apply_permissions \$ApkFilePERM "\$ApkFile"; ApkFilePERM=;fi
		if [ -d \$DataDir ]; then Get_PWN \$DataDir; DataDirPERM="\$PkgID \$PkgID 755"
			if [ "\$PWN" != "\$DataDirPERM" ]; then apply_permissions \$DataDirPERM \$DataDir; fi
			busybox find \$DataDir -mindepth 1 -type d | while read SubDir; do Get_PWN "\$SubDir"
				SubDirName=\`busybox basename "\$SubDir"\`
				if [ "\$SubDirName" = "lib" ]; then SubDirPERM="1000 1000 755"; DataFilePERM=\$SubDirPERM
				else SubDirPERM="\$PkgID \$PkgID 771"
					if [ "\$SubDirName" = "shared_prefs" ] && [ "\`echo \$DataDir | grep "robv.*appsettings\|android\.calendar"\`" ]; then DataFilePERM="\$PkgID \$PkgID 664"
					elif [ "\$SubDirName" = "shared_prefs" ] || [ "\$SubDirName" = "databases" ]; then DataFilePERM="\$PkgID \$PkgID 660"
					elif [ "\$SubDirName" = "cache" ]; then DataFilePERM="\$PkgID \$PkgID 600"
					elif [ "\$SubDirName" = "files" ]; then DataFilePERM="\$PkgID \$PkgID 775"
					else DataFilePERM=\$SubDirPERM
					fi
				fi
				if [ "\$PWN" != "\$SubDirPERM" ]; then apply_permissions \$SubDirPERM "\$SubDir"; fi
				busybox find "\$SubDir" -type f -maxdepth 1 | while read DataFile; do Get_PWN "\$DataFile"
					if [ "\$PWN" != "\$DataFilePERM" ]; then apply_permissions \$DataFilePERM "\$DataFile"; fi
				done
			done
		fi
	done < /data/pkgline.tmp
	busybox sync
	rm /data/pkgline.tmp
	rm \$lastran 2>/dev/null
	remount ro
	STOP=\`date +%s\`
	ENDED=\`date | awk '{print \$1,\$2,\$3,\$4}'\`
	RUNTIME=\$((STOP-START))
	HOURS=\$((RUNTIME/3600)); MINS=\$((RUNTIME/60%60)); SECS=\$((RUNTIME%60))
	RUNTIME=\`printf "%d:%02d:%02d\n" \$HOURS \$MINS \$SECS\`
	echo "" | tee -a \$LOG_FILE
	echo \$line | tee -a \$LOG_FILE
	if [ "\$zipalign" ]; then
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " Done \"ZepAligning\" ALL data and system APKs..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " \$NEW	Apps were checked (added since last run)" | tee -a \$LOG_FILE
		echo " \$ALIGNED	Apps were zipaligned" | tee -a \$LOG_FILE
		echo " \$ALREADY	Apps were already zipaligned" | tee -a \$LOG_FILE
		echo " \$FAILED	Apps were NOT zipaligned due to error" | tee -a \$LOG_FILE
		if [ "\$failedapp" ]; then echo "    (\$failedapp)" | tee -a \$LOG_FILE; fi
		echo "" | tee -a \$LOG_FILE
		echo " \$TOTAL	Apps were processed!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo "                ...Say Hello To Optimized Apps!"
		echo ""
		echo \$line | tee -a \$LOG_FILE
	fi
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " FIXED Permissions For ALL \$TOTAL Apps..." | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo "          ...Say Buh Bye To Force Close Errors!"
	echo ""
	echo \$line
	echo ""
	sleep 1
	echo "      Start Time: \$BEGAN" | tee -a \$LOG_FILE
	echo "       Stop Time: \$ENDED" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	echo " Completion Time: \$RUNTIME" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	echo " See \$LOG_FILE for more details!"
	echo ""
	sleep 1
	echo "         ==============================" | tee -a \$LOG_FILE
	echo "          ) Fix Alignment Completed! (" | tee -a \$LOG_FILE
	echo "         ==============================" | tee -a \$LOG_FILE
	echo "" | tee -a \$LOG_FILE
	sleep 1
	if [ -d "/system/etc/init.d" ] && [ "\$interactive" ]; then Configure; fi
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then Fix_Align
else exec > /data/BootLog_FixAlign.log 2>&1
	Fix_Align &
fi
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!FixAlignment.sh; chmod 777 /data/V6_SuperCharger/!FixAlignment.sh
	cp -fr /data/V6_SuperCharger/!FixAlignment.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign
	cp -fr /data/V6_SuperCharger/!FixAlignment.sh $storage/V6_SuperCharger/system/xbin/fixalign
	if [ "$1" ]; then echo " Re-Generating /system/xbin/fixalign..."
		if [ ! -f "/system/xbin/fixalign" ] || [ "`diff /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin fixalign slim
		fi
	fi
	if [ -d "/system/etc/init.d" ]; then
		for i in /system/etc/init.d/*; do
			if [ -f "$i" ] && [ "`echo "$i" | awk '!/Alignment|Emission|zepalign|fixfc|fixalign|disabled/'`" ] && [ "`awk '/771/&&/zipalign|packages\.xml|pm list packages/&&!/Re-Enable this script/' "$i"`" ]; then
				sed -i '1 a\
#\
# Fix Alignment (aka "fixalign") script disabled this script for additional optimization.\
# To Re-Enable this script, delete the zipalign and/or fix permissions stuff in here and rename this file.\
#' "$i"
				mv "$i" "$i.disabled_due_to_slow_zipalign_or_fix_permissions-Read_Comment_Inside_For_Fix"
			fi
		done
		cp -frp /data/V6_SuperCharger/!FixAlignment.sh /system/etc/init.d/95fixalign
		cp -fr /data/V6_SuperCharger/!FixAlignment.sh $storage/V6_SuperCharger/system/etc/init.d/95fixalign
		if [ "$1" ]; then echo " Re-Generating /init.d/95fixalign..."
			if [ ! -f "/system/etc/init.d/95fixalign" ] || [ "`diff /data/V6_SuperCharger/!FixAlignment.sh /system/etc/init.d/95fixalign`" ]; then
				checkedspace=yes
				info_free_space_error /etc/init.d 95fixalign slim
			fi
		fi
	fi
}
Re_Generate_FastEngineFlush(){
	cat > /data/V6_SuperCharger/!FastEngineFlush.sh <<EOF
#!/system/bin/sh
#
# 2 in 1 Engine Flush Script created by -=zeppelinrox=-
# The 2 Modes are: -=Fast Engine Flush=- and -=Engine Flush-O-Matic=-
#
EOF
	terms /data/V6_SuperCharger/\!FastEngineFlush.sh
	cat >> /data/V6_SuperCharger/!FastEngineFlush.sh <<EOF
# See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article which also discusses the "drop system cache" function!
# See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why 'Free RAM' Is NOT Wasted RAM!"
#
# Credit imoseyon for making the drop caches command more well known :)
# See http://www.droidforums.net/forum/liberty-rom-d2/122733-tutorial-sysctl-you-guide-better-preformance-battery-life.html
# Credit dorimanx (Cool XDA dev!) for the neat idea to show before and after stats :D
#
# Usage: 1. Type in Terminal: "su" and enter, "flush" and enter. ("flush" is indentical to !FastEngineFlush.sh but easier to type :p)
#        2. Script Manager: launch it once like any other script OR with a widget (DO NOT PUT IT ON A SCHEDULE!)
#
# Important! Whether you run this with Terminal or Script Manager or widget, the script relaunches and kills itself after the first run.
#            So let it run ONCE, close the app, and "Engine Flush-O-Matic" continues in the background!
#
# Note: To enable "Engine Flush-O-Matic" mode, change the "flushOmaticHours" variable to the number of hours you want.
#       Valid values are from 1 to 24 (hours).
#       Decimal values ARE valid! ie. .1 = 6 minutes, .25 = 15 minutes, 2.5 = 2 hrs and 30 minutes (2.5 hrs duh).
#       If 0, or if the value is invalid or missing, "Engine Flush-O-Matic" mode is disabled.
#       Example: If you want it to run every 4 hours and 30 minutes, make the line read "flushOmaticHours=4.5".
#
# To verify that it's running, just run the script again!
# OR you can type in Terminal:
# 1. "pstree | grep -i flus" - for usage option 1 (with Terminal)
# 2. "pstree | grep sleep" - for usage option 2 (with Script Manager)
# 3. "grep -hi [f]lush /proc/*/cmdline" - Sure-Fire method ;^]
#     The output should be 2 items:
#         a. "/data/V6_SuperCharger/!FastEngineFlush.sh" OR "/system/etc/init.d/96superflush" OR "/system/xbin/flush"(depending on which script ran)
#         b. "Engine Flush-O-Matic is In Effect!" (sleep message)
# 4. "busybox ps | grep -i [f]lus" would give similar results as 3.
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Debug_FastEngineFlush.log file to see what may have fubarred.
# set -x
# exec > /data/Debug_FastEngineFlush.log 2>&1
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
line=================================================
cd "\${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
# To set the next line manually, see comments at the top for instuctions!
flushOmaticHours=$flushOmaticHours
if [ ! "\$flushOmaticHours" ] || [ "\`echo \$flushOmaticHours | awk '/[^\.0-9]/ || \$1>24'\`" ]; then flushOmaticHours=0
else flushOmaticHours=\`echo \$flushOmaticHours | awk '{print \$1*1}'\`
fi
intervalsecs=\`echo \$flushOmaticHours | awk '{printf "sleep %.0f\n", \$1*60*60}'\`
bootupminutedelay=7
bootupdelay="sleep \$((bootupminutedelay*60))"
if [ -t 0 ]; then interactive=yes; fi
if [ "\`busybox ps -w\`" ]; then w=" -w"; fi 2>/dev/null
LOG_FILE=/data/Ran_EngineFlush-O-Matic.log
lastran=/data/!EngineFlush-O-Matic_Last_Ran.log
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
Configure(){
	echo " Engine Flush-O-Matic Options..."
	echo " ==============================="
	echo ""
	sleep 1
	echo " Current Status..."
	echo ""
	sleep 1
	echo \$line
	if [ "\`echo \$flushOmaticHours | awk '\$1>0'\`" ]; then echo " Engine Flush-O-Matic is ON @ \$flushOmaticHours hr intervals!"
	else echo " Engine Flush-O-Matic is Currently OFF!"
	fi
	echo \$line
	echo ""
	sleep 1
	if [ ! "\$FOMactive" ]; then
		echo " If desired, you can change options for..."
		echo ""
		sleep 1
		echo "                       ...Engine Flush-O-Matic!"
		echo ""
		sleep 1
		echo " You can turn it on or off..."
		echo ""
		sleep 1
		echo "        ...or just change how often it runs ;^]"
		echo ""
		sleep 1
		echo \$line
		echo " You can also configure this in Driver Options!"
		echo \$line
		echo ""
		sleep 1
		echo " Note that if enabled, caches are dumped..."
		echo ""
		sleep 1
		echo "                ...only when the screen is off!"
		echo ""
		sleep 1
		echo " This is cuz you don't want your device to..."
		echo ""
		sleep 1
		echo " ...take a big dump and flush..."
		echo ""
		sleep 1
		echo "        ...when you're taking care of business!"
		echo ""
		sleep 1
		if [ -d "/system/etc/init.d" ]; then
			echo " Also note that when it's enabled..."
			echo ""
			sleep 1
			echo \$line
			echo " -=Engine Flush-O-Matic=- on boot is AUTOMAGIC!"
			echo \$line
			echo ""
			sleep 1
			echo " If disabled, it will Flush once after boot up!"
			echo ""
			sleep 1
			echo " Just Check /data/BootLog_FastEngineFlush.log!"
			echo ""
			$sleep
		fi
		echo \$line
		echo "   Also READ THE COMMENTS inside this script!"
		echo \$line
		echo ""
		sleep 1
	fi
	echo " Change Engine Flush-O-Matic Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo \$line
	case \$changeoptions in
	  y|Y)changedopt=yes
		  remount rw
		  echo ""
		  sleep 1
		  echo " Enable Engine Flush-O-Matic?"
		  while :; do
			echo ""
			sleep 1
			echo -n " Enter E to Enable, D to Disable: "
			read able
			echo ""
			echo \$line
			case \$able in
				e|E)echo "       -=Engine Flush-O-Matic=- ENABLED!!"
					echo \$line
					echo ""
					sleep 1
					echo " Note that you CAN enter a decimal value!"
					echo ""
					sleep 1
					echo " ie. \".1\"=6 mins, \".25\"=15 mins, \"2.5\"=2.5 hrs"
					echo ""
					sleep 1
					echo " Low values like .1 MAY benefit Gamers... ? :P"
					echo ""
					sleep 1
					echo " How often do you want it to flush?"
					while :; do
						echo ""
						sleep 1
						echo -n " Enter a value from 1 to 24 (hours): "
						read flushOmaticHours
						echo ""
						echo \$line
						if [ "\$flushOmaticHours" ] && [ "\`echo \$flushOmaticHours | awk '!/[^\.0-9]/ && \$1<=24'\`" ]; then
							flushOmaticHours=\`echo \$flushOmaticHours | awk '{print \$1*1}'\`
							echo " Engine Flush-O-Matic Set To Run Every \$flushOmaticHours Hours!"
							break 2
						fi
						echo "      Invalid entry... Please try again :p"
						echo \$line
					done;;
				d|D)flushOmaticHours=0
					echo "       -=Engine Flush-O-Matic=- DISABLED!!"
					break;;
				  *)echo "      Invalid entry... Please try again :p"
					echo \$line;;
			esac
		  done
		  sed -i '/^flushOmaticHours=/s/=.*/='\$flushOmaticHours'/' \$0
		  for hsulf in /data/V6_SuperCharger/!FastEngineFlush.sh /system/xbin/flush /system/etc/init.d/96superflush; do
			if [ "\$0" != "\$hsulf" ]; then sed -i '/^flushOmaticHours=/s/=.*/='\$flushOmaticHours'/' \$hsulf; fi
		  done 2>/dev/null
		  if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
			awk 'BEGIN{OFS=FS=","}{\$13='\$flushOmaticHours';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
			mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
		  fi
		  remount ro;;
		*)echo "               No Change For You!";;
	esac
	echo \$line
	echo ""
	sleep 1
}
install(){
	if [ ! -f "\$1" ] && [ ! "\`grep \$ver "\$1"\`" ]; then
		echo " Installing myself to \${1#*etc}"
		echo ""
		sleep 2
		remount rw
		dd if=\$0 of=\$1
		chown 0.0 \$1; chmod 777 \$1
		remount ro
	elif [ "\`echo \$1 | grep xbin\`" ]; then
		echo " \$1 is already up to date..."
		echo ""
		sleep 3
	fi 2>/dev/null
	if [ "\`echo \$1 | grep xbin\`" ]; then
		echo " To run, type in Terminal: \"su -c \${1##*/}\""
		echo ""
		sleep 3
	fi
}
Flush_Engine(){
	while [ ! "\`ps | grep -m 1 [a]ndroid\`" ]; do sleep 10; done
	if [ "\`busybox ps\$w | awk '/[F]lush/&&/Effect/'\`" ]; then FOMactive=yes; fi
	echo "" | tee -a \$LOG_FILE
	if [ -d "/system/etc/init.d" ] && [ "\`echo \$0 | grep -v "init\.d"\`" ]; then install /system/etc/init.d/96superflush; fi
	if [ "\`echo \$0 | grep -v xbin\`" ]; then install /system/xbin/flush; fi
	if [ "\`echo \$flushOmaticHours | awk '\$1>0'\`" ]; then
		flushmode="   -=Engine Flush-O-Matic=- by -=zeppelinrox=-"
		echo " Engine Flush-O-Matic is enabled!" >> \$LOG_FILE
		echo "" >> \$LOG_FILE
	else flushmode="    -=Fast Engine Flush=- by -=zeppelinrox=-"
	fi
	echo " \`date | awk '{print \$1,\$2,\$3,\$4}'\`" | tee -a \$LOG_FILE
	echo ""
	animspeed="busybox sleep 0.1"
	if [ -f "/data/FOMbootup" ]; then rm /data/FOMbootup
		echo " Delaying First Flush for \$bootupminutedelay minutes (make sure something stinks lol)" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		\$bootupdelay | grep " Flush On Boot Delay is In Effect!"
	elif [ -f "/data/FOMsleep" ]; then rm /data/FOMsleep
		echo " Now letting stuff build up for \$flushOmaticHours hours... heh." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		\$intervalsecs | grep "Engine Flush-O-Matic is In Effect!"
	elif [ ! "\$FOMactive" ]; then
		clear;sleep 1;echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |   |";echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |   D";echo "              |   |";echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";\$animspeed
		clear;echo "";echo \$line;echo "               ___";echo "              |   D";echo "              |   |";echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;\$animspeed;\$animspeed
		clear;echo "";echo \$line;echo "              |   D";echo "              |   |";echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |   |";echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |   |";echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "              |___|            __";echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                || ________  -( (-";echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                |_(--------)  '-'";echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                   \      /";echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "                    )_.._(";echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "                                         zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "                               zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "                     zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo "           zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo " zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo " zoom...                                zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo " zoom...                     zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo " zoom...           zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";\$animspeed
		clear;echo " zoom... zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
		clear;echo " zOOM... zOOM...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
		clear;echo " zoom... zoom...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
		clear;echo " zOOM... zOOM...";echo \$line;echo "\$flushmode";echo \$line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 1
		clear;
	fi
	mv \$LOG_FILE \$lastran 2>/dev/null
	echo "" > \$LOG_FILE
	if [ "easyloglulz" ]; then
		echo " zOOM... zOOM..."
		echo \$line
		echo "\$flushmode"
		echo \$line
		echo ""
		sleep 1
		echo " Version: $ver"
		echo ""
		sleep 1
		echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
		echo ""
		echo \$line
	fi | tee -a \$LOG_FILE
	id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
	if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo " You are NOT running this script as root..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo \$line | tee -a \$LOG_FILE
		echo "                      ...No SuperUser For You!!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		echo "         ...Please Run as Root and try again..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 3
		exit 69
	elif [ ! "\$interactive" ]; then
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " FOM's waiting 'til Android is asleep..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo "              ...so you can get you're Game On!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo "                            ...Lag 'n Gag Free!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo " So just wait... And HEY! Look at the bird..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " OK! Android's \`cat /sys/power/wait_for_fb_sleep\` so we're good to go..." | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo "         ...without risk of clogging the drain!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
	elif [ "\$FOMactive" ] && [ "\$interactive" ]; then
		echo "          HEY! It's already in memory!" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " Do you want to flush now anyway?" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo " Note: You can't enter another \"Flush Cycle\"!" | tee -a \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		sleep 1
		echo -n " Enter Y for Yes, any key for No: " | tee -a \$LOG_FILE
		read flushnow
		echo \$flushnow >> \$LOG_FILE
		echo "" | tee -a \$LOG_FILE
		echo \$line | tee -a \$LOG_FILE
		case \$flushnow in
		  y|Y)echo " Alrighty Then!" | tee -a \$LOG_FILE
			  echo \$line | tee -a \$LOG_FILE;;
			*)echo " No Flush For You!" | tee -a \$LOG_FILE
			  echo \$line | tee -a \$LOG_FILE
			  echo "" | tee -a \$LOG_FILE
			  sleep 1
			  mv \$lastran \$LOG_FILE | tee -a \$LOG_FILE
			  Configure
			  exit 69;;
		esac
	fi
	if [ "easyloglulz" ]; then
		echo ""
		sleep 1
		rm \$lastran 2>/dev/null
		ram=\$((\`awk '/MemTotal/{print \$2}' /proc/meminfo\`/1024))
		ramfree=\$((\`awk '/^MemFree/{print \$2}' /proc/meminfo\`/1024))
		ramused=\$((ram-ramfree))
		ramcached=\$((\`awk '/^Cached/{print \$2}' /proc/meminfo\`/1024))
		rambuffers=\$((\`awk '/^Buffers/{print \$2}' /proc/meminfo\`/1024))
		rambufferscached=\$((ramcached+rambuffers))
		ramreportedfree=\$((ramfree+ramcached+rambuffers))
		echo " \`date | awk '{print \$1,\$2,\$3,\$4}'\`: Flushing Engine with..."
		echo ""
		sleep 1
		echo " ...\$0!"
		echo ""
		sleep 1
		echo " Note that \"Used RAM\" INCLUDES Cached Apps!!"
		echo ""
		sleep 1
		echo \$line
		echo " RAM Stats BEFORE Engine Flush..."
		echo \$line
		echo ""
		sleep 1
		echo " Total: \$ram MB  Used: \$ramused MB  True Free: \$ramfree MB"
		echo ""
		sleep 1
		echo " Reported Free by most tools: \$ramreportedfree MB Free RAM!"
		echo ""
		sleep 1
		echo \$line
		echo "True Free \$ramfree MB = Free \$ramreportedfree - Buffers/Cached \$rambufferscached"
		echo \$line
		echo ""
		sleep 1
		echo " ...OR...    True Free RAM   \$ramfree"
		echo "               Cached Apps + \$ramcached"
		echo "                   Buffers + \$rambuffers"
		echo "                           ========"
		echo "       Reported \"Free\" RAM = \$ramreportedfree MB"
		echo ""
		sleep 1
		busybox sync;
		echo \$line
		echo -n " Engine Flush In Progress... ";busybox sysctl -w vm.drop_caches=3
		echo \$line
		echo ""
		sleep 3
		busybox sysctl -w vm.drop_caches=1 1>/dev/null
		ramfree2=\$((\`awk '/MemFree/{print \$2}' /proc/meminfo\`/1024))
		ramused2=\$((ram-ramfree2))
		ramcached2=\$((\`awk '/^Cached/{print \$2}' /proc/meminfo\`/1024))
		rambuffers2=\$((\`awk '/^Buffers/{print \$2}' /proc/meminfo\`/1024))
		rambufferscached2=\$((ramcached2+rambuffers2))
		ramreportedfree2=\$((ramfree2+ramcached2+rambuffers2))
		echo \$line
		echo "                ...RAM Stats AFTER Engine Flush"
		echo \$line
		echo ""
		sleep 1
		echo " Total: \$ram MB  Used: \$ramused2 MB  True Free: \$ramfree2 MB"
		echo ""
		sleep 1
		echo " Reported Free by most tools: \$ramreportedfree2 MB Free RAM!"
		echo ""
		sleep 1
		echo \$line
		echo "True Free \$ramfree2 MB = Free \$ramreportedfree2 - Buffers/Cached \$rambufferscached2"
		echo \$line
		echo ""
		sleep 1
		echo " ...OR...    True Free RAM   \$ramfree2"
		echo "               Cached Apps + \$ramcached2"
		echo "                   Buffers + \$rambuffers2"
		echo "                           ========"
		echo "       Reported \"Free\" RAM = \$ramreportedfree2 MB"
		echo ""
		echo \$line
		echo ""
		sleep 1
		echo "    True Free RAM Change =  \$((ramfree2-ramfree)) MB = \$ramfree2 - \$ramfree"
		echo ""
		sleep 1
		echo "   Buffers/Cached Change = \$((rambufferscached2-rambufferscached)) MB = \$rambufferscached2 - \$rambufferscached"
		echo ""
		sleep 1
		echo "Reported Free RAM Change =  \$((ramreportedfree2-ramreportedfree)) MB = \$ramreportedfree2 - \$ramreportedfree"
		echo ""
		sleep 1
		echo \$line
		echo "                  ...Enjoy Your Quick Boost ;^]"
		echo \$line
		echo ""
		sleep 1
		echo " Check out \$LOG_FILE..."
		echo ""
		sleep 1
		echo "                ...for the most recent details!"
		echo ""
		sleep 1
		echo "      ====================================="
		if [ "\`echo \$flushOmaticHours | awk '\$1>0'\`" ]; then echo "       ) Engine Flush-O-Matic Completed! ("
		else echo "       )   Fast Engine Flush Completed!  ("
		fi
		echo "      ====================================="
		echo ""
		sleep 1
	fi | tee -a \$LOG_FILE
	if [ "\$interactive" ]; then Configure; fi
	if [ "\`echo \$flushOmaticHours | awk '!\$1>0'\`" ]; then
		if [ "\`echo \$0 | grep "init\.d"\`" ] && [ ! "\$interactive" ]; then
			echo " And Hey! Init.d Start Up Scripts Are Working!"
			echo ""
		fi
		pkill -9 "Flush|\/flush|superflush"
		exit 0
	elif [ "\$FOMactive" ] || [ "\`busybox ps\$w | awk '/[F]lush/&&/Effect/'\`" ]; then
		echo \$line
		echo " -=Engine Flush-O-Matic=- is already in memory!"
		echo \$line
		echo ""
		sleep 1
		exit 69
	elif [ "\$changedopt" ]; then
		echo " After closing this app you may wonder..."
		echo ""
		sleep 1
		echo " Is -=Engine Flush-O-Matic=- working?"
		echo " ===================================="
		echo ""
		sleep 1
		echo " Check out \$LOG_FILE!"
		echo ""
		sleep 1
		echo " Or... in Terminal Emulator, you can type..."
		echo ""
		sleep 1
		echo " \"pstree | grep -i flus\" OR \"pstree|grep sleep\""
		echo ""
		sleep 1
		echo " OR... get COMPLETE information with..."
		echo ""
		sleep 1
		echo "         ...\"grep -hi [f]lush /proc/*/cmdline\"!"
		echo ""
		sleep 1
		echo " The output should look like this:"
		echo ""
		sleep 1
		echo "   /data/V6_SuperCharger/!FastEngineFlush.sh..."
		echo "   OR /system/etc/init.d/96superflush"
		echo "   OR /system/xbin/flush (just one of them)"
		echo "   Engine Flush-O-Matic is In Effect!"
		echo ""
		sleep 1
		echo " Easier: Similar results can be had with..."
		echo ""
		sleep 1
		echo "               ...\"busybox ps | grep -i [f]lus\""
		echo ""
		sleep 1
		echo " ...OR run this script again...I'll tell ya LOL"
		echo ""
		sleep 1
		echo \$line
		echo " Now executing -=Engine Flush-O-Matic=-..."
		echo \$line
		echo ""
		sleep 1
	fi
	echo \$line
	echo "       Here We Go Again... in \$flushOmaticHours hours LOL"
	echo \$line
	echo ""
	sleep 1
	echo \$line
	echo "         Oh Hey! You can close this App!"
	echo \$line
	echo ""
	sleep 1
	if [ "\`busybox --help | grep nohup\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then echo "cookie!" > /data/FOMsleep; (busybox nohup \$0 > /dev/null &)
	elif [ "\`busybox --help | grep start-stop-daemon\`" ] && [ ! "\`busybox ps\$w | grep "{.*[/]\${0##*/}"\`" ]; then echo "cookie!" > /data/FOMsleep; busybox start-stop-daemon -S -b -x \$0
	else echo "cookie!" > /data/FOMsleep; \$0 > /dev/null & exit 0
	fi
}
if [ "\`ps | grep -m 1 [a]ndroid\`" ]; then Flush_Engine
else exec > /data/BootLog_FastEngineFlush.log 2>&1
	echo "cookie!" > /data/FOMbootup
	rm \$LOG_FILE 2>/dev/null
	Flush_Engine &
fi
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!FastEngineFlush.sh; chmod 777 /data/V6_SuperCharger/!FastEngineFlush.sh
	cp -fr /data/V6_SuperCharger/!FastEngineFlush.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!FastEngineFlush.sh /system/xbin/flush
	cp -fr /data/V6_SuperCharger/!FastEngineFlush.sh $storage/V6_SuperCharger/system/xbin/flush
	if [ "$1" ]; then echo " Re-Generating /system/xbin/flush..."
		if [ ! -f "/system/xbin/flush" ] || [ "`diff /data/V6_SuperCharger/!FastEngineFlush.sh /system/xbin/flush`" ]; then
			checkedspace=yes
			info_free_space_error /system/xbin flush slim
		fi
	fi
	if [ -d "/system/etc/init.d" ]; then
		cp -frp /data/V6_SuperCharger/!FastEngineFlush.sh /system/etc/init.d/96superflush
		cp -fr /data/V6_SuperCharger/!FastEngineFlush.sh $storage/V6_SuperCharger/system/etc/init.d/96superflush
		if [ "$1" ]; then echo " Re-Generating /init.d/96superflush..."
			if [ ! -f "/system/etc/init.d/96superflush" ] || [ "`diff /data/V6_SuperCharger/!FastEngineFlush.sh /system/etc/init.d/96superflush`" ]; then
				checkedspace=yes
				info_free_space_error /etc/init.d 96superflush slim
			fi
		fi
	fi
}
Re_Generate_SuperClean(){
	cat > /data/V6_SuperCharger/!SuperClean.sh <<EOF
#!/system/bin/sh
#
# SuperClean & ReStart Script created by -=zeppelinrox=-
#
EOF
	terms /data/V6_SuperCharger/\!SuperClean.sh
	cat >> /data/V6_SuperCharger/!SuperClean.sh <<EOF
# This will wipe Dalvik Cache plus other temp and/or garbage folders that it finds.
# Note: Logging is uneffected!
# Folders deleted: dalvik-cache
#                  tombstones
#                  LOST.DIR
#                  lost+found
#                  local/tmp
#
# And then it reboots ie. it goes !!POOF!!
#
PATH=\$PATH:/system/xbin:/sbin:/vendor/bin:/system/sbin:/system/bin
if [ -d /data/local/busybox*/xbin ]; then PATH=\$PATH:\`ls -d /data/local/busybox*/xbin 2>/dev/null\`; fi
clear
line=================================================
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
echo ""
echo \$line
echo "  -=SuperClean & ReStart=- by -=zeppelinrox=-"
echo \$line
echo ""
sleep 1
echo " Version: $ver"
echo ""
sleep 1
echo "    Date: \`date | awk '{print \$1,\$2,\$3,\$4}'\`"
echo ""
sleep 1
id=\$(id); id=\${id#*=}; id=\${id%%[\\( ]*}
if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
	sleep 2
	echo " You are NOT running this script as root..."
	echo ""
	sleep 3
	echo \$line
	echo "                      ...No SuperUser For You!!"
	echo \$line
	echo ""
	sleep 3
	echo "         ...Please Run as Root and try again..."
	echo ""
	echo \$line
	echo ""
	sleep 3
	exit 69
fi
remount(){
	mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 /system 2>/dev/null
	busybox mount -o remount,\$1 \$(busybox mount | awk '/ \/system /{print \$1,\$3}') 2>/dev/null
}
remount rw
echo " Commencing SuperClean & ReStart!"
echo ""
sleep 2
for cleanup in dalvik-* tombstones LOST.DIR lost+found local/tmp; do
	if [ -d /*/\$cleanup ]; then
		echo -n " Cleaning " /*/\$cleanup; echo "..."
		sleep 2
		busybox rm -fr /*/\$cleanup/
	fi
done 2>/dev/null
echo " All cleaned up and ready to..."
echo ""
sleep 2
echo \$line
echo "                    !!POOF!!"
echo \$line
echo ""
sleep 2
busybox sync
if [ -f "/proc/sys/kernel/sysrq" ]; then
	echo 1 > /proc/sys/kernel/sysrq 2>/dev/null
	echo b > /proc/sysrq-trigger 2>/dev/null
fi
echo "  If it don't go poofie, just reboot manually!"
echo ""
reboot; busybox reboot
remount ro
echo "          ==========================="
echo "           ) SuperClean Completed! ("
echo "          ==========================="
echo ""
sleep 1
exit 0
EOF
	chown 0.0 /data/V6_SuperCharger/!SuperClean.sh; chmod 777 /data/V6_SuperCharger/!SuperClean.sh
	cp -fr /data/V6_SuperCharger/!SuperClean.sh $storage/V6_SuperCharger/data/V6_SuperCharger
	cp -frp /data/V6_SuperCharger/!SuperClean.sh /system/xbin/sclean
	cp -fr /data/V6_SuperCharger/!SuperClean.sh $storage/V6_SuperCharger/system/xbin/sclean
}
update_options_in_scripts(){
	if [ "$1" = "supercharger" ]; then
		for sc in /data/99SuperCharger.sh /system/xbin/99super /system/etc/init.d/*SuperCharger* /system/etc/hw_config.sh; do
			if [ -f "$sc" ]; then if [ "$initrc" -eq 1 ]; then integrate_initrc $sc; fi
				sed -i 's/^panicmode=.*/panicmode='$panicmode'/
						s/^pyness=.*/pyness='$pyness'/
						s/^deduper=.*/deduper='$deduper'/
						s/^TCE=.*/TCE='$tc3g'/
						s/^sdtweak=.*/sdtweak='$sdtweak'/
						s/^MFK=.*/MFK='$MFK'/
						/diff/,/Integration/d' $sc
			fi
		done 2>/dev/null
	elif [ "$1" = "bulletproof" ]; then
		for bproof in /data/97BulletProof_Apps.sh /system/etc/init.d/*BulletProof_Apps*; do
			if [ -f "$bproof" ]; then sed -i '/^bpwait=/s/=.*/='$bpwait'/' $bproof; fi
		done
	elif [ "$1" = "vac" ]; then
		for cav in /data/V6_SuperCharger/!Detailing.sh /system/xbin/vac /system/etc/init.d/92vac; do
			if [ -f "$cav" ]; then sed -i '/^detailinterval=/s/=.*/='$detailinterval'/' $cav; fi
		done
	elif [ "$1" = "zepalign" ]; then
		for ngilapez in /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign /system/etc/init.d/93zepalign; do
			if [ -f "$ngilapez" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' $ngilapez; fi
		done
	elif [ "$1" = "fixfc" ]; then
		for cfxif in /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc /system/etc/init.d/94fixfc; do
			if [ -f "$cfxif" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' $cfxif; fi
		done
	elif [ "$1" = "fixalign" ]; then
		for ngilaxif in /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign /system/etc/init.d/95fixalign; do
			if [ -f "$ngilaxif" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' $ngilaxif; fi
		done
	elif [ "$1" = "flush" ]; then
		for hsulf in /data/V6_SuperCharger/!FastEngineFlush.sh /system/xbin/flush /system/etc/init.d/96superflush; do
			if [ -f "$hsulf" ]; then sed -i '/^flushOmaticHours=/s/=.*/='$flushOmaticHours'/' $hsulf; fi
		done
	fi
}
update_options(){
	echo "$speed,$buildprop,$animation,$initrc,$launcheradj,$panicmode,$pyness,$deduper,$propaccessories,$tc3g,$sdtweak,$bpwait,$flushOmaticHours,$detailinterval,$zepalign,$fixemissions,$fixalign,$music" > /data/V6_SuperCharger/SuperChargerOptions
	cp -fr /data/V6_SuperCharger/SuperChargerOptions $storage/V6_SuperCharger/data/V6_SuperCharger
}
show_current_options(){
	echo "  Prior Scrolling Speed has been applied - $speed"
	echo $line
	$sleep
	if [ "$preics" ]; then
		echo -n "  Prop file used for SuperCharging - "
		if [ "$buildprop" -eq 0 ]; then echo "LOCAL.PROP"
		else echo "BUILD.PROP"
		fi
		echo $line
		$sleep
		echo -n "  SuperCharged Launcher Option is"
		if [ "$launcheradj" -eq 0 ]; then echo " BulletProof!!"
		elif [ "$launcheradj" -eq 2 ]; then echo " Hard To Kill!"
		else echo "... Die-Hard!!"
		fi
		echo $line
		$sleep
		if [ -d "/system/etc/init.d" ]; then
			echo -n "  System Integration of $initrcpath1 Setting - "
			if [ "$initrc" -eq 1 ]; then
				echo "YES!"
				echo $line
				echo ""
				$sleep
				echo "   Go to Driver Options and DISABLE..."
				echo ""
				$sleep
				echo "         ...if you have root/permission issues!"
			else
				echo "NO!"
				echo $line
				echo ""
				$sleep
				echo "   Go to Driver Options and ENABLE..."
				echo ""
				$sleep
				echo "             ...for greater System Integration!"
			fi
			echo ""
			echo $line
			$sleep
		fi
	fi
	echo -n "  Kernel & Virtual Memory Tweaks"
	if [ "$panicmode" -eq 3 ]; then echo " are Rock Hard!"
	elif [ "$panicmode" -eq 2 ]; then echo " - Rock & Roll!"
	elif [ "$panicmode" -eq 1 ]; then echo " ala Soft Rock!"
	else echo " - Disco Dance!"
	fi
	echo $line
	$sleep
	echo -n "                   Entropy-ness Enlarger - "
	if [ "$pyness" -eq 0 ]; then echo "NO!"
	else echo "YES!"
	fi
	echo $line
	$sleep
	echo -n "                     Super Duper DeDuper - "
	if [ "$deduper" -eq 0 ]; then echo "NO!"
	else echo "YES!"
	fi
	echo $line
	$sleep
	echo -n "        System Property Accessory Tweaks - "
	if [ "$propaccessories" -eq 1 ]; then echo "YES!"
	else echo "NO!"
	fi
	echo $line
	$sleep
	echo -n "  3G TurboCharger Enhancement(3GTC Addon)- "
	if [ "$tc3g" -eq 1 ]; then echo "YES!"
	else echo "NO!"
	fi
	echo $line
	$sleep
	echo -n "                     SD Read Speed Tweak - "
	if [ "$sdtweak" -eq 0 ]; then echo "NO!"
	else echo "$sdtweak"
	fi
	echo $line
	$sleep
	if [ "$bpwait" -gt 0 ]; then echo "      BulletProof Apps - Enabled @ Every - $bpwait"s
	else echo "    BulletProof Apps Script is Currently - OFF!"
	fi
	echo $line
	$sleep
	if [ "`echo $flushOmaticHours | awk '$1>0'`" ]; then echo "  Engine Flush-O-Matic - Enabled @ Every - $flushOmaticHours"hrs
	else echo "  Engine Flush-O-Matic Mode is Currently - OFF!"
	fi
	echo $line
	if [ -d "/system/etc/init.d" ]; then
		$sleep
		echo -n "  Detailing(Clean Database) Runs On Boot - "
		if [ "$detailinterval" -eq 0 ]; then echo "NO!"; echo $line
		else echo "#$detailinterval"
			echo $line
			$sleep
			if [ -f "/system/etc/init.d/92vac" ] && [ "$scranb4boot" ]; then
				if [ -f "/data/BootLog_Detailing.log" ] && [ "/dev/alarm" -nt "/data/BootLog_Detailing.log" ] || [ ! -f "/data/BootLog_Detailing.log" ]; then
					echo "  DOH! /init.d/92vac DIDN'T RUN LAST BOOT!"
					echo $line
				else awk '/ ran /{print " "$0}' /data/Ran_Detailing.log
				fi
			fi
		fi
	fi
	if [ -f "/data/Ran_Detailing.log" ]; then
		$sleep
		awk -F ": " '/Start Time/{print "  Detailing Last Ran: "$2}' /data/Ran_Detailing.log
		echo $line
	fi
	if [ -d "/system/etc/init.d" ]; then
		$sleep
		echo -n "  Wheel Alignment(ZipAlign) Runs On Boot - "
		if [ "$zepalign" -eq 1 ]; then echo "YES!"
			if [ -f "/system/etc/init.d/93zepalign" ] && [ "$scranb4boot" ]; then
				if [ ! -f "/data/BootLog_ZepAlign.log" ] && [ "/dev/alarm" -nt "/data/BootLog_ZepAlign.log" ] || [ ! -f "/data/BootLog_ZepAlign.log" ]; then
					echo $line
					$sleep
					echo "  DOH! /init.d/93zepalign DIDN'T RUN LAST BOOT!"
				fi
			fi
		else echo "NO!"
		fi
		echo $line
	fi
	if [ -f "/data/Ran_ZepAlign.log" ]; then
		$sleep
		awk -F ": " '/Start Time/{print "  Wheel Alignment Last Ran: "$2}' /data/Ran_ZepAlign.log
		echo $line
	fi
	if [ -d "/system/etc/init.d" ]; then
		$sleep
		echo -n "  Fix Emissions (Fixes FCs) Runs On Boot - "
		if [ "$fixemissions" -eq 1 ]; then echo "YES!"
			if [ -f "/system/etc/init.d/94fixfc" ] && [ "$scranb4boot" ]; then
				if [ ! -f "/data/BootLog_FixEmissions.log" ] && [ "/dev/alarm" -nt "/data/BootLog_FixEmissions.log" ] || [ ! -f "/data/BootLog_FixEmissions.log" ]; then
					echo $line
					$sleep
					echo "  DOH! /init.d/94fixfc DIDN'T RUN LAST BOOT!"
				fi
			fi
		else echo "NO!"
		fi
		echo $line
	fi
	if [ -f "/data/Ran_FixEmissions.log" ]; then
		$sleep
		awk -F ": " '/Start Time/{print "  Fix Emissions Last Ran: "$2}' /data/Ran_FixEmissions.log
		echo $line
	fi
	if [ -d "/system/etc/init.d" ]; then
		$sleep
		echo -n "  Fix Alignment (Dual Tool) Runs On Boot - "
		if [ "$fixalign" -eq 1 ]; then echo "YES!"
			if [ -f "/system/etc/init.d/95fixalign" ] && [ "$scranb4boot" ]; then
				if [ ! -f "/data/BootLog_FixAlign.log" ] && [ "/dev/alarm" -nt "/data/BootLog_FixAlign.log" ] || [ ! -f "/data/BootLog_FixAlign.log" ]; then
					echo $line
					$sleep
					echo "  DOH! /init.d/95fixalign DIDN'T RUN LAST BOOT!"
				fi
			fi
		else echo "NO!"
		fi
		echo $line
	fi
	if [ -f "/data/Ran_FixAlign.log" ]; then
		$sleep
		awk -F ": " '/Start Time/{print "  Fix Alignment Last Ran: "$2}' /data/Ran_FixAlign.log
		echo $line
	fi
}
bOOM_Stick(){
	bOOM_Stick_Title_Sequence(){
		if [ "$1" = "zOOM" ]; then
			echo "                     ________  ______  ____  ___"
			echo "_____________________   / __ \  / __ \  /  |/  /"
			echo "________________/_  /  / / / / / / / / / /|_/ /"
			echo "_________________/ /_ / /_/ / / /_/ / / /  / /"
			echo "________________/___/ \____/  \____/ /_/  /_/"
			echo ""
			echo "________________________________________ _______"
			echo "________/ ___/ /_  __/ /  _/ / ____/ / //_/  / /"
			echo "________\__ \   / /    / /  / /     /  <    / /"
			echo "__________/ /  / /   _/ /  / /___  / /| |  /_/"
			echo "______/____/  /_/   /___/  \____/ /_/ |_| (_)"
			echo ""
		elif [ "$1" = "vrOOM" ]; then
			echo "________________________________________________"
			echo "                         __       __     _   _"
			echo "                       /    )   /    )   /  /|"
			echo "               )__    /    /   /    /   /| / |"
			echo "        | /   /   )  /    /   /    /   / |/  |"
			echo "________|/___/______(____/___(____/___/__/___|__"
			echo ""
			echo "________________________________________________"
			echo "         __   ______  __     __     _    _    /"
			echo "       /    )   /     /    /    )   /  ,'    /"
			echo "       \       /     /    /        /_,'     /"
			echo "        \     /     /    /        /  \     /"
			echo "___(____/____/_____/____(____/___/____\___o_____"
			echo ""
		fi | tee /data/!bOOM_Stick_COOKED.log
	}
	Ash(){
		echo ""
		echo " :ttFFyr,"
		echo "      .;10Z8Ft@RF;.             ,     l"
		echo "             .iH8@@@@@@@QE0Wyl.r F   @Qh:i,,,:Y;"
		echo "                      .:lY1B@Q@Q@QLL@Q@Q@@@Q@Q@@"
		echo "                         ,   ,,:, YJ,@@,.vh0R@Q1"
		echo "                    h@@@@Q@         @Q@L"
		echo "                   SQ@Q@@@@@         @Q@"
		echo "                  @Q@Q1   UQW         @@l"
		echo "                  0@Q ..,lFEQ          @@@"
		echo "                  :FL  r, ,             @@@"
		echo "                   ,h    rv             Q@"
		echo "                       ..LrBl  ,     .@Q@:"
		echo "                        ,vl@Q@QB   ,@@Q0"
		echo "                    R  L@Q@Q@@@Q.,hQ@8"
		echo "                   ,@K  :;@@QR@@Q@Q@L"
		echo "                 ,. @Q@M UCHQQFR@Q@@"
		echo "               iv,t0Q@Q@Q@0JR@,0Q@Qr"
		echo "              .L@Cl Q@@Q@FB0ZQZ@@Q@Fl"
		echo "              MEQ0, :@Q@0tQ@R@Q@Q@Q@@:"
		echo "              .@0:   :JQ8Q@Q@@SJ.B@Q@:"
		echo "              i@FL v@@Q@@@QZQ@  F@@@Q."
		echo "              ;Z@QFR@Q@Q@RQQ@.KR@QQ@@"
		echo "              i0Q@QRQYFORZ@@Q  :.FQl"
	}
	bOOM_Stick_End_Credits(){
		echo " Alright you Primitive Screwheads, listen up!"
		echo ""
		$sleep
		echo " You see this? This... is my..."
		echo ""
		$sleep
		if [ "$1" = "zOOM" ]; then
			echo "___________________  ________  ______  ____  ___"
			echo "________________/ /_    / __ \  / __ \  /  |/  /"
			echo "_______________/ __ \  / / / / / / / / / /|_/ /"
			echo "______________/ /_/ / / /_/ / / /_/ / / /  / /"
			echo "_____________/_,___/  \____/  \____/ /_/  /_/"
			Ash
			echo "________________________________________ _______"
			echo "________/ ___/ /_  __/ /  _/ / ____/ / //_/  / /"
			echo "________\__ \   / /    / /  / /     /  <    / /"
			echo "__________/ /  / /   _/ /  / /___  / /| |  /_/"
			echo "______/____/  /_/   /___/  \____/ /_/ |_| (_)"
		elif [ "$1" = "vrOOM" ]; then
			echo "________________________________________________"
			echo "                         __       __     _   _"
			echo "                /      /    )   /    )   /  /|"
			echo "               /__    /    /   /    /   /| / |"
			echo "              /   )  /    /   /    /   / |/  |"
			echo "_____________(___/__(____/___(____/___/__/___|__"
			Ash
			echo "________________________________________________"
			echo "         __   ______  __     __     _    _    /"
			echo "       /    )   /     /    /    )   /  ,'    /"
			echo "       \       /     /    /        /_,'     /"
			echo "        \     /     /    /        /  \     /"
			echo "___(____/____/_____/____(____/___/____\___o_____"
		else
			echo "     __      ____    ____    __  ___"
			echo "    / /_    / __ \  / __ \  /  |/  /"
			echo "   / __ \  / / / / / / / / / /|_/ /"
			echo "  / /_/ / / /_/ / / /_/ / / /  / /"
			echo " /_,___/  \____/  \____/ /_/  /_/"
			Ash
			echo "         _____  ______  ____  ______  __ __   __"
			echo "        / ___/ /_  __/ /  _/ / ____/ / //_/  / /"
			echo "        \__ \   / /    / /  / /     /  <    / /"
			echo "       ___/ /  / /   _/ /  / /___  / /| |  /_/"
			echo "      /____/  /_/   /___/  \____/ /_/ |_| (_)"
		fi
		echo ""
		$sleep
		echo " Too many \"Drive Me Crazy\" with lack of info..."
		echo ""
		$sleep
		echo "          ...so you have 2 versions in /data..."
		echo ""
		$sleep
		echo "                     ...The RAW and the COOKED!"
		echo ""
		$sleep
		echo $line
		echo " Post them with your launcher status questions!"
		echo $line
		echo ""
		$sleep
		echo " FYI, when the launcher is Die-Hard..."
		echo ""
		$sleep
		echo "           ...it's the ONLY process with ADJ 1!"
		echo ""
	}
	bOOM(){
		adj=`echo $psinfo | awk '{print $1}'`; apkname=
		pid=`echo $psinfo | awk '{print $2}'`
		appname=`echo $psinfo | sed 's/'$adj' \|'$pid' //g'`
		if [ "$adj" -eq "$HL" ] && [ "$lname" = "$appname" ]; then
			echo " Home Launcher is on the NEXT line! (ADJ=$HL)"
		fi
		if [ "$boomstick" = "vrOOM" ]; then
			if [ "`echo $appname | awk '!/\//&&/\./{print $1}'`" ]; then
				appnamereal=${appname%:*}
				apkname=`awk -F \" '/package name="'$appnamereal'"/{print $4}' /d*/system/packages.xml`
			fi
		fi
		if [ "$apkname" ]; then printf "%4s %-7s $appname  ($apkname)\n" $adj $pid
		else printf "%4s %-7s $appname\n" $adj $pid
		fi
		if [ "$adj" -eq "$HL" ] && [ "$lname" = "$appname" ]; then echo ""; fi
	}
	rm -f /data/!bOOM_Stick*.tmp
	echo "" | tee /data/!bOOM_Stick_COOKED.log
	bOOM_Stick_Title_Sequence $boomstick
	echo "" > /data/!bOOM_Stick_RAW.log
	echo " ADJ  PID    Process" >> /data/!bOOM_Stick_RAW.log
	echo "" >> /data/!bOOM_Stick_RAW.log
	for i in `busybox ps | awk '!/]/{print $1}'`; do
		if [ -f "/proc/$i/$oom_adj" ]; then
			adj=`cat /proc/$i/$oom_adj 2>/dev/null`
			appname=$(echo `awk '!/grep/' /proc/$i/cmdline`)
			printf "%4s %-7s $appname\n" $adj $i >> /data/!bOOM_Stick_RAW.tmp
			if [ "$adj" -le -1000 ]; then adj=-17
			elif [ "$adj" -ge 1000 ]; then adj=15
			elif [ "${adj#-}" -gt 20 ]; then adj=`echo $adj | awk '{printf "%.0f\n", $1*17/1000}'`
			fi
			echo $adj $i $appname >> /data/!bOOM_Stick.tmp
		fi
	done
	sort -n -k1 -k2 /data/!bOOM_Stick_RAW.tmp >> /data/!bOOM_Stick_RAW.log
	sort -n -k1 -k2 /data/!bOOM_Stick.tmp >> /data/!bOOM_Stick_COOKED.tmp
	if [ "$boomstick" ]; then
		echo "        ================================="
		echo "----=== zeppelinrox's bOOM Stick Verifier ===---"
		echo "        ================================="
		echo ""
		if [ "$boomstick" = "vrOOM" ]; then
			echo " Using vrOOM Stick Mode (Verbose)..."; echo ""
			echo " ADJ  PID    Process/Path        (APK)"
		else
			echo " Using zOOM Stick Mode (Quick)..."; echo ""
			echo " ADJ  PID    Process"
		fi
		echo ""
		echo " FOREGROUND_APP OOM GROUPING"
		echo " ==========================="
		if [ "$HL" -gt -18 ] && [ "$HL" -lt "$oomadj1" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1>-18 && $1<'$oomadj1 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		if [ "$HL" -eq "$oomadj1" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1=='$oomadj1 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		echo ""
		if [ "$scadj" ] && [ "$currentadj" = "$scadj" ] && [ "$oomstick" -eq 1 ] && [ "$HL" -ne "$oomadj1" ]; then
			echo " HOME_LAUNCHER OOM GROUPING!"
			echo " ==========================="
			awk '$1>'$oomadj1' && $1<'$oomadj2 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
			echo ""
			echo " VISIBLE_APP OOM GROUPING"
			echo " ========================"
			awk '$1=='$oomadj2 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		else
			echo " VISIBLE_APP OOM GROUPING"
			echo " ========================"
			if [ "$HL" -gt "$oomadj1" ] && [ "$HL" -le "$oomadj2" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			awk '$1>'$oomadj1' && $1<='$oomadj2 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		fi
		echo ""
		echo " SECONDARY_SERVER OOM GROUPING"
		echo " ============================="
		if [ "$HL" -gt "$oomadj2" ] && [ "$HL" -le "$oomadj3" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1>'$oomadj2' && $1<='$oomadj3 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		echo ""
		echo " HIDDEN_APP OOM GROUPING"
		echo " ======================="
		if [ "$HL" -gt "$oomadj3" ] && [ "$HL" -le "$oomadj4" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1>'$oomadj3' && $1<='$oomadj4 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		echo ""
		echo " CONTENT_PROVIDER OOM GROUPING"
		echo " ============================="
		if [ "$HL" -gt "$oomadj4" ] && [ "$HL" -le "$oomadj5" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1>'$oomadj4' && $1<='$oomadj5 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		echo ""
		echo " EMPTY_APP OOM GROUPING"
		echo " ======================"
		if [ "$HL" -gt "$oomadj5" ] && [ "$HL" -le "$oomadj6" ]; then
			echo ""
			echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
			echo ""
		fi
		awk '$1>'$oomadj5' && $1<='$oomadj6 /data/!bOOM_Stick_COOKED.tmp | while read psinfo; do bOOM; done
		echo ""
		echo $line
		if [ "$boomstick" = "vrOOM" ]; then echo "             vrOOM Stick Complete!"
		else echo "              zOOM Stick Complete!"
		fi
		get_ram_info
		echo ""
		$sleep
	fi | tee -a  /data/!bOOM_Stick_COOKED.log
	if [ "$1" ]; then bOOM_Stick_End_Credits $1; fi
	rm -f /data/!bOOM_Stick*.tmp
}
get_launcher_status echo
if [ "$preics" ] && [ "$HL" -gt "$homeadj" ]; then hijackedadj=$HL
	if [ "$homeadj" -eq "$((FA+1))" ]; then hijackedlname=$lname; fi
elif [ "$servicesjarpatched" ] && [ "$HL" -gt 2 ]; then hijackedadj=$HL
	if [ "$adjs1" -eq 1 ]; then hijackedlname=$lname; fi
fi
if [ "$hijackedlname" ]; then
	for i in `busybox ps | awk '!/]/{print $1}'`; do
		if [ "`awk '$1==1 || $1==58' /proc/$i/$oom_adj`" ]; then
			HL=1
			lname=$(basename `cat /proc/$i/cmdline`)
			break
		fi
	done 2>/dev/null
fi
if [ "$lname" ]; then
	if [ "$hijackedadj" ] && [ ! "$hijackedlname" ]; then echo " $lname is NOT the Home Launcher!"
	else echo " $lname is the Home Launcher!"
	fi
	echo $line
	echo ""
	$sleep
	if [ "$hijackedadj" ]; then
		echo $line
		if [ "$hijackedlname" ]; then
			echo " BUT it may have HIJACKED Home Launcher Status!"
			echo $line
			echo ""
			$sleep
			echo " Since $hijackedlname... "
			echo ""
			$sleep
			echo "                 ...has an ADJ priority of $hijackedadj :P"
			echo ""
		else echo "  Home Launcher Status may have been HIJACKED!"
		fi
		echo $line
		echo ""
		$sleep
	fi
	echo -n " Verify groupings with the bOOM Stick"
	if [ "$lname" = "android.process.acore" ] && [ ! "$diehard" ]; then
		echo "..."
		echo ""
		$sleep
		echo "   ...since launchers often HIDE INSIDE IT..."
		echo ""
		$sleep
		echo "                  ...since I'm not 100% sure :P"
	else echo "!"
	fi
else
	echo ""
	$sleep
	echo " No home launcher detected in memory..."
	echo ""
	$sleep
	echo "      ...so it must have gotten killed already!"
fi
echo ""
echo $line
echo ""
$sleep
echo -n " Press The Enter Key... "
read enter
echo ""
echo $line
if [ "$preics" ] && [ "$lname" = "android.process.acore" ] && [ ! "$diehard" ] || [ ! "$HL" ]; then
	echo ""
	$sleep
	echo " Is Home is \"Locked in Memory\"?"
	echo ""
	$sleep
	echo " If it is, Enter Y for Yes, any key for No..."
	echo ""
	$sleep
	echo -n " Just say \"No\" if you don't know: "
	read homelocked
	echo ""
	case $homelocked in
	  y|Y)HL=$VA
		  echo " WHAT? You need to disable that feature!";;
		*)HL=$homeadj
		  echo " Good Stuff!";;
	esac
	echo ""
	echo $line
fi
get_oomadj_info
MFK_Calculator
if [ ! -f "$storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerAdj" ]; then rookie=yes; fi
if [ ! "$rookie" ] && [ ! "`grep "SuperCharger" /system/build.prop`" ]; then newsupercharger=woohoo
	if [ -f "$initrcpath" ]; then rm $initrcpath; fi
	echo ""
	$sleep
	echo " Oh wait... Did you flash a new ROM or kernel?"
	echo ""
	$sleep
	echo " I Can Automagically..."
	echo ""
	$sleep
	echo $line
	echo "           Run The Re-SuperCharger!!"
	echo $line
	echo ""
	$sleep
	echo " This lets you restore settings and scripts..."
	echo ""
	$sleep
	echo "  ...without overwriting your new system files!"
	echo ""
	$sleep
	echo " You may need to install separately..."
	echo ""
	$sleep
	echo " ...a Launcher, Nitro Lag Nullifier & 3G Turbo."
	echo ""
	echo $line
	echo ""
	$sleep
	echo " Your previous V6 SuperCharger Settings are..."
	echo ""
	$sleep
	awk -F, '{printf "%47s\n", $1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}' $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerMinfree
	echo ""
	$sleep
	echo " Re-SuperCharge from $storage?"
	echo ""
	$sleep
	echo -n " Enter Y for Yes, any key for No: "
	read resuper
	echo ""
	echo $line
	case $resuper in
		y|Y)echo " Re-SuperCharger will Auto Load!"
			if [ "`awk -F, '{print $18}' $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerOptions`" ]; then
				missingoptions=
			fi
			autoresupercharge=indeed; firstgear=;;
		  *)echo " Re-SuperCharging Declined... meh..."
			if [ "$firstgear" ]; then
				echo $line
				echo ""
				$sleep
				echo " Going to load Driver Options instead!"
				echo ""
			fi;;
	esac
	speed=`awk -F, '{print $1}' $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerOptions`
	sleep="sleep $speed"
fi
if [ "$firstgear" ] && [ ! "$newsupercharger" ]; then
	echo "                  Hey Rookie!!"
	echo $line
	echo ""
	$sleep
	echo " First Time SuperChargers..."
	echo ""
	$sleep
	echo "         ...will make a Pit Stop in..."
	echo ""
	$sleep
	echo "                             ...Driver Options!"
	echo ""
elif [ "$missingoptions" ] && [ ! "$firstgear" ]; then
	if [ "$autoresupercharge" ]; then
		echo $line
		echo ""
		$sleep
		echo $line
	fi
	echo "           Missing Some NEW Options!!"
	echo $line
	echo ""
	$sleep
	echo " You need to refresh them so..."
	echo ""
	$sleep
	if [ "$autoresupercharge" ]; then
		echo "    ...Driver Options will be loaded..."
		echo ""
		$sleep
		echo "                    ...Before Re-SuperCharging!"
	else
		echo "         ...will make a Pit Stop in..."
		echo ""
		$sleep
		echo "                             ...Driver Options!"
	fi
	echo ""
elif [ ! "$firstgear" ] && [ ! "$newsupercharger" ]; then
	if [ ! "$crapp" ] && [ "$ram1" -eq "$ram2" ]; then
		remount rw
		if [ "`awk '/ \/system /&&/ro,/' /proc/mounts`" ]; then
			echo ""
			$sleep
			echo " Problem! Can't mount /system as read write..."
			echo ""
			$sleep
			echo " ...skipping Super Smart Script Re-Generator :p"
			echo ""
			echo $line
		else
			script_version_check
			remount ro
		fi
	fi
	show_current_options
	echo ""
	$sleep
	echo " All settings can be changed in Driver Options!"
	echo ""
	$sleep
	echo $line
	echo " Note: You can bake $initrcpath into your ROM!"
fi
echo $line
echo ""
$sleep
if [ -f "/data/!!SuperChargerBootLoopMessage.log" ]; then bootloopdetected=ya
	echo "       DAMMIT... A Boot Loop Was Detected!"
	echo ""
	echo $line
	echo ""
	$sleep
	echo $line
	echo " Do Over! Re-Enabling /init.d/*99SuperCharger..."
	echo $line
	echo ""
	$sleep
	rm /data/!!SuperChargerBootLoopMessage.log
fi
chmod 777 $minfreefile
if [ "$adjfile" ]; then chmod 777 $adjfile; fi
echo -n " Press The Enter Key... And Come Get Some!! "
read getsome
while :; do
 MB0=4;MB1=0;MB2=0;MB3=0;MB4=0;MB5=0;MB6=0
 SL0=0;SL1=0;SL2=0;SL3=0;SL4=0;SL5=0;SL6=0
 scpercent=0;newlauncher=0;showbuildpropopt=0;restore=0;quickcharge=0;calculatorcharge=0;revert=0;ReSuperCharge=0;UnSuperCharged=0;UnSuperChargerError=0;SuperChargerScriptManagerHelp=0;SuperChargerHelp=0;scservice=;bpservice=;slot=;backedup=;HazEgg=
 get_oomadj_info
 for rc in $allrcpaths; do
	if [ -f "$rc.unsuper" ]; then allrcbackups="$allrcbackups $rc.unsuper"; fi
	if [ -f "$rc" ] && [ "`grep "super_service" $rc`" ]; then scservice="scsinstalled"; fi
	if [ -f "$rc" ] && [ "`grep "bullet_service" $rc`" ]; then bpservice="bpsinstalled"; fi
 done
 if [ "$opt" -ne 69 ]; then echo ""; else $sleep; fi
 echo $line
 echo " For Help & Info, see $storagename/!SuperCharger.html"
 echo $line
 $sleep
 get_launcher_status
 echo " \\\\\\\\ T H E  V 6   S U P E R C H A R G E R ////"
 echo "  ============================================"
 echo "        \\\\\\\\ Version: V6U9RC13FYLAG ////"
 echo "         =============================="
 echo "         ||||    ...zOOM ...zOOM   ||||"
 echo "         =============================="
 echo "        ////    Driver's Console    \\\\\\\\"
 echo "  ============================================"
 echo " //// T H E  V 6   S U P E R C H A R G E R \\\\\\\\"
 echo $line
 echo "1. SuperCharger & Launcher Status{Double Check!}"
 echo "                                               }"
 echo "==================== 256 HP ===================="
 echo "2. UnLedded  (Multitasking){8,12,22,24,26,28 MB}"
 echo "3. Ledded        (Balanced){8,12,26,28,30,32 MB}"
 echo "4. Super UL    (Aggressive){8,12,28,30,35,50 MB}"
 echo "                                               }"
 echo "==================== 512 HP ===================="
 echo "5. UnLedded (Multitasking){8,14,40,50,60, 75 MB}"
 echo "6. Ledded       (Balanced){8,14,55,70,85,100 MB}"
 echo "7. Super UL   (Aggressive){8,14,75,90,95,125 MB}"
 echo "                                               }"
 echo "=================== 768+ HP ===================="
 echo "8. Super 768HP(Aggressive){8,16,150,165,180,200}"
 echo "9. Super 1000HP(Agressive){8,16,200,220,240,275}"
 echo "                                               }"
 echo $line
 echo -n "10. Quick V6 Cust-OOMizer "
 if [ "$sccminfree" ]; then echo $sccminfree | awk -F, '{printf "%22s\n", "{"$1/256","$2/256","$3/256","$4/256","$5/256","$6/256"}"}'
 else echo "  {Create Or Restore!}"
 fi
 echo $line
 echo "11. OOM Grouping Fixes + Hard To Kill Launcher }"
 echo "12. OOM Grouping Fixes + Die-Hard Launcher     }"
 echo "13. OOM Grouping Fixes + BulletProof Launcher  }"
 echo $line
 echo "14. UnSuperCharger             {UnDo Everything}"
 echo $line
 echo "                                               }"
 echo $line
 echo "15. The bOOM Stick        {Verify OOM Groupings}"
 echo $line
 echo "                                               }"
 echo "=============== Start Up Scripts ==============="
 echo "16. BulletProof Apps               {Hit or Miss}"
 echo "17. Engine Flush-O-Matic   {ReCoupe RAM Booster}"
 echo "18. Detailing         {Vacuum & Reindex SQL DBs}"
 echo "19. Wheel Alignment              {ZipAlign APKs}"
 echo "20. Fix Emissions             {Fix FCing Errors}"
 echo "21. Fix Alignment           {ZipAlign & Fix FCs}"
 echo "                                               }"
 echo "============== Moar Toolz 'n Stuff ============="
 printf "22. Super DeDuper Snooper %22s\n" "{$KSM Analyzer Tool}"
 echo "23. Nitro Lag Nullifier           {Experimental}"
 echo "24. System Installer            {Terminal Usage}"
 echo "25. Re-SuperCharger        {Restore V6 Settings}"
 echo "26. Super Script Re-Generator     {Force Update}"
 echo "27. Jelly ISCream Parlor  {Install services.jar}"
 echo "                                               }"
 echo "================ Info & Options ================"
 echo "28. PowerShifting         {Switch Presets FAST!}"
 echo "29. Owner's Guide      {Open !SuperCharger.html}"
 echo "30. Help Centre             {Open XDA SC Thread}"
 echo "31. Driver Options                    {Settings}"
 echo "32. SuperCharge You                    {Really!}"
 echo "                                               }"
 echo "================== Finish Line ================="
 echo "33. ReStart Your Engine       {Reboot Instantly}"
 echo "34. SuperClean & ReStart  {Wipe Dalvik & Reboot}"
 echo "35. Eject                     {Or Hit X to Exit}"
 echo $line
 echo " \\\\\\\\      The One and ONLY OOM Fixer!     ////"
 echo "  ============================================"
 if [ -d "/system/etc/init.d" ] && [ "`ls /system/etc/init.d/*SuperCharger*`" ] && [ "$scranb4boot" ] && [ ! "$bootloopdetected" ]; then
	if [ -f "/data/BootLog_SuperCharger.log" ] && [ "/dev/alarm" -nt "/data/BootLog_SuperCharger.log" ] || [ ! -f "/data/BootLog_SuperCharger.log" ]; then
		echo "  /init.d/*99SuperCharger DIDN'T RUN LAST BOOT"
		echo "    This means your init.d support is BORKEN!"
		echo $line
	fi
 fi 2>/dev/null
 if [ "$ran" -eq 0 ] && [ ! "$rookie" ] && [ ! "$autoresupercharge" ]; then
	echo " //// Is it working? READ MESSAGES BELOW!! \\\\\\\\"
	echo $line
	echo " \\\\\\\\  Next 4 Sections Are Worth 25% Each  ////"
	echo "  ============================================"
 fi
 echo ""
 echo -n "   Launcher is"
 if [ "$postics" ] && [ ! "$servicesjarpatched" ]; then echo " NOT Patched.... so.... weak :("; status=4
 elif [ "$usedwebapp" ]; then echo " Patched via WebApp ie. Very Weak!"; status=3
 elif [ "$HL" -gt "$VA" ]; then echo ".... so.... weak.... :("; status=4
 elif [ "$HL" -eq "$VA" ]; then echo " Locked In Memory ie. Very Weak!"; status=3
 else oomstick=1; scpercent=$((scpercent+25))
	if [ "$HL" -eq "$FA" ]; then echo -n " BULLETPROOF ="; status=0
	elif [ "$HL" -eq "$((FA+1))" ]; then echo -n " DIE-HARD! ie."; status=1
	else echo -n " HARD TO KILL="; status=2
	fi
	echo -n " SUPERCHARGED"
	if [ "$ran" -eq 1 ]; then echo "!"
	else echo "!  $scpercent%"
	fi
 fi
 echo ""
 echo $line
 sleep 2
 echo -n "   SuperCharger ADJ Entries "
 if [ "$servicesjarpatched" ]; then ADJs=1; scpercent=$((scpercent+25))
	echo -n "ARE Patched In"
	if [ "$ran" -eq 1 ]; then echo "!"
	else echo "! $scpercent%"
	fi
 elif [ "$postics" ]; then
	echo "ARE NOT Patched In!"
	echo "   Select The \"Jelly ISCream Parlor\" Option!"
 elif [ "`grep "V6 SuperCharger" /system/build.prop`" ]; then ADJs=1; scpercent=$((scpercent+25))
	echo -n "in build.prop"
	if [ "$ran" -eq 1 ]; then echo "!"
	else echo "!  $scpercent%"
	fi
 elif [ -f "/data/local.prop" ] && [ "`grep "V6 SuperCharger" /data/local.prop`" ]; then ADJs=1; scpercent=$((scpercent+25))
	echo -n "in local.prop"
	if [ "$ran" -eq 1 ]; then echo "!"
	else echo "!  $scpercent%"
	fi
 else echo "NOT Found!"
 fi
 echo $line
 if [ "$currentadj" = "$newscadj" ] || [ "$currentadj" = "$oldscadj1" ] || [ "$currentadj" = "$oldscadj2" ] || [ "$currentadj" = "$oldscadj3" ] || [ "$currentadj" = "$oldscadj4" ] || [ "$currentadj" = "$scamadj1" ]; then OOMs=1; scpercent=$((scpercent+25))
	if [ "$currentadj" != "$newscadj" ]; then
		echo ""
		echo "   NON-SuperCharger OOM Grouping In Effect  $scpercent%"
		echo ""
		if [ "$currentadj" = "$scamadj1" ]; then
			echo "         ...and Home Is NOT \"Locked In Memory\"!"
			echo "   If you thought it was, you were mislead..."
			echo ""
			echo "   Apps simply got moved up a slot..."
			echo "     ...so the minfrees become less aggressive!"
			echo ""
			echo $line
			echo "                You Got SCAMMED!"
		fi
		echo $line
	elif [ ! "$scadj" ] && [ "$ran" -eq 0 ]; then echo "   OOM Grouping Fixes ARE In Effect!        $scpercent%"; echo $line
	fi
 elif [ "$currentadj" = "$scamadj2" ]; then
	echo "   Found \"Stockish\" OOM Grouping..."
	echo "             ...which basically does nothing :P"
	echo $line
 fi
 if [ "$ran" -eq 1 ]; then scpercent=$((scpercent+25))
 else
	if  [ "$showparlor" ] || [ "$usedwebapp" ]; then
		echo ""
		echo "   SuperCharged Launcher Is NOT In Effect..."
		if [ "$showparlor" ]; then
			echo "   This ROM WON'T load values from a prop file!"
			echo "   You can do it with a SERVICES.JAR patch..."
			echo "   Just pick the \"Jelly ISCream Parlor\" Option!"
			echo "   Note: Automatic Transmission is OUTDATED!"
		else
			echo "   It was Patched with the OUTDATED WebApp!"
			echo "   Pick the \"Jelly ISCream Parlor\" Option!"
		fi
		echo "           ...See the XDA Thread for more info."
	elif [ "$scadj" ] && [ "$status" -eq 3 ]; then
		echo ""
		echo "   Home Launcher is \"Locked in Memory\"!"
		echo "   You need to DISABLE this shi... feature..."
		echo "          ...In both ROM and Launcher settings!"
	elif [ "$preics" ] && [ "$scadj" ] && [ "$oomstick" -eq 0 ] && [ "$buildprop" -eq 0 ]; then
		echo ""
		echo "   SuperCharged Launcher Is NOT In Effect!"
		echo "   You may need to use the build.prop option..."
		echo "   Select 2 - 13 from the menu NOW to access it!"
		showbuildpropopt=1
	fi
	if [ "$preics" ] && [ "$scadj" ] && [ "$oomstick" -eq 0 ] && [ "$buildprop" -eq 0 ] || [ "$showparlor" ] || [ "$usedwebapp" ]; then echo ""; echo $line; fi
	if [ "$scadj" ]; then echo ""
		if [ "$currentadj" = "$newscadj" ]; then
			echo "   OOM Grouping Fixes ARE In Effect!        $scpercent%"
			echo "   That means the boot script ran!"
		else
			echo "   OOM Grouping Fixes ARE NOT In Effect!"
			echo "   That means the boot script did NOT run..."
			echo "   Select \"Owner's Guide\" on menu for Repairs!"
		fi
		echo ""; echo $line
	else newsupercharger=woohoo
	fi
	if [ "$scminfree" ]; then echo ""
		if [ "$currentminfree" = "$scminfree" ]; then minfrees=1; scpercent=$((scpercent+25))
			echo -n "   Current Values MATCH Prior SuperCharge!"
			if [ "$scpercent" -lt 100 ]; then echo "  $scpercent%"
			else echo " $scpercent%"
			fi
			echo "   That means that it's working! ;)"
		else
			echo "   Current Values DON'T MATCH Prior SuperCharge!"
			if [ -f "/data/Ran_SuperCharger.log" ]; then echo "   Check /data/Ran_SuperCharger for boot info."
			else echo "   The boot script *99SuperCharger did NOT run!"
			fi
			echo "   Select \"Owner's Guide\" on menu for Repairs!"
		fi
	fi
 fi
 if [ ! "$scminfree" ]; then
	echo "   SuperCharger Minfrees NOT FOUND! Run 2 - 10!"
	echo $line
 else echo ""; echo $line
 fi
 echo $currentminfree | awk -F, '{OFMT="%.0f"; print "   Current Minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256" MB"}'
 if [ "$scminfreeold" ]; then echo $scminfreeold | awk -F, '{print "  Prior V6 Minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256" MB"}'; fi
 echo $line
 echo ""
 echo "   You have $ram MB of RAM on your device..."
 if [ "$ram" -lt 256 ]; then echo -n "         ...256 HP"
	calculatedmb="8, 12, $((ram*11/100)), $((ram*12/100)), $((ram*13/100)), $((ram*14/100))"
 elif [ "$ram" -lt 512 ]; then echo -n "         ...512 HP"
	calculatedmb="8, 12, $((ram*11/100)), $((ram*13/100)), $((ram*15/100)), $((ram*17/100))"
 elif [ "$ram" -lt 640 ]; then echo -n "         ...768 HP"
	calculatedmb="8, 14, $((ram*13/100)), $((ram*15/100)), $((ram*17/100)), $((ram*19/100))"
 elif [ "$ram" -lt 768 ]; then echo -n "         ...768 HP"
	calculatedmb="8, 14, $((ram*15/100)), $((ram*17/100)), $((ram*19/100)), $((ram*21/100))"
 elif [ "$ram" -lt 896 ]; then echo -n "         ...1000 HP"
	calculatedmb="8, 14, $((ram*17/100)), $((ram*19/100)), $((ram*21/100)), $((ram*23/100))"
 else echo -n "         ...1000 HP"
	calculatedmb="8, 16, $((ram*20/100)), $((ram*22/100)), $((ram*24/100)), $((ram*26/100))"
 fi
 calculatedminfree=`echo $calculatedmb | awk -F, '{print $1*256","$2*256","$3*256","$4*256","$5*256","$6*256}'`
 calculatedmbnosp=`echo $calculatedminfree | awk -F, '{print $1/256","$2/256","$3/256","$4/256","$5/256","$6/256}'`
 echo " settings are recommended!"
 echo ""
 if [ "$currentminfree" != "$calculatedminfree" ]; then
	echo "          -=SuperMinFree Calculator=- says:"
	echo ""
	echo "   Cust-OOMize with $calculatedmb MB!"
	echo ""
	echo "   Slot 3 Sets Free RAM & Is Your Task Killer!"
	echo ""
 else
	echo " BUT SuperMinFree Calculator Values are set..."
	echo ""
	echo $line
	echo "               SO THAT'S COOL TOO!"
 fi
 echo $line
 if [ "$currentminfree" != "`cat $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerMinfree`" ] && [ "$ran" -eq 0 ]; then
	echo "   Re-SuperCharger Settings on $storagename..."
	echo ""
	awk -F, '{printf "%47s\n", $1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}' $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerMinfree
	echo $line
 fi 2>/dev/null
 if [ "$allrcpaths" ]; then
	echo ""
	echo " STOCK ROMS will benefit most from Services..."
	echo "   ...since those builds have no init.d support!"
	echo ""
	if [ "$scservice" ] || [ "$bpservice" ] || [ ! "$scminfree" ]; then
		echo $line
		echo -n "       SuperCharger Service is "
		if [ "$scservice" ]; then echo "Installed!"
		else echo "NOT Installed!"
		fi
		echo $line
		echo -n "   BulletProof Apps Service is "
		if [ "$bpservice" ]; then echo "Installed!"
		else echo "NOT Installed!"
		fi
	fi
	echo $line
 fi
 if [ ! "`ls /system/etc/init.d/*BulletProof_Apps*`" ] && [ ! -f "/data/97BulletProof_Apps.sh" ]; then echo "    BulletProof Apps Script is NOT Installed!"; echo $line
 elif [ "$bpwait" -eq 0 ]; then echo "    BulletProof Apps Script is NOT Enabled!"; echo $line
 elif [ "`busybox ps$w | awk '/[B]ulletProof/'`" ]; then
	busybox ps$w | awk '/[B]ulletProof/' | while read i; do
		if [ "`echo $i | grep Effect`" ]; then echo "           ${i##*grep }"; echo $line
		elif [ "`echo $i | grep "init\.d"`" ] && [ ! "$bpi" ]; then bpi=ya;  printf "%27s is Running!\n" ${i##*etc}; echo $line
		elif [ "`echo $i | awk '/data/&&!/Ran/'`" ] && [ ! "$bpd" ]; then bpd=ya; echo "/${i##* /} is Running!"; echo $line
		fi
	done
 else echo "    BulletProof Apps Script is ON & NOT in RAM!"; echo $line
	if [ "`ls /system/etc/init.d/*BulletProof_Apps*`" ]; then printf "%27s is NOT Running!\n" /system/etc/init.d/*BulletProof_Apps* | sed 's/.*etc//'; echo $line
	else echo "/data/97BulletProof_Apps.sh is NOT Running!"; echo $line
	fi
 fi 2>/dev/null
 if [ -f "/data/Ran_BulletProof_Apps.log" ]; then
	awk -F ": " '/Date/{print "  Last BulletProof Time was "$2}' /data/Ran_BulletProof_Apps.log | head -n 1
	echo $line
 fi
 if [ ! -f "/system/etc/init.d/96superflush" ] && [ ! -f "/system/xbin/flush" ] && [ ! -f "/data/V6_SuperCharger/!FastEngineFlush.sh" ]; then echo "          Fast Engine Flush is NOT Installed!"; echo $line
 elif [ "`echo $flushOmaticHours | awk '$1==0'`" ]; then echo "       Engine Flush-O-Matic is NOT Enabled!"; echo $line
 elif [ "`busybox ps$w | awk '/lush/&&!/]/'`" ]; then
	busybox ps$w | awk '/lush/&&!/]/' | while read i; do
		if [ "`echo $i | grep Effect`" ]; then echo "       ${i##*grep }"; echo $line
		elif [ "`echo $i | grep "init\.d"`" ] && [ ! "$fli" ]; then fli=ya; echo "   ${i##*system} is Running!"; echo $line
		elif [ "`echo $i | grep xbin`" ] && [ ! "$flx" ]; then flx=ya; echo "         /${i##* /} is Running!"; echo $line
		elif [ "`echo $i | grep Ran`" ] && [ ! "$flR" ]; then flR=ya; awk '/waiting/' /data/Ran_EngineFlush-O-Matic.log; echo $line
		elif [ "`echo $i | grep data`" ] && [ ! "$fld" ]; then fld=ya; echo "        ${i##*/} is Running!"; echo $line
		fi
	done
 else echo "       Engine Flush-O-Matic is ON & NOT in RAM!"; echo $line
	if [ -f "/system/etc/init.d/96superflush" ]; then echo "   /etc/init.d/96superflush is NOT Running!"; echo $line
	elif [ -f "/system/xbin/flush" ]; then echo "         /system/xbin/flush is NOT Running!"; echo $line
	else echo "        !FastEngineFlush.sh is NOT Running!"; echo $line
	fi
 fi 2>/dev/null
 if [ -f "/data/Ran_EngineFlush-O-Matic.log" ] && [ "`busybox ps$w | awk '/lush/&&!/Ran/'`" ]; then
	if [ "`grep "Flushing Engine" /data/Ran_EngineFlush-O-Matic.log`" ]; then awk -F ": " '/Flushing Engine/{print "        Last Flush Time was"$1}' /data/Ran_EngineFlush-O-Matic.log; echo $line
	elif [ "`grep "Date" /data/Ran_EngineFlush-O-Matic.log`" ]; then awk -F ": " '/Date/{print "        Last Flush Time was "$2}' /data/Ran_EngineFlush-O-Matic.log; echo $line
	fi
 fi
 echo -n "        Nitro Lag Nullifier is "
 if [ "`grep Nullifier /system/build.prop`" ]; then echo "Installed!"
 else echo "NOT Installed!"
 fi
 echo $line
 echo -n "          Fentropy enForcer is "
 if [ "$frandomtype" ]; then borkedfentropy=
	for dom in /dev/*random; do
		if [ "$dom" != "/dev/frandom" ] && [ "$dom" != "/dev/erandom" ]; then domtype=`stat $dom | awk '/type/{print $NF}'`
			if [ "$dom" = "/dev/random" ] && [ "$domtype" != "$frandomtype" ]; then borkedfentropy=yes; break
			elif [ "$dom" != "/dev/random" ] && [ "$domtype" != "$erandomtype" ]; then borkedfentropy=yes; break
			fi
		fi
	done
	if [ "$borkedfentropy" ]; then echo "NOT In Effect!"
	else echo "In Effect!"
	fi
 elif [ -f "/system/lib/modules/frandom.ko" ]; then
	echo "CONFUZZLED!"
	echo $line
	echo " The frandom driver was found but is DISABLED!"
	echo " A setting from 2 - 10 will enable it tho ;^]"
 else echo "NOT AVAILABLE!"
 fi
 echo $line
 echo -n "        Super Duper DeDuper is "
 if [ "$ksmdir" ] && [ "$deduper" -ne 0 ]; then
	if [ "`awk '/240|6000/' /sys/kernel/mm/$ksmdir/sleep_millisecs`" ]; then echo "In Effect!"
	else echo "NOT In Effect!"
	fi
 elif [ "$ksmdir" ]; then echo "NOT Enabled!"
 else echo "NOT AVAILABLE!"
 fi
 echo $line
 printf "%28s" "Data DeDuping $KSM "
 if [ "$ksmdir" ] && [ "`cat /sys/kernel/mm/$ksmdir/run`" -eq 1 ]; then
	fullscans=`cat /sys/kernel/mm/$ksmdir/full_scans`
	shared=`cat /sys/kernel/mm/$ksmdir/pages_shared`
	sharing=`cat /sys/kernel/mm/$ksmdir/pages_sharing`
	unshared=`cat /sys/kernel/mm/$ksmdir/pages_unshared`
	if [ "$shared" -ne 0 ]; then
		pool=`echo $shared | awk '{printf "%.02f\n", $1/256}'`
		deduped=`echo $sharing | awk '{printf "%.02f\n", $1/256}'`
		duped=`echo $unshared | awk '{printf "%.02f\n", $1/256}'`
		echo "savings - $deduped MB!"
		echo $line
		echo $sharing $shared $unshared | awk '{printf " %.02f = Benefit/Cost Ratio -> HIGHER IS BETTER!\n", $1*$1/$2/$3}'
		echo $sharing $shared | awk '{printf " %.02f Benefit Ratio x Shared '$pool' MB = '$deduped' MB\n", $1/$2}'
		echo $unshared $sharing | awk '{printf " %.02f Cost Ratio x '$deduped' MB = '$duped' MB (Unique)\n", $1/$2}'
		echo $line
		echo " $fullscans - Full Scans SINCE BOOT - Check Option #22!"
	else echo "is On But No Data!"
	fi
 elif [ "$ksmdir" ]; then echo "is NOT Enabled!"
 else echo "is NOT AVAILABLE!"
 fi
 echo $line
 echo ""
 if [ "$postics" ]; then echo " Lag? Disabling Compcache/zRam May Help!"
 else echo " Lag? Disable Lock Home in Memory & zRam!"
 fi
 echo " Also Run Engine Flush Every Few Hours!"
 echo ""
 if [ "$smrun" ]; then
	echo " In Config, select Run as Root & Browse as Root!"
	echo " But DO NOT run this script at boot!"
	echo ""
	echo " For a quick status check..."
	echo " ...put a V6 SuperCharger WIDGET on the desktop!"
 else
	echo " Optimized for display with Script Manager."
	echo ""
	echo " SM can give you a quick status check..."
	echo " ...Put a V6 SuperCharger WIDGET on the desktop!"
	echo "                                  ...Try it! ;^]"
 fi
 echo ""
 echo $line
 if [ "`cat /proc/sys/kernel/random/entropy_avail`" -gt 1000 ]; then echo " Whoah... Your Entropy-ness is THIS BIG => `cat /proc/sys/kernel/random/entropy_avail`"
 else echo "      Entropy-ness Envy? It is THIS small => `cat /proc/sys/kernel/random/entropy_avail`"
 fi
 get_ram_info
 echo "     SuperCharger Level: $scpercent% SuperCharged!"
 echo $line
 if [ "$scpercent" -eq 0 ] && [ "$rookie" ]; then
	echo " Hey Rookie! SCROLL UP to see the Menu Options!"
	echo $line
 elif [ "$ran" -eq 1 ] && [ "$scpercent" -lt 100 ]; then
	echo " Did it work? READ ABOVE MESSAGES AFTER REBOOT!"
	echo $line
 elif [ "$scpercent" -lt 100 ]; then
	if [ "$ADJs" -eq 0 ]; then
		if [ "$postics" ]; then echo " Lose 25% - services.jar ADJs are NOT Patched In"
		else echo " Lose 25% - build/local.prop ADJs NOT Found"
		fi
	fi
	if [ "$oomstick" -eq 0 ]; then echo " Lose 25% - SuperCharged Launcher NOT In Effect"; fi
	if [ "$OOMs" -eq 0 ]; then echo " Lose 25% - OOM Grouping Fix(adj) NOT In Effect"; fi
	if [ "$minfrees" -eq 0 ]; then echo " Lose 25% - SuperCharger Minfrees NOT In Effect"; fi
	if [ "$usedwebapp" ]; then echo $line; echo "       OUTDATED Web App Patch Is In Effect"; fi
	echo $line
 fi
 $sleep
 if [ ! "$didsomething" ] && [ ! "$missingoptions" ] && [ ! "$newsupercharger" ] && [ "$scminfree" ] && [ "$currentminfree" != "$scminfree" ]; then
	if [ -d "/system/etc/init.d" ] && [ "`ls /system/etc/init.d/*SuperCharger*`" ] || [ ! -d "/system/etc/init.d" ]; then
		echo ""
		echo " Values DON'T MATCH... Read The Owner's Guide!"
		load_help_file
	fi 2>/dev/null
 fi
 echo -n "     Please Enter Option [1 - 35]: "
 if [ "$crapp" ]; then opt=69; echo "Not so fast!"; sleep 4
 elif [ "$firstgear" ] || [ "$missingoptions" ]; then opt=31; echo $opt
 elif [ "$autoresupercharge" ]; then opt=25; echo $opt
 elif [ "$autoshowcalculated" ] && [ "$currentminfree" != "$calculatedminfree" ]; then opt=10; echo $opt
 elif [ "$postics" ] && [ "$scadj" ] && [ "$showparlor" ] && [ ! "$showedparlor" ]; then opt=27; echo $opt
 elif [ "$ADJs" -eq 0 ] || [ "$oomstick" -eq 0 ] && [ ! "$showedboomstick" ] && [ ! "$showedparlor" ]; then opt=1; echo $opt
 else read opt
 fi
 if [ "$opt" = "X" ] || [ "$opt" = "x" ]; then opt=35; fi
 $sleep
 echo $line
 echo "            \\\\\\\\ V6 SUPERCHARGER ////"
 echo "             ======================="
 echo ""
 $sleep
 if [ "$opt" -ge 1 ] && [ "$opt" -le 31 ] || [ "$opt" -eq 34 ] || [ "$crapp" ]; then didsomething=yes
	remount rw
	if [ -d "/sqlite_stmt_journals" ]; then madesqlitefolder=0
	else mkdir /sqlite_stmt_journals; madesqlitefolder=1
	fi
	if [ "$opt" -ne 1 ] && [ "$opt" -ne 14 ] && [ "$opt" -ne 15 ] && [ "$opt" -ne 22 ] && [ "$opt" -le 28 ] && [ ! "$crapp" ]; then
		if [ ! "`grep "SuperCharger Installation" /system/build.prop`" ]; then echo "# SuperCharger Installation Marker." >> /system/build.prop; fi
		mkdir /data/V6_SuperCharger/PowerShift_Scripts 2>/dev/null
		mkdir /data/V6_SuperCharger/BulletProof_One_Shots 2>/dev/null
	fi
 fi 2>/dev/null
 case $opt in
  1) echo "      V6 SUPERCHARGER AND LAUNCHER STATUS!";;
  2) if [ "$preics" ]; then echo "            256HP UNLEDDED MINFREES +"
	 else echo "        256HP UNLEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="256HP UnLedd"
	 MB1=8;MB2=12;MB3=22;MB4=24;MB5=26;MB6=28;;
  3) if [ "$preics" ]; then echo "             256HP LEDDED MINFREES +"
	 else echo "         256HP LEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="256HP Ledded"
	 MB1=8;MB2=12;MB3=26;MB4=28;MB5=30;MB6=32;;
  4) if [ "$preics" ]; then echo "         256HP SUPER UNLEDDED MINFREES +"
	 else echo "     256HP SUPER UNLEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="256HP Super"
	 MB1=8;MB2=12;MB3=28;MB4=30;MB5=35;MB6=50;;
  5) if [ "$preics" ]; then echo "            512HP UNLEDDED MINFREES +"
	 else echo "        512HP UNLEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="512HP UnLedd"
	 MB1=8;MB2=14;MB3=40;MB4=50;MB5=60;MB6=75;;
  6) if [ "$preics" ]; then echo "             512HP LEDDED MINFREES +"
	 else echo "         512HP LEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="512HP Ledded"
	 MB1=8;MB2=14;MB3=55;MB4=70;MB5=85;MB6=100;;
  7) if [ "$preics" ]; then echo "         512HP SUPER UNLEDDED MINFREES +"
	 else echo "     512HP SUPER UNLEDDED MINFREES SELECTED!"
	 fi
	 CONFIG="512HP Super"
	 MB1=8;MB2=14;MB3=75;MB4=90;MB5=95;MB6=125;;
  8) if [ "$preics" ]; then echo "         768HP SUPER UNLEDDED MINFREES +"
	 else echo "     768HP SUPER UNLEDDED MINFREES SELECTED!"
	 fi
	 if [ "$ram" -le 256 ]; then opt=28
		echo $line
		$sleep
		echo "      WHOA! There's NOT Enough RAM! lulz!"
	 else
		CONFIG="768HP Super"
		MB1=8;MB2=16;MB3=150;MB4=165;MB5=180;MB6=200
	 fi;;
  9) if [ "$preics" ]; then echo "         1000HP SUPER UNLEDDED MINFREES +"
	 else echo "     1000HP SUPER UNLEDDED MINFREES SELECTED!"
	 fi
	 if [ "$ram" -le 256 ]; then opt=28
		echo $line
		$sleep
		echo "      WHOA! There's NOT Enough RAM! lulz!"
	 else
		CONFIG="1000HP Super"
		MB1=8;MB2=16;MB3=200;MB4=220;MB5=240;MB6=275
	 fi;;
  10)if [ "$preics" ]; then echo "             CUST-OOMIZER MINFREES +"
	 else echo "         CUST-OOMIZER MINFREES SELECTED!"
	 fi
	 CONFIG="Cust-OOMized"
	 echo $line
	 echo ""
	 $sleep
	 echo " Your Current Minfree values are..."
	 echo ""
	 $sleep
	 echo $currentminfree | awk -F, '{OFMT="%.0f"; print "               "$1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}'
	 echo ""
	 $sleep
	 echo " Your SuperMinFree Calculator values are..."
	 echo ""
	 $sleep
	 echo "               $calculatedmb MB"
	 echo ""
	 if [ "$sccminfree" ]; then
		$sleep
		echo " Your Prior Cust-OOMizer values are..."
		echo ""
		$sleep
		echo $sccminfree | awk -F, '{print "               "$1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}'
		echo ""
	 fi
	 if [ "$scminfreeold" ] && [ "$currentminfree" != "$scminfreeold" ]; then
		$sleep
		echo " Your Prior V6 Minfrees are..."
		echo ""
		$sleep
		echo $scminfreeold | awk -F, '{print "               "$1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}'
		echo ""
	 fi
	 echo $line
	 if [ "$sccminfree" ] && [ "$currentminfree" != "$sccminfree" ] && [ "$calculatedminfree" != "$sccminfree" ] && [ ! "$autoshowcalculated" ]; then
		echo ""
		$sleep
		echo " Restore Previous Cust-OOMizer Settings?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read crestore
		echo ""
		echo $line
		case $crestore in
		  y|Y)restore=1
			  MB1=`echo $sccminfree | awk -F, '{print $1/256}'`;MB2=`echo $sccminfree | awk -F, '{print $2/256}'`;MB3=`echo $sccminfree | awk -F, '{print $3/256}'`;MB4=`echo $sccminfree | awk -F, '{print $4/256}'`;MB5=`echo $sccminfree | awk -F, '{print $5/256}'`;MB6=`echo $sccminfree | awk -F, '{print $6/256}'`
			  echo "    Cust-OOMizer Settings will be Restored!";;
			*);;
		esac
	 fi
	 if [ "$currentminfree" != "$calculatedminfree" ] && [ "$calculatedminfree" != "$scminfree" ] && [ "$restore" -eq 0 ]; then
		echo ""
		$sleep
		echo " Apply SuperMinFree Calculator Settings?"
		echo ""
		$sleep
		if [ "$autoshowcalculated" ]; then echo " If not, come back later for more options!"
		else echo " If not, there are still more options ahead!"
		fi
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read calculated
		echo ""
		echo $line
		case $calculated in
		  y|Y)calculatorcharge=1
			  CONFIG="Calculator"
			  MB1=`echo $calculatedmbnosp | awk -F, '{print $1}'`;MB2=`echo $calculatedmbnosp | awk -F, '{print $2}'`;MB3=`echo $calculatedmbnosp | awk -F, '{print $3}'`;MB4=`echo $calculatedmbnosp | awk -F, '{print $4}'`;MB5=`echo $calculatedmbnosp | awk -F, '{print $5}'`;MB6=`echo $calculatedmbnosp | awk -F, '{print $6}'`
			  echo "  Cust-OOMizing with SuperMinFree Calculator!";;
			*)if [ "$autoshowcalculated" ]; then echo " Well... I tried to do you a favour... sheesh!"; fi;;
		esac
	 fi 2>/dev/null
	 if [ "$scminfreeold" ] && [ "$currentminfree" != "$scminfreeold" ] && [ "$sccminfree" != "$scminfreeold" ] && [ "$calculatedminfree" != "$scminfreeold" ] && [ "$restore" -eq 0 ] && [ "$calculatorcharge" -eq 0 ] && [ ! "$autoshowcalculated" ]; then
		echo ""
		$sleep
		echo " Revert to Prior V6 Minfrees?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read prior
		echo ""
		echo $line
		case $prior in
		  y|Y)revert=1
			  MB1=`echo $scminfreeold | awk -F, '{print $1/256}'`;MB2=`echo $scminfreeold | awk -F, '{print $2/256}'`;MB3=`echo $scminfreeold | awk -F, '{print $3/256}'`;MB4=`echo $scminfreeold | awk -F, '{print $4/256}'`;MB5=`echo $scminfreeold | awk -F, '{print $5/256}'`;MB6=`echo $scminfreeold | awk -F, '{print $6/256}'`
			  echo "      Prior V6 Minfrees will be Restored!";;
			*);;
		esac
	 fi 2>/dev/null
	 if [ "$currentminfree" != "$sccminfree" ] && [ "$currentminfree" != "$scminfree" ] && [ "$restore" -eq 0 ] && [ "$calculatorcharge" -eq 0 ] && [ "$revert" -eq 0 ] && [ ! "$autoshowcalculated" ]; then
		echo ""
		$sleep
		echo " Apply Quick SuperCharge of Current Minfrees?"
		echo ""
		$sleep
		echo " If Yes, these become your Cust-OOMizer values."
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read quick
		echo ""
		echo $line
		case $quick in
		  y|Y)quickcharge=1
			  MB1=`echo $currentminfree | awk -F, '{printf "%.0f\n", $1/256}'`;MB2=`echo $currentminfree | awk -F, '{printf "%.0f\n", $2/256}'`;MB3=`echo $currentminfree | awk -F, '{printf "%.0f\n", $3/256}'`;MB4=`echo $currentminfree | awk -F, '{printf "%.0f\n", $4/256}'`;MB5=`echo $currentminfree | awk -F, '{printf "%.0f\n", $5/256}'`;MB6=`echo $currentminfree | awk -F, '{printf "%.0f\n", $6/256}'`
			  echo "   Quick Cust-OOMizer Settings will be Saved!";;
			*);;
		esac
	 fi 2>/dev/null
	 if [ "$restore" -eq 0 ] && [ "$calculatorcharge" -eq 0 ] && [ "$quickcharge" -eq 0 ] && [ "$revert" -eq 0 ] && [ ! "$autoshowcalculated" ]; then
		echo " Running Cust-OOMizer..."
		echo $line
		$sleep
		echo "            \\\\\\\\ V6 CUST-OOMIZER ////"
		echo "             ======================="
		echo ""
		$sleep
		echo " Enter your desired lowmemorykiller OOM levels!"
		echo ""
		$sleep
		echo " Slot 3 determines your free RAM the most!!"
		echo ""
		$sleep
		echo " Each value MUST be greater than the prior one!"
		echo ""
		$sleep
		echo " Note: Enter \"X\" to Exit at any time ;^]"
		echo ""
		echo $line
		echo ""
		$sleep
		while :; do
			while :; do
				echo -n "               Slot 1: "; read MB1
				if [ "$MB1" = "X" ] || [ "$MB1" = "x" ]; then break 2
				elif [ "$MB1" -gt 0 ]; then break
				fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
			while :; do
				echo -n "                 Slot 2: "; read MB2
				if [ "$MB2" = "X" ] || [ "$MB2" = "x" ]; then break 2
				elif [ "$MB2" -gt "$MB1" ]; then break
				fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
			while :; do
				echo -n "                   Slot 3: "; read MB3
				if [ "$MB3" = "X" ] || [ "$MB3" = "x" ]; then break 2
				elif [ "$MB3" -gt "$MB2" ]; then break
				fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
			while :; do
				echo -n "                     Slot 4: "; read MB4
				if [ "$MB4" = "X" ] || [ "$MB4" = "x" ]; then break 2
				elif [ "$MB4" -gt "$MB3" ]; then break
				fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
			while :; do
				echo -n "                       Slot 5: "; read MB5
				if [ "$MB5" = "X" ] || [ "$MB5" = "x" ]; then break 2
				elif [ "$MB5" -gt "$MB4" ]; then break
				fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
			while :; do
				echo -n "                         Slot 6: "; read MB6
				if [ "$MB6" = "X" ] || [ "$MB6" = "x" ] || [ "$MB6" -gt "$MB5" ]; then break 2; fi
				echo " Input Error!                      Try again :p"; sleep 2
			done
		done 2>/dev/null
		echo ""
		if [ "$MB6" -gt 0 ]; then
			$sleep
			echo $line
			echo " CONFIRM! $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB?"
			echo $line
			echo ""
			$sleep
			echo -n " Enter N for No, any key for Yes: "
			read custOOM
			echo ""
			case $custOOM in
			  n|N)opt=28;;
				*)echo $line
				  echo "        Cust-OOMizer Settings Accepted!";;
			esac
		fi
	 fi
	 if [ "$MB6" -eq 0 ]; then opt=28; fi
	 autoshowcalculated=;;
  11)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                      ...HARD TO KILL LAUNCHER!"
	 $sleep
	 echo $line
	 echo "   This Launcher Is Strong BUT Still Killable"
	 echo $line
	 echo ""
	 $sleep
	 if [ "$gb" -eq 1 ]; then launcheradj=2
		update_options
		echo $line
		echo "             Driver Options Updated!"
	 else
		if [ "$postics" ]; then info_ADJs_no_worky
			if [ "$servicesjarpatched" ]; then
				echo " Hey your services.jar is already patched..."
				echo ""
				$sleep
				echo "             ...with a Hard To Kill Launcher..."
				echo ""
				$sleep
					if [ "$HL" -eq 2 ]; then echo "                               ...so who cares!"
					else echo "  See The \"Jelly ISCream Parlor\" to change it!"
					fi
			else echo " Select The \"Jelly ISCream Parlor\" Option Next!"
			fi
		else opt=28
			echo " Sorry, Hard To Kill Launcher..."
			echo ""
			$sleep
			echo "             ...is not available on this ROM..."
			echo ""
		fi
	 fi;;
  12)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                          ...DIE-HARD LAUNCHER!"
	 $sleep
	 echo $line
	 echo "   This Launcher Is Stronger and RECOMMENDED!"
	 echo $line
	 echo ""
	 $sleep
	 if [ "$postics" ]; then info_ADJs_no_worky
		if [ "$servicesjarpatched" ]; then
			echo " Hey your services.jar is already patched..."
			echo ""
			$sleep
			echo "                 ...with a Die-Hard Launcher..."
			echo ""
			$sleep
				if [ "$HL" -eq 1 ]; then echo "                               ...so who cares!"
				else echo "  See The \"Jelly ISCream Parlor\" to change it!"
				fi
		else echo " Select The \"Jelly ISCream Parlor\" Option Next!"
		fi
	 else launcheradj=1
		update_options
		echo $line
		echo "             Driver Options Updated!"
	 fi;;
  13)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                       ...BULLETPROOF LAUNCHER!"
	 $sleep
	 echo $line
	 echo "   This Launcher Is Strongest and UNKILLABLE!"
	 echo $line
	 echo ""
	 $sleep
	 if [ "$postics" ]; then info_ADJs_no_worky
		if [ "$servicesjarpatched" ]; then
			echo " Hey your services.jar is already patched..."
			echo ""
			$sleep
			echo "              ...with a BulletProof Launcher..."
			echo ""
			$sleep
				if [ "$HL" -eq 0 ]; then echo "                               ...so who cares!"
				else echo "  See The \"Jelly ISCream Parlor\" to change it!"
				fi
		else echo " Select The \"Jelly ISCream Parlor\" Option Next!"
		fi
	 else info_launcher_warning
		echo $line
		echo ""
		$sleep
		echo -n " BulletProof? Enter Y for Yes, any key for No:"
		read breakback
		echo ""
		echo $line
		case $breakback in
		  y|Y)launcheradj=0
			  update_options
			  echo "             Driver Options Updated!"
			  echo $line
			  echo ""
			  $sleep
			  echo $line
			  echo "  Break Back Button... erm... BulletProofing!";;
			*)echo "    OK... Die-Hard Launcher Is Great Anyway!"
			  opt=28;;
		esac
	 fi;;
  14)echo "             ======================="
	 echo "            //// UN-SUPERCHARGER \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo -n "         :|"
	 sleep 3
	 echo -n "    !@#?&%(*)(*)&(!)?!"
	 sleep 3
	 echo "    :/"
	 sleep 3
	 echo ""
	 echo $line
	 echo ""
	 echo " WHAT? UnSuperCharge? Are you sure?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read unsuper
	 echo ""
	 echo $line
	 case $unsuper in
		y|Y)echo " Well... okay then... be like that! :p";;
		  *)echo " False alarm... *whew*"
			opt=28;;
	 esac;;
  15)echo "            ======================="
	 echo "           //// THE bOOM STICK! \\\\\\\\";;
  16)echo "            ========================"
	 echo "           //// BULLETPROOF APPS \\\\\\\\";;
  17)if [ "`echo $flushOmaticHours | awk '$1>0'`" ]; then
		flushmodebar="        ================================"
		flushmode="       //// -=ENGINE FLUSH-O-MATIC=- \\\\\\\\"
	 else
		flushmodebar="          ============================="
		flushmode="         //// -=FAST ENGINE FLUSH=- \\\\\\\\"
	 fi
	 animspeed="busybox sleep 0.1"
	 clear;sleep 1;echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "             =======================";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   |";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   D";echo "               |   |";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                ___";echo "               |   D";echo "               |   |";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;$animspeed; $animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   D";echo "               |   |";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   |";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |   |";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "               |___|            __";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                 || ________  -( (-";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                 |_(--------)  '-'";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                    \      /";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "                     )_.._(";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "";echo "";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "                                          =======";echo "                                         zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "                               ==================";echo "                               zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "                     ============================";echo "                     zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo "           ======================================";echo "           zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo $line;echo " zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo $line;echo " zoom...                                zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo $line;echo " zoom...                     zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo $line;echo " zoom...           zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";$animspeed
	 clear;echo $line;echo " zoom... zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
	 clear;echo $line;echo " zOOM... zOOM...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
	 clear;echo $line;echo " zoom... zoom...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 0.5
	 clear;echo $line;echo " zOOM... zOOM...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";echo $line;echo "";echo "";echo "";echo "";echo "";echo "";echo "";echo "";busybox sleep 1
	 clear;echo $line;echo " zOOM... zOOM...";echo $line;echo "            \\\\\\\\ V6 SUPERCHARGER ////";echo "             =======================";echo "";echo "$flushmodebar";echo "$flushmode";;
  18)echo "                ================="
	 echo "               //// DETAILING \\\\\\\\";;
  19)echo "             ======================="
	 echo "            //// WHEEL ALIGNMENT \\\\\\\\";;
  20)echo "              ====================="
	 echo "             //// FIX EMISSIONS \\\\\\\\";;
  21)echo "              ====================="
	 echo "             //// FIX ALIGNMENT \\\\\\\\";;
  22)echo "        ================================="
	 echo "       //// -=SUPER DeDUPER SNOOPER=- \\\\\\\\";;
  23)echo "           ==========================="
	 echo "          //// NITRO LAG NULLIFIER \\\\\\\\";;
  24)echo "             ======================"
	 echo "            //// SYSTEM INSTALL \\\\\\\\";;
  25)echo "             ======================="
	 echo "            //// RE-SUPERCHARGER \\\\\\\\";;
  26)echo "        ================================="
	 echo "       //// SUPER SCRIPT RE-GENERATOR \\\\\\\\";;
  27)echo "          ============================"
	 echo "         //// JELLY ISCREAM PARLOR \\\\\\\\"
	 if [ "$preics" ]; then opt=28
		echo $line
		echo ""
		$sleep
		echo "        FAIL: This is a PRE-ICS ROM! lol"
		echo ""
	 fi;;
  28)echo "              ====================="
	 echo "             //// POWERSHIFTING \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Now you can quickly switch minfree settings!"
	 echo ""
	 $sleep
	 echo " When you run a preset or the Cust-OOMizer..."
	 echo ""
	 $sleep
	 echo " ...a PowerShift Script is automatically saved!"
	 echo ""
	 echo $line
	 $sleep
	 echo " You can find them in the folder..."
	 echo ""
	 $sleep
	 echo "  .../data/V6_SuperCharger/PowerShift_Scripts :D"
	 echo $line
	 echo ""
	 $sleep
	 echo " Create \"Quick Widgets\" for them..."
	 echo ""
	 $sleep
	 echo "            ...and PowerShift between settings!"
	 echo ""
	 $sleep
	 echo $line
	 echo " They will also be your new SuperCharger values!"
	 echo $line
	 echo ""
	 $sleep
	 echo " They will have descriptive names..."
	 echo ""
	 $sleep
	 echo "                  ...indicating minfree values."
	 echo ""
	 $sleep
	 echo " Different Cust-OOMizer settings will be saved!"
	 echo "";;
  29)echo "              ====================="
	 echo "             //// Owner's Guide \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Loading Owner's Guide..."
	 load_help_file
	 echo ""
	 $sleep
	 echo " I hope that helped! :^)"
	 echo "";;
  30)echo "               ==================="
	 echo "              //// HELP CENTRE \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Loading web site for more help & updates..."
	 echo ""
	 load_page qM6yR
	 echo $line
	 echo ""
	 $sleep
	 echo " I hope that helped! :^)"
	 echo "";;
  31)echo "             ======================"
	 echo "            //// DRIVER OPTIONS \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 backup_system_stuff
	 echo ""
	 $sleep
	 echo " Scrolling Speed Options..."
	 echo " =========================="
	 echo ""
	 $sleep
	 echo -n " "
	 if [ "$scpercent" -eq 100 ]; then echo -n "0 (no delay), "; fi
	 echo "1 (fast), 2 (normal), 3 (slow)"
	 while :; do
		echo ""
		$sleep
		if [ "$scpercent" -eq 100 ]; then echo -n " Please select scrolling speed (0 - 3): "
		else echo -n " Please select scrolling speed (1 - 3): "
		fi
		read speed
		echo ""
		case $speed in
		  0)sleep="sleep $speed";break;;
		  1)sleep="sleep $speed";break;;
		  2)sleep="sleep $speed";break;;
		  3)sleep="sleep $speed";break;;
		  *)echo "      Invalid entry... Please try again :p";;
		esac
	 done
	 echo $line
	 echo "       Scrolling Speed is now set to $speed..."
	 echo $line
	 echo ""
	 $sleep
	 if [ "$preics" ]; then showbuildpropopt=0
		echo " Build.prop vs Local.prop..."
		echo " ==========================="
		echo ""
		$sleep
		echo $line
		if [ ! "$buildprop" ] && [ ! -f "/data/local.prop" ]; then
			echo "  WARNING: You don't have a /data/local.prop!"
			echo $line
			echo ""
			$sleep
			echo " You can try creating /data/local.prop..."
			echo ""
			$sleep
			echo "  ...and see if the launcher gets SuperCharged!"
			echo ""
			$sleep
			echo $line
		fi
		echo "    Using local.prop is STRONGLY recommended!"
		echo $line
		echo ""
		$sleep
		echo " But if the launcher DOES'T get SuperCharged..."
		info_build_prop
		echo -n " Do you want to use Build.prop"
		if [ ! "$buildprop" ] && [ ! -f "/data/local.prop" ]; then
			echo "..."
			echo ""
			$sleep
			echo "                 ...or create /data/local.prop?"
		else echo "?"
		fi
		echo ""
		$sleep
		buildpropold=$buildprop
		echo -n " Enter (B)uild.prop or any key for local.prop: "
		read buildpropopt
		echo ""
		echo $line
		case $buildpropopt in
		  b|B)buildprop=1
			  prop="/system/build.prop"
			  echo "        Okay! build.prop Mode Activated!";;
			*)buildprop=0
			  prop="/data/local.prop"
			  echo "        Okay! local.prop Mode Activated!";;
		esac
		if [ ! -f "$prop" ]; then touch $prop; chown 0.0 $prop; chmod 644 $prop; fi
		if [ "$buildpropold" ] && [ "$buildprop" != "$buildpropold" ]; then
			if [ "$buildpropold" -eq 1 ]; then
				sed -n '/.*V6 SuperCharger/,/.*V6 SuperCharged/p' /system/build.prop >> /data/local.prop
				echo " Copied SuperCharger entries to local.prop..."
				echo ""
				$sleep
				sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d' /system/build.prop
				echo "   ...and cleaned SuperCharger from build.prop!"
			elif [ -f "/data/local.prop" ]; then
				sed -n '/.*V6 SuperCharger/,/.*V6 SuperCharged/p' /data/local.prop >> /system/build.prop
				echo " Copied SuperCharger entries to build.prop..."
				echo ""
				$sleep
				sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d' /data/local.prop
				echo "   ...and cleaned SuperCharger from local.prop!"
			fi
			echo ""
			echo $line
			echo ""
			$sleep
		fi
		echo $line
		echo ""
		$sleep
		echo -n " Press The Enter Key... "
		read enter
		echo ""
		echo $line
		echo ""
		$sleep
		echo " SuperCharged Launcher Strength..."
		echo " ================================="
		echo ""
		$sleep
		if [ "$gb" -eq 1 ]; then
			echo " Hard To Kill Launcher is..."
			echo ""
			$sleep
			echo "                  ...Strong BUT Still Killable!"
			echo ""
			$sleep
		fi
		echo " Die-Hard Launcher is..."
		echo ""
		$sleep
		echo "                ...VERY Strong and RECOMMENDED!"
		echo ""
		$sleep
		echo " BulletProof Launcher is..."
		echo ""
		$sleep
		echo "                   ...Strongest and UNKILLABLE!"
		echo ""
		$sleep
		info_launcher_warning
		while :; do
			echo $line
			echo ""
			$sleep
			echo " Select a Launcher Strength..."
			echo ""
			echo -n " "
			if [ "$gb" -eq 1 ]; then echo -n "(H)TK, "; fi
			echo -n "(B)ulletProof, any key for Die-Hard: "
			read lstrength
			echo ""
			echo $line
			case $lstrength in
			  h|H)if [ "$gb" -eq 0 ]; then echo "      Invalid entry... Please try again :p"
				  else launcheradj=2
					echo " SuperCharged Launcher Strength is Hard To Kill!"
					break
				  fi;;
			  b|B)launcheradj=0
				  echo " SuperCharged Launcher Strength is BulletProof!"
				  break;;
				*)launcheradj=1
				  echo "  SuperCharged Launcher Strength is Die-Hard!"
				  break;;
			esac
		done
		for p in /system/etc/ram.conf $prop; do if [ -f "$p" ]; then sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$launcheradj/ $p; fi; done 2>/dev/null
		echo $line
		echo ""
		$sleep
	 else buildprop=1; prop="/system/build.prop"; launcheradj=1
	 fi
	 echo " Kernel & Virtual Memory Tweaks..."
	 echo " ================================="
	 echo ""
	 $sleep
	 echo " SuperCharger will apply additional tweaks..."
	 echo ""
	 $sleep
	 echo "     ...for RAM management and battery savings!"
	 echo ""
	 $sleep
	 echo $line
	 echo " Note: The Kick Ass Kernelizer has DOZENS MORE!"
	 echo $line
	 echo ""
	 $sleep
	 echo $line
	 echo "   The -=Entropy-ness Enlarger=- is Optional!"
	 echo $line
	 echo ""
	 $sleep
	 echo " ANYWAY...\"Kernel Panics\" are inevitable..."
	 echo ""
	 $sleep
	 echo "         ...and can result in \"Random Reboots\"!"
	 echo ""
	 $sleep
	 echo " Choose a \"Random Reboot Tolerance\" Level... "
	 echo ""
	 $sleep
	 echo " 1. Rock Hard Kernel aka DON'T PANIC!"
	 echo "    ================================="
	 echo "                      ...this PREVENTS reboots!"
	 echo "          ...so choose this for STABLE kernels!"
	 echo " Note: This causes hangs on reboot on some ROMS"
	 echo ""
	 $sleep
	 echo " 2. Rock & Roll Kernel aka OOPS... DON'T PANIC!"
	 echo "    ==========================================="
	 echo "     ...reboots after a 30s recovery attempt..."
	 echo "       ...but NOT when an OOPS or BUG turns up!"
	 echo " Note: This causes hangs on reboot on some ROMS"
	 echo ""
	 $sleep
	 echo " 3. Soft Rock Kernel aka EVERYBODY PANIC!"
	 echo "    ====================================="
	 echo "       ...reboots after a 30s recovery attempt!"
	 echo "        ...battery drains on a frozen screen..."
	 echo "        ...so choose this for UNSTABLE kernels!"
	 echo ""
	 if [ "$scpercent" -eq 0 ]; then
		$sleep
		echo $line
		echo " An Option from 2 - 13 still needs to be run!"
	 fi
	 echo $line
	 echo ""
	 $sleep
	 echo $line
	 echo "    Note: Virtual Memory Tweaks Still Apply!"
	 echo $line
	 echo ""
	 $sleep
	 for rc in $initrcpath $allrcpaths; do
		sed -i '/vm\/.*oom.*/d
				/vm\/.*vfs_cache_pressure.*/d
				/vm\/.*overcommit_memory.*/d
				/vm\/.*swappiness.*/d
				/kernel\/panic.*/d
				/random\/.*_wakeup_threshold.*/d' $rc
	 done
	 echo " (N)one - use your ROM's / other tweak's values"
	 echo "  Rock (H)ard  - NEVER reboot on panic."
	 echo " (R)ock & Roll - Wait 30s but NOT on OOPS/Bug."
	 echo " (S)oft Rock   - Wait 30s on ANY panic."
	 while :; do
		echo ""
		$sleep
		echo -n " Pick a Kernel Strength / \"Reboot Tolerance\": "
		read kvm
		echo ""
		echo $line
		case $kvm in
		  n|N)panicmode=0; kpanic=30; kpoops=1
			  echo "         NONE!? Good Luck with that! LOL"
			  break;;
		  h|H)panicmode=3; kpanic=0; kpoops=0
			  echo "     DON'T PANIC! Rock Hard Kernel Chosen!"
			  break;;
		  r|R)panicmode=2; kpanic=30; kpoops=0
			  echo " OOPS... DON'T PANIC! Rock & Roll Kernel Chosen!"
			  break;;
		  s|S)panicmode=1; kpanic=30; kpoops=1
			  echo " EVERYBODY PANIC! Soft Rock Kernel Chosen!"
			  break;;
		    *)echo "      Invalid entry... Please try again :p"
			  echo $line;;
		esac
	 done
	 echo $line
	 echo ""
	 $sleep
	 echo " Entropy-ness Enlarger keeps \"Random Data\"..."
	 echo ""
	 $sleep
	 echo "        ...high without effecting battery life!"
	 echo ""
	 $sleep
	 echo " This should effect Wi-Fi favourably and..."
	 echo ""
	 $sleep
	 echo " ...many claim drastically smoother smoothness!"
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Want -=Entropy-ness Enlarger=- to Pump You Up?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read epyness
	 echo ""
	 echo $line
	 case $epyness in
		y|Y)pyness=1
			echo "   Now You'll Have Some Big Ass Entropy-ness!";;
		  *)pyness=0
			echo "          No Entropy-ness Pump For You!";;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 if [ -f "/system/lib/modules/frandom.ko" ] || [ "$frandomtype" ]; then
		echo " BONUS! Your kernel supports frandom..."
		echo ""
		$sleep
		echo " ...that's \"fast random\" which is the fastest."
		echo ""
		$sleep
		echo " So the -=Fentropy enForcer=- will link it to..."
		echo ""
		$sleep
		echo "                       ...the super slow random!"
		echo ""
		$sleep
		echo " You also have erandom (fastest like frandom)..."
		echo ""
		$sleep
		echo "       ...but is more economical than frandom..."
		echo ""
		$sleep
		echo "   ...this gets linked to urandom and hw_random!"
		echo ""
		$sleep
		echo " If frandom is not enabled automatically..."
		echo ""
		$sleep
		echo "...Fentropy enForcer will enable it for you too!"
		echo ""
	 fi
	 if [ "$ksmdir" ]; then
		echo $line
		echo "           But WAIT... There's MOAR!!"
		echo $line
		echo ""
		$sleep
		echo " Your Kernel has available..."
		echo ""
		$sleep
		if [ "$KSM" = "UKSM" ]; then echo "              ...Ultra Kernel SamePage Merging!"
		else echo "                    ...Kernel SamePage Merging!"
		fi
		echo ""
		$sleep
		if [ "`cat /sys/kernel/mm/$ksmdir/run`" -eq 1 ]; then echo " $KSM is currently saving you $((`cat /sys/kernel/mm/$ksmdir/pages_sharing`/256)) MB of RAM..."
		else
			echo "                        ...but it's disabled :P"
			echo ""
			$sleep
			echo " $KSM can potentially save alot of RAM usage..."
		fi
		echo ""
		$sleep
		echo "  ...by sharing information among processes ;^]"
		echo ""
		$sleep
		echo " This is also known as \"Data DeDuplication\"!"
		echo "                        ==== ============="
		echo ""
		$sleep
		echo " However, if not set up right..."
		echo ""
		$sleep
		echo " ...it can be so slow that it's not worth it..."
		echo ""
		$sleep
		echo " ...or it can drain battery via high CPU loads!"
		echo ""
		$sleep
		echo "  But I can make it smarter & battery friendly!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Want the -=Super Duper DeDuper=- to DeDoop U2?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read sduper
		echo ""
		echo $line
		case $sduper in
		  y|Y)deduper=1
			  echo "         Super Duper! DeDuper Activated!";;
		    *)deduper=0
			  echo "      Fine! No Super Duper DeDuper For You!";;
		esac
	 fi
	 echo $line
	 echo ""
	 $sleep
	 for rc in $initrcpath $rcpaths; do sed -i '/vm\/min_free_kbytes/ a\
    write /proc/sys/vm/oom_kill_allocating_task 0\
    write /proc/sys/vm/panic_on_oom 0\
    write /proc/sys/vm/vfs_cache_pressure 10\
    write /proc/sys/vm/overcommit_memory 1\
    write /proc/sys/vm/swappiness 20\
#   write /proc/sys/kernel/panic_on_oops '$kpoops'\
#   write /proc/sys/kernel/panic '$kpanic'\
#   write /proc/sys/kernel/random/write_wakeup_threshold 128\
#   write /proc/sys/kernel/random/read_wakeup_threshold 1376' $rc
		if [ "$panicmode" -gt 0 ]; then sed -i '/^#.*kernel\/panic/s/#/ /' $rc; fi
		if [ "$pyness" -ne 0 ]; then sed -i '/^#.*kernel\/random/s/#/ /' $rc; fi
	 done
	 echo " Applying Kernel & Virtual Memory Tweaks..."
	 echo ""
	 $sleep
	 Apply_KVM_Tweaks
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " System Property Accessory Tweaks..."
	 echo " ==================================="
	 echo ""
	 $sleep
	 echo " SuperCharger can apply additional tweaks..."
	 echo ""
	 $sleep
	 echo "   ...for more performance and battery savings!"
	 echo ""
	 $sleep
	 echo " They are as follows..."
	 echo ""
	 $sleep
	 echo " ...based on the $ram MB of RAM on your device!"
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 if [ "`getprop | grep heapgrowthlimit`" ]; then echo "        dalvik.vm.heapgrowthlimit = $heapgrowthlimit MB"; fi
	 echo "               dalvik.vm.heapsize = $heapsize MB"
	 if [ "`getprop | grep persist.sys.vm.heapsize`" ]; then echo "          persist.sys.vm.heapsize = $heapsize MB"; fi
	 echo "     persist.sys.purgeable_assets = 1"
	 echo "    wifi.supplicant_scan_interval = 180"
	 echo "    windowsmgr.max_events_per_sec = 90"
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 sed -i '/Accessory Tweaks/,/max_events_per_sec/s/^# //' $prop
	 echo " Enable System Property Accessory Tweaks?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read acc
	 echo ""
	 echo $line
	 case $acc in
		y|Y)propaccessories=1
			echo "  System Property Accessory Tweaks are ENABLED!"
			echo $line
			echo ""
			$sleep
			Apply_Accessories;;
		  *)propaccessories=0
			echo " System Property Accessory Tweaks are DISABLED!"
			sed -i '/Accessory Tweaks/,/max_events_per_sec/s/^/# /
					/Accessory Tweaks/,/####/s/^# //' $prop;;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " 3G TurboCharger Enhancement..."
	 echo " =============================="
	 echo ""
	 $sleep
	 echo " 3G TurboCharger Enhancement effects..."
	 echo ""
	 $sleep
	 echo " ...network buffersizes and TCP RAM allocation!"
	 echo ""
	 $sleep
	 echo $line
	 echo " This is an ADDON to my 3G TurboCharger Script!"
	 if [ "$scpercent" -eq 0 ]; then
		echo $line
		echo ""
		$sleep
		echo $line
		echo " An Option from 2 - 13 still needs to be run!"
	 fi
	 echo $line
	 echo ""
	 $sleep
	 sed -i '/TurboCharger Enhancement/,/edge=/s/^# //' $prop
	 echo " Enable 3G TurboCharger Enhancement?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read acc
	 echo ""
	 echo $line
	 case $acc in
		y|Y)tc3g=1
			echo "     3G TurboCharger Enhancement is ENABLED!"
			echo $line
			echo ""
			$sleep
			Apply_3G_TCE;;
		  *)tc3g=0
			echo "    3G TurboCharger Enhancement is DISABLED!"
			sed -i '/TurboCharger Enhancement/,/edge=/s/^/# /
					/TurboCharger Enhancement/,/####/s/^# //' $prop;;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " SD Read Speed Tweak..."
	 echo " ======================"
	 echo ""
	 $sleep
	 echo " You can choose the SD Card Read Ahead Cache!"
	 echo ""
	 $sleep
	 echo " Suggestions are calculated based on RAM..."
	 echo ""
	 $sleep
	 echo "            ...or you can input a custom value!"
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo "      Current SD Read Ahead Cache = `cat /sys/block/mmcblk0/bdi/read_ahead_kb` KB"
	 echo ""
	 $sleep
	 echo -n "      Current SD Read Speed Tweak = "
	 if [ "$sdtweak" -eq 0 ]; then echo "DISABLED"
	 else echo "$sdtweak KB"
	 fi
	 echo ""
	 if [ "$scpercent" -eq 0 ]; then
		$sleep
		echo $line
		echo " An Option from 2 - 13 still needs to be run!"
	 fi
	 echo $line
	 echo ""
	 $sleep
	 for rc in $initrcpath $allrcpaths; do sed -i '/bdi\/read_ahead_kb/d' $rc; done
	 echo " Enable SD Read Speed Tweak?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read sdt
	 echo ""
	 echo $line
	 case $sdt in
		y|Y)sd1=$(((ram/64-1)*128)); sd2=$((ram/64*128)); sd3=$(((ram/64+1)*128)); sd4=$(((ram/64+2)*128)); sd5=$(((ram/64+3)*128))
			if [ "$sd1" -lt 128 ]; then sd1=128; fi
			if [ "$sd1" -gt 2048 ]; then sd1=2048; fi
			if [ "$sd2" -lt 128 ]; then sd2=128; fi
			if [ "$sd2" -gt 2048 ]; then sd2=2048; fi
			if [ "$sd3" -lt 128 ]; then sd3=128; fi
			if [ "$sd3" -gt 2048 ]; then sd3=2048; fi
			if [ "$sd4" -lt 128 ]; then sd4=128; fi
			if [ "$sd4" -gt 2048 ]; then sd4=2048; fi
			if [ "$sd5" -lt 128 ]; then sd5=128; fi
			if [ "$sd5" -gt 2048 ]; then sd5=2048; fi
			echo "      Okie dOkie! Choose an SD Read Speed!"
			echo $line
			while :; do
				echo ""
				$sleep
				echo " Suggested values based on $ram MB of RAM..."
				echo " Note: Suggested Values Max out at 2048 KB"
				echo ""
				$sleep
				echo "                1. $sd1 KB"
				echo "                2. $sd2 KB"
				echo "                3. $sd3 KB"
				echo "                4. $sd4 KB"
				echo "                5. $sd5 KB"
				echo "                6. Your 2 sense lol"
				while :; do
					echo ""
					$sleep
					echo -n " Enter 1 - 5, or 6 for custom value: "
					read picksd
					echo ""
					echo $line
					case $picksd in
					  1)sdtweak=$sd1; break 2;;
					  2)sdtweak=$sd2; break 2;;
					  3)sdtweak=$sd3; break 2;;
					  4)sdtweak=$sd4; break 2;;
					  5)sdtweak=$sd5; break 2;;
					  6)echo ""
						$sleep
						echo " A valid Custom value must be 64 or more..."
						echo " And also be a multiple of 64..."
						while :; do
							echo ""
							$sleep
							echo -n " Enter a valid value, or X to cancel :"
							read picksd
							echo ""
							echo $line
							if [ "$picksd" = "x" ] || [ "$picksd" = "X" ]; then break 2; fi
							if [ "$picksd" -ge 64 ] && [ "$((picksd%64))" -eq 0 ]; then sdtweak=$picksd; break 3; fi 2>/dev/null
							echo "      Invalid entry... Please try again :p"
							echo $line
						done;;
					  *)echo "                      DERP!"
						echo $line;;
					esac
				done
			done
			echo " SD Read Speed Tweak ENABLED and set to $sdtweak KB!"
			echo $line
			echo ""
			$sleep
			for rc in $initrcpath $rcpaths; do sed -i '/KVM Tweaks/ i\
    write /sys/block/mmcblk0/bdi/read_ahead_kb '$sdtweak $rc
			done 2>/dev/null
			Apply_SD_Speed;;
		  *)sdtweak=0
			echo "        SD Read Speed Tweak is DISABLED!";;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " BulletProof Apps Options..."
	 echo " ==========================="
	 echo ""
	 $sleep
	 if [ ! -f "/data/97BulletProof_Apps.sh" ]; then blurb_BulletProof_Apps; fi
	 Configure_BulletProof_Apps
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Engine Flush-O-Matic Options..."
	 echo " ==============================="
	 echo ""
	 $sleep
	 if [ ! -f "/data/V6_SuperCharger/!FastEngineFlush.sh" ]; then
		blurb_FastEngineFlush
		echo $line
		echo ""
		$sleep
	 fi
	 Configure_FastEngineFlush
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 if [ -d "/system/etc/init.d" ]; then
		echo " Detailing On Boot..."
		echo " ===================="
		echo ""
		$sleep
		if [ ! -f "/data/V6_SuperCharger/!Detailing.sh" ]; then blurb_Detailing; fi
		blurb_boot_script "Detailing" "Detailing"
		Configure_Detailing
		if [ "$detailinterval" -ne 0 ] && [ ! "`which sqlite3`" ]; then miss_detailing=yes
			echo $line
			echo ""
			$sleep
			echo $line
			echo " WARNING... sqlite3 binary was NOT found..."
		fi
		echo $line
		echo ""
		$sleep
		echo -n " Press The Enter Key... "
		read enter
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Fix Alignment On Boot..."
		echo " ========================"
		echo ""
		$sleep
		if [ ! -f "/data/V6_SuperCharger/!FixAlignment.sh" ]; then blurb_FixAlignment; fi
		blurb_boot_script "Fix Alignment" "FixAlign"
		Configure_FixAlignment
		if [ "$fixalign" -eq 1 ] && [ ! "`which zipalign`" ]; then miss_fixalign=yes
			echo $line
			echo ""
			$sleep
			echo $line
			echo " WARNING... zipalign binary was NOT found..."
		fi
		echo $line
		echo ""
		$sleep
		echo -n " Press The Enter Key... "
		read enter
		echo ""
		echo $line
		echo ""
		$sleep
		if [ "$fixalign" -ne 1 ]; then
			echo " Wheel Alignment On Boot..."
			echo " =========================="
			echo ""
			$sleep
			if [ ! -f "/data/V6_SuperCharger/!WheelAlignment.sh" ]; then blurb_WheelAlignment; fi
			blurb_boot_script "Wheel Alignment" "ZepAlign"
			Configure_WheelAlignment
			if [ "$zepalign" -eq 1 ] && [ ! "`which zipalign`" ]; then miss_zepalign=yes
				echo $line
				echo ""
				$sleep
				echo $line
				echo " WARNING... zipalign binary was NOT found..."
			fi
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
			echo ""
			echo $line
			echo ""
			$sleep
			echo " Fix Emissions On Boot..."
			echo " ========================"
			echo ""
			$sleep
			if [ ! -f "/data/V6_SuperCharger/!FixEmissions.sh" ]; then blurb_FixEmissions; fi
			blurb_boot_script "Fix Emissions" "FixEmissions"
			Configure_FixEmissions
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
			echo ""
			echo $line
			echo ""
			$sleep
		fi
		if [ "$preics" ]; then
			echo " System Integration - $initrcpath1 Options..."
			echo " =================="
			echo ""
			$sleep
			echo " SuperCharger can attempt greater integration..."
			echo ""
			$sleep
			echo "  ...with system files on boot using init.rc..."
			echo ""
			$sleep
			echo " If it sticks, it makes for a much cleaner mod!"
			echo ""
			$sleep
			echo " Root access issues are rare, but can occur..."
			echo ""
			echo $line
			$sleep
			echo " Regardless, a SuperCharged init.rc file..."
			echo ""
			$sleep
			echo "               ...can always be found in /data!"
			echo $line
			$sleep
			echo " Note: You can bake $initrcpath into your ROM!"
			echo $line
			echo ""
			$sleep
			echo " Custom ROMs: Settings should stick either way!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo -n " Integrate? Enter Y for Yes, any key for No: "
			read bake
			echo ""
			echo $line
			case $bake in
			  y|Y)initrc=1
				  echo "   System Integration of $initrcpath1 is ENABLED!";;
				*)initrc=0
				  echo "   System Integration of $initrcpath1 is DISABLED!";;
			esac
			echo $line
			echo ""
			$sleep
		else initrc=0
		fi
	 else initrc=0; detailinterval=0; zepalign=0; fixemissions=0; fixalign=0
	 fi
	 echo " Disable AWESOME V6 Animation? (Say \"NO\"!) :P"
	 echo "         ======="
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read animate
	 echo ""
	 echo $line
	 case $animate in
		y|Y)animation=0
			echo "          Boo... Animation is OFF... :/";;
		  *)animation=1
			echo "          Yay... Animation is ON... :D";;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Disable intro Rock Music? (Say \"NO\" AGAIN!)"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read rock
	 echo ""
	 echo $line
	 case $rock in
		y|Y)music=0
			echo "             Wow... That Blows... :p";;
		  *)music=1
			echo "                    ROCK ON! ;^]";;
	 esac
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Press The Enter Key... "
	 read enter
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 update_options_in_scripts supercharger
	 update_options
	 echo "        Driver Options Have Been Saved!"
	 echo ""
	 if [ "$miss_fixalign" ] || [ "$miss_zepalign" ] || [ "$miss_detailing" ]; then
		echo $line
		echo ""
		$sleep
		if [ "$miss_fixalign" ] || [ "$miss_zepalign" ] && [ "$miss_detailing" ]; then
			echo " Because you're missing BOTH..."
			echo ""
			$sleep
			echo "            ...sqlite3 and zipalign binaries..."
		elif [ "$miss_detailing" ]; then echo " Because you're missing the sqlite3 binary..."
		else echo " Because you're missing the zipalign binary..."
		fi
		miss_fixalign=; miss_zepalign=; miss_detailing=
		echo ""
		$sleep
		echo " Load the XDA SuperCharger thread..."
		echo ""
		$sleep
		echo "   ...and install The SuperCharger Starter Kit!"
		echo ""
		$sleep
		echo -n " Press The Enter Key... "
		read enter
		echo ""
		load_page qM6yR
		echo $line
		echo ""
		$sleep
		echo -n " Press The Enter Key... "
		read enter
		echo ""
	 fi
	 if [ "$autoresupercharge" ]; then opt=25
		$sleep
		echo "             ======================="
		echo "            //// RE-SUPERCHARGER \\\\\\\\"
	 else
		echo $line
		if [ "$missingoptions" ] && [ "$ram1" -eq "$ram2" ]; then script_version_check; fi
		echo "             Now Off To The Races!"
		missingoptions=
	 fi
	 firstgear=;;
  32)echo "                ================="
	 echo "               //// OFF TOPIC \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Ok this is \"Off Topic\"..."
	 echo ""
	 $sleep
	 echo " ...but maybe there's a good reason..."
	 echo ""
	 $sleep
	 echo "            ...why this script is so popular :p"
	 echo ""
	 $sleep
	 echo " It's profound... so just read the link..."
	 echo ""
	 $sleep
	 echo "  ...and decide for yourself if it makes sense!"
	 echo ""
	 $sleep
	 echo " If you don't like it... remember..."
	 echo ""
	 $sleep
	 echo "                  ...don't shoot the messenger!"
	 echo ""
	 $sleep
	 echo " Either way... I'm not crazy..."
	 echo ""
	 $sleep
	 echo "      ...and you may learn something..."
	 echo ""
	 $sleep
	 echo "                    ...even if you're a doctor!"
	 echo ""
	 load_page 0dMcp;;
  33)echo $line
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
	 reboot; busybox reboot;;
  34)echo "              ==================="
	 echo "             //// SUPERCLEAN! \\\\\\\\"
	 if [ "$ram1" -ne "$ram2" ]; then opt=28; fi;;
  35)echo " Did you find this useful? Feedback is welcome!";;
  69)if [ ! "$crapp" ]; then HazEgg=woot; remount ro
		echo $line
		echo "                  Easter Egg!!"
		echo $line
		echo ""
		$sleep
		echo " Nothing bad will happen but you can see..."
		echo ""
		$sleep
		echo "          ...what DOES happen for those that..."
		echo ""
		$sleep
		echo "       ...have some crappy-ass app installed..."
		echo ""
		$sleep
		echo "          ...and choose the wrong answer... LOL"
		echo ""
		$sleep
		echo -n " Press The Enter Key... for teh lulz! "
		read enter
		echo ""
	 fi
	 echo $line
	 echo "         WARNING: Incompatibilty Error!"
	 echo $line
	 echo ""
	 $sleep
	 echo " A memory app of questionable integrity found!"
	 echo ""
	 $sleep
	 echo " To ensure REAL SUPERCHARGING..."
	 echo "           =================="
	 echo ""
	 $sleep
	 echo "    ...with A REAL SUPERCHARGED LAUNCHER..."
	 echo "            ============================"
	 echo ""
	 $sleep
	 echo "     You need to uninstall that \"cr-app\" :/"
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Say Yes to uninstall it now..."
	 echo ""
	 $sleep
	 echo "  ...if you say No... I WILL make you Cry Hard!"
	 echo ""
	 $sleep
	 echo " And and don't dare say I didn't warn ya..."
	 echo ""
	 $sleep
	 echo -n " Enter N for No, any key for Yes: "
	 if [ "$HazEgg" ]; then uncrapp=N; echo $uncrapp
	 else read uncrapp
	 fi
	 echo ""
	 echo $line
	 case $uncrapp in
		n|N)echo "            No SuperCharger For You!"
			echo $line
			echo ""
			$sleep
			echo "             ======================="
			echo "            //// UN-SUPERCHARGER \\\\\\\\"
			sleep="sleep 0"; opt=14;;
		  *)echo " Good Answer! (You are SO lucky...)"
			echo $line
			echo ""
			$sleep
			echo " Ok... getting rid of that crapp..."
			echo ""
			$sleep
			echo $line
			for i in `echo $crapp`; do echo -n " "; pm uninstall $i; done
			crapp=; opt=28;;
	 esac;;
  *) echo "   #!*@%$*?%@&)&*#!*?(*)(*)&(!)%#!&?@#$*%&?&$%$*#?!"
	 echo ""
	 sleep 2
	 echo "     oops.. typo?!  $opt is an Invalid Option!"
	 echo ""
	 sleep 2
	 echo "            1 <= Valid Option => 35 !!"
	 echo ""
	 sleep 2
	 echo -n " hehe... Press the Enter Key to continue... ;) "
	 read enter
	 echo ""
	 opt=69;;
 esac
 if [ "$preics" ] && [ "$opt" -ge 2 ] && [ "$opt" -le 10 ]; then
	echo ""
	$sleep
	echo $line
	if [ "$launcheradj" -eq 0 ]; then echo "               BULLETPROOF LAUNCHER!"
	elif [ "$launcheradj" -eq 2 ]; then echo "               HARD TO KILL LAUNCHER!"
	else echo "                 DIE-HARD LAUNCHER!"
	fi
 fi
 if [ "$opt" -ne 1 ] && [ "$opt" -ne 14 ] && [ "$opt" -ne 15 ] && [ "$opt" -le 28 ] && [ "$ram1" -ne "$ram2" ]; then opt=69; autoresupercharge=; showparlor=; showedparlor=sure; fi
 if [ "$opt" -le 27 ] || [ "$opt" -eq 34 ]; then
	echo $line
	echo ""
	$sleep
	if [ "$opt" -ne 1 ] && [ "$opt" -ne 15 ] && [ "`awk '/ \/ | \/system /&&/ro,/' /proc/mounts`" ]; then opt=28
		echo $line
		echo "     YELLOW FLAG!! We have a HUGE Problem!!"
		echo $line
		echo ""
		$sleep
		echo -n " Can't mount "
		if [ "`awk '/ \/ /&&/ro,/' /proc/mounts`" ] && [ "`awk '/ \/system /&&/ro,/' /proc/mounts`" ]; then echo "root and /system as read write..."
		elif [ "`awk '/ \/ /&&/ro,/' /proc/mounts`" ]; then echo "root as read write..."
		else echo "/system as read write..."
		fi
		echo ""
		$sleep
		echo $line
		echo "          Try \"ReStarting Your Engine\"!"
	fi
 fi
 if [ "$opt" -eq 1 ]; then
	echo " Out Of Memory (OOM) / lowmemorykiller values:"
	echo ""
	$sleep
	echo "        "$currentminfree pages
	echo ""
	$sleep
	echo $currentminfree | awk -F, '{OFMT="%.0f"; print "  Which means: "$1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}'
	echo ""
	echo $line
	if [ "$lname" ]; then
		echo " $lname is the home launcher!"
		echo $line
		echo ""
		$sleep
		echo -n " But verify groupings with the bOOM Stick"
		if [ "$lname" = "android.process.acore" ] && [ ! "$diehard" ]; then
			echo "..."
			echo ""
			$sleep
			echo "              ...since I'm not 100% sure... lol"
		else echo "!"
		fi
		echo ""
		echo $line
	fi
	echo ""
	$sleep
	echo "           Home Launcher Priority is: $HL"
	echo ""
	$sleep
	echo "          Foreground App Priority is: $FA"
	echo ""
	$sleep
	if [ "$gb" -eq 1 ] || [ "$servicesjarpatched" ]; then
		echo "         Perceptible App Priority is: $PA"
		echo ""
		$sleep
	fi
	echo "             Visible App Priority is: $VA"
	echo ""
	echo $line
	echo ""
	$sleep
	if [ "$status" -eq 4 ]; then
		echo " Launcher is greater than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "     Wow, that's one weak ass launcher! :("
	elif [ "$HL" -eq "$VA" ]; then
		echo " Launcher is equal to Visible App..."
		echo ""
		$sleep
		echo "        ...Home Launcher is \"Locked In Memory\"!"
		echo ""
		$sleep
		echo $line
		echo "      meh... that's still pretty weak! :P"
	elif [ "$status" -eq 0 ]; then
		echo " Launcher is equal to Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ] || [ "$servicesjarpatched" ]; then
			echo "           ...is less than Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "         Home Launcher is BULLETPROOF!"
	elif [ "$status" -eq 1 ]; then
		echo " Launcher is greater than Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ] || [ "$servicesjarpatched" ]; then
			echo "           ...is less than Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "          Home Launcher is DIE-HARD!"
	else
		echo " Launcher is greater than Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ] || [ "$servicesjarpatched" ]; then
			echo "            ...is equal to Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "      Home Launcher is very HARD TO KILL!"
	fi
	echo $line
	echo ""
	$sleep
	echo " Going to show The bOOM Stick..."
	echo ""
	$sleep
	echo " ...for deeper analysis...(that's what she sed!)"
	echo ""
	$sleep
	echo -n " Press The Enter Key... "
	read enter
	echo ""
	echo $line
	boomstick=bOOM
	bOOM_Stick bOOM
	showedboomstick=yes
 elif [ "$opt" -lt 35 ]; then
	if [ "$opt" -eq 25 ]; then
		if [ "$autoresupercharge" ]; then resuper=Y; rm /data/local.prop.unsuper 2>/dev/null
		else
			echo " Your previous V6 SuperCharger Settings are..."
			echo ""
			$sleep
			awk -F, '{printf "%47s\n", $1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}' $storage/V6_SuperCharger/data/V6_SuperCharger/SuperChargerMinfree
			echo ""
			$sleep
			echo " Re-SuperCharge from $storage?"
			echo ""
			$sleep
			echo -n " Enter Y for Yes, any key for No: "
			read resuper
			echo ""
			echo $line
		fi
		case $resuper in
			y|Y)CONFIG=Re-Super
				echo ""
				$sleep
				backup_system_stuff
				if [ -f "$initrcpath1" ] && [ ! -f "$initrcpath" ]; then cp -r $initrcpath1 $initrcpath; fi
				if [ "$allrcpaths" ]; then
					install_bp_service rebulletproof
					echo ""
					echo $line
				fi
				echo " Re-SuperCharging from $storage..."
				echo $line
				echo ""
				$sleep
				if [ "`ls $storage/V6_SuperCharger/data/V6_SuperCharger/SuperCharger*`" ]; then echo "      ...your Driver Options..."; $sleep; cp -fr $storage/V6_SuperCharger/data/V6_SuperCharger/SuperCharger* /data/V6_SuperCharger; fi 2>/dev/null
				if [ -f "$storage/V6_SuperCharger/data/99SuperCharger.sh" ]; then echo "      ...your SuperCharger Settings..."; $sleep; cp -fr $storage/V6_SuperCharger/data/99SuperCharger.sh /data; fi
				if [ "`ls $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_Apps*`" ]; then cp -fr $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_Apps* /data/V6_SuperCharger; fi 2>/dev/null
				if [ -f "$storage/V6_SuperCharger/data/97BulletProof_Apps.sh" ]; then echo "      ...your BulletProof Apps Settings..."; $sleep; cp -fr $storage/V6_SuperCharger/data/97BulletProof_Apps.sh /data; fi
				if [ -d "$storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_One_Shots" ]; then cp -fr $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_One_Shots /data/V6_SuperCharger; fi
				if [ -d "$storage/V6_SuperCharger/data/V6_SuperCharger/PowerShift_Scripts" ]; then echo "      ...your PowerShift Scripts..."; $sleep; cp -fr $storage/V6_SuperCharger/data/V6_SuperCharger/PowerShift_Scripts /data/V6_SuperCharger; fi
				if [ "`ls $storage/V6_SuperCharger/data/V6_SuperCharger/\!*.sh`" ]; then echo "      ...your \"Quick Widget\" Scripts..."; $sleep; cp -fr $storage/V6_SuperCharger/data/V6_SuperCharger/\!*.sh /data/V6_SuperCharger; fi 2>/dev/null
				if [ -f "/data/V6_SuperCharger/SuperChargerAdj" ]; then scadj=`cat /data/V6_SuperCharger/SuperChargerAdj`; fi
				if [ -f "/data/V6_SuperCharger/SuperChargerMinfree" ]; then scminfree=`cat /data/V6_SuperCharger/SuperChargerMinfree`; ReSuperCharge=1; autoshowcalculated=
					MB1=`echo $scminfree | awk -F, '{print $1/256}'`;MB2=`echo $scminfree | awk -F, '{print $2/256}'`;MB3=`echo $scminfree | awk -F, '{print $3/256}'`;MB4=`echo $scminfree | awk -F, '{print $4/256}'`;MB5=`echo $scminfree | awk -F, '{print $5/256}'`;MB6=`echo $scminfree | awk -F, '{print $6/256}'`
				fi
				chown 0.0 /data/*.sh 2>/dev/null; chmod 777 /data/*.sh 2>/dev/null
				chown 0.0 /data/V6_SuperCharger/*; chmod 777 /data/V6_SuperCharger/*
				chown 0.0 /data/V6_SuperCharger/BulletProof_One_Shots/* 2>/dev/null; chmod 777 /data/V6_SuperCharger/BulletProof_One_Shots/* 2>/dev/null
				chown 0.0 /data/V6_SuperCharger/PowerShift_Scripts/* 2>/dev/null; chmod 777 /data/V6_SuperCharger/PowerShift_Scripts/* 2>/dev/null
				echo "      ...all \"Terminal Emulator\" Scripts... "; $sleep; dd if=$0 of=/system/xbin/v6 2>/dev/null
				chown 0.0 /system/xbin/v6 2>/dev/null; chmod 777 /system/xbin/v6 2>/dev/null
				if [ "`ls $storage/V6_SuperCharger/system/xbin`" ]; then
					cp -fr $storage/V6_SuperCharger/system/xbin /data/V6_SuperCharger
					chown 0.0 /data/V6_SuperCharger/xbin/*; chmod 777 /data/V6_SuperCharger/xbin/*
					cp -frp /data/V6_SuperCharger/xbin/* /system/xbin
					rm -fr /data/V6_SuperCharger/xbin
				fi 2>/dev/null
				if [ "`ls $storage/V6_SuperCharger/system/etc/init.d`" ] && [ -d "/system/etc/init.d" ]; then
					echo "      ...all init.d \"Start Up Scripts\"... "; $sleep
					cp -fr $storage/V6_SuperCharger/system/etc/init.d /data/V6_SuperCharger
					chown 0.0 /data/V6_SuperCharger/init.d/*; chmod 777 /data/V6_SuperCharger/init.d/*
					cp -frp /data/V6_SuperCharger/init.d/* /system/etc/init.d
					rm -fr /data/V6_SuperCharger/init.d
				fi 2>/dev/null
				echo ""
				echo $line
				echo " ...finished copying files to /system and /data!"
				echo $line
				echo ""
				$sleep
				echo $line
				if [ ! "$missingoptions" ]; then load_options; fi
				script_version_check
				if [ "$missingoptions" ]; then missingoptions=
				else show_current_options
				fi
				echo ""
				$sleep
				echo " If you previously used Terminal to execute..."
				echo ""
				$sleep
				echo " \"v6\", \"flush\", \"fixalign\", \"99super\", or..."
				echo ""
				$sleep
				echo "     ...\"vac\", \"fixfc\", \"zepalign\", \"sclean\"..."
				echo ""
				$sleep
				echo $line
				echo "    Those commands will work automagically!"
				echo $line
				echo ""
				$sleep
				echo " But to avoid conflicts (different rom, etc)..."
				echo ""
				$sleep
				echo "        ...some system files were not restored!"
				echo ""
				$sleep
				echo " Nitro Lag Nullifier and 3G TurboCharger..."
				echo ""
				$sleep
				echo "                ...may need to be re-installed!"
				echo ""
				echo $line
				echo ""
				$sleep
				echo " But this comes first... heh..."
				echo ""
				echo $line
				echo ""
				$sleep
				opt=12;;
			  *)echo " Re-SuperCharging Declined... meh...";;
		esac
	fi
	if [ "$opt" -le 14 ]; then
		if [ ! "$HazEgg" ]; then
			rm -f $storage/UnSuperCharged.html
			rm -f $storage/UnSuperChargerError.html
			rm -f $storage/SuperChargerScriptManagerHelp.html
			rm -f $storage/SuperChargerHelp.html
		fi
		if [ "$opt" -le 13 ]; then
			echo -n " zOOM... "; sleep 2; echo -n "zOOM..."; sleep 2; echo ""
			echo ""
			if [ "$newscadj2" ]; then echo $newscadj2 > /data/V6_SuperCharger/SuperChargerAdj
			else echo $newscadj > /data/V6_SuperCharger/SuperChargerAdj
			fi
			scadj=`cat /data/V6_SuperCharger/SuperChargerAdj`
			adj1=`echo $scadj | awk -F, '{print $1}'`;adj2=`echo $scadj | awk -F, '{print $2}'`;adj3=`echo $scadj | awk -F, '{print $3}'`;adj4=`echo $scadj | awk -F, '{print $4}'`;adj5=`echo $scadj | awk -F, '{print $5}'`;adj6=`echo $scadj | awk -F, '{print $6}'`
			if [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ]; then
				if [ "$scminfree" ] && [ ! "$scminfreeold" ]; then
					cp -fr /data/V6_SuperCharger/SuperChargerMinfree /data/V6_SuperCharger/SuperChargerMinfreeOld
					scminfreeold=`cat /data/V6_SuperCharger/SuperChargerMinfreeOld`
				fi
				SL0=$((MB0*256));SL1=$((MB1*256));SL2=$((MB2*256));SL3=$((MB3*256));SL4=$((MB4*256));SL5=$((MB5*256));SL6=$((MB6*256))
				echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /data/V6_SuperCharger/SuperChargerMinfree
				scminfree=`cat /data/V6_SuperCharger/SuperChargerMinfree`
			elif [ "$scminfree" ]; then SL0=$((MB0*256));SL1=`echo $scminfree | awk -F, '{print $1}'`;SL2=`echo $scminfree | awk -F, '{print $2}'`;SL3=`echo $scminfree | awk -F, '{print $3}'`;SL4=`echo $scminfree | awk -F, '{print $4}'`;SL5=`echo $scminfree | awk -F, '{print $5}'`;SL6=`echo $scminfree | awk -F, '{print $6}'`
			fi
			echo "==============  Information Panel  ============="
			echo "              ====================="
			echo ""
			$sleep
			if [ "$showbuildpropopt" -eq 1 ]; then
				echo " Even though you SuperCharged before..."
				echo ""
				$sleep
				echo "        ...Your launcher is NOT SuperCharged..."
				info_build_prop
				echo " Do you want to use Build.prop?"
				echo ""
				$sleep
				echo -n " Enter Y for Yes, any key for No: "
				read buildpropopt
				echo ""
				case $buildpropopt in
				  y|Y)buildprop=1
					  prop="/system/build.prop"
					  echo " Okay... will use the build.prop method!";;
					*)buildprop=0
					  prop="/data/local.prop"
					  echo " Okay... will try local.prop method again...";;
				esac
				echo ""
				$sleep
				update_options
				echo " Settings have been saved!"
				echo ""
				$sleep
				echo " Note: This can be changed later under Options!"
				echo ""
				echo $line
				echo ""
				$sleep
			fi
			for p in /data/local.prop /system/build.prop /system/bin/build.prop /system/etc/ram.conf; do
				if [ -f "$p" ]; then chown 0.0 $p; chmod 644 $p
					backup_prop $p
					echo ""
					$sleep
				fi
			done 2>/dev/null
			echo $line
			if [ "$preics" ]; then
				echo -n " MEM and ADJ values to be applied to "
				if [ "$buildprop" -eq 0 ]; then echo "LOCAL.PROP!"
				else echo "BUILD.PROP!"
				fi
				echo $line
			fi
			echo ""
			$sleep
			if [ -f "$initrcpath1" ] && [ ! -f "$initrcpath" ]; then cp -r $initrcpath1 $initrcpath; fi
			for rc in $initrcpath1 $allrcpaths /system/etc/hw_config.sh; do
				if [ -f "$rc" ]; then
					echo " Found $rc!"
					echo ""
					$sleep
					if [ "$rc" = "$initrcpath1" ] && [ -f "$initrcbackup" ] || [ -f "$rc.unsuper" ]; then echo " Backup already exists... leaving backup intact"
					elif [ "$rc" = "$initrcpath1" ]; then backup_rc $rc $initrcbackup
					else backup_rc $rc $rc.unsuper
					fi
					echo ""
					$sleep
					if [ "$preics" ] && [ "`grep -ls "on boot" $rc`" ] && [ "$rc" != "/system/etc/hw_config.sh" ]; then
						echo $line
						if [ "$rc" = "$initrcpath1" ] && [ "$initrc" -eq 0 ]; then
							echo ""
							echo " System Integration of $rc is OFF..."
							echo ""
							$sleep
							echo " But for cooking/baking into ROMs..."
							echo ""
							$sleep
							echo $line
						fi
						echo -n " "
						if [ "$rc" = "$initrcpath1" ] && [ "$initrc" -eq 0 ]; then echo -n "/data/"
						elif [ "$rc" = "$initrcpath1" ]; then echo -n "/"
						fi
						if [ "$preics" ] && [ "$opt" -ge 11 ] && [ "$opt" -le 13 ] && [ "$ReSuperCharge" -eq 0 ]; then echo "${rc##*/} will be OOM Fixed!"
						else
							echo -n "${rc##*/} will be SuperCharged"
							if [ "$rc" = "$initrcpath1" ]; then echo "!"
							else echo "..."
								echo $line
								$sleep
								echo "  ...it will also run The SuperCharger Service!"
							fi
						fi
					elif [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ] && [ "$rc" != "$initrcpath1" ] && [ "$rc" != "/system/etc/hw_config.sh" ]; then echo $line; echo "     It will run The SuperCharger Service!"
					fi
					echo $line
					echo ""
					$sleep
				fi
			done 2>/dev/null
			for rc in $initrcpath $allrcpaths; do
				sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d
						/.*_ADJ/d' $rc
				if [ "$scminfree" ]; then
					sed -i '/.*_MEM/d
							/write \/sys\/module\/lowmemorykiller/d' $rc
				else sed -i '/write \/sys\/module\/lowmemorykiller\/parameters\/adj/d' $rc
				fi
				sed -i '/vm\/.*min_free_kbytes*/d
						/vm\/.*oom.*/d
						/vm\/.*vfs_cache_pressure.*/d
						/vm\/.*overcommit_memory.*/d
						/vm\/.*swappiness.*/d
						/kernel\/panic.*/d
						/random\/.*_wakeup_threshold.*/d
						/bdi\/read_ahead_kb/d' $rc
				if [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ]; then sed -i '/SuperCharger_Service/,/SuperCharged_Service/d' $rc; fi
			done
		else
			echo " UNSUPERCHARGE..."
			echo ""
			sleep 1
			echo "       ...UNFIX OOM GROUPINGS..."
			echo ""
			sleep 1
			echo "                   ...RESTORE WEAK ASS LAUNCHER"
			echo ""
			echo $line
			$sleep
			echo " Boo... UnSuperCharging Performance...."
			echo $line
			echo ""
			$sleep
			if [ ! "`ls /system/etc/init.d/*SuperCharger*`" ] && [ ! "`ls /data/*SuperCharger*`" ] && [ ! "`ls /system/etc/init.d/*BulletProof_Apps*`" ] && [ ! -f "$initrcpath" ] && [ ! -f "$initrcbackup" ] && [ ! "$allrcbackups" ]; then
				echo " I Got Nothing To Do! Try SuperCharging first!"
				echo ""
				$sleep
				UnSuperCharged=1
				cat > $storage/UnSuperCharged.html <<EOF
There was nothing to uninstall!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://goo.gl/qM6yR">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
				echo $line
				echo " See $storagename/UnSuperCharged.htm for assistance!"
				echo $line
				echo ""
				$sleep
			else
				if [ ! "$HazEgg" ]; then rm -f $initrcpath; fi
				if [ -f "$initrcbackup" ]; then
					echo "                 BACKUP FOUND!"
					echo ""
					$sleep
					echo " Restoring $initrcpath1..."
					echo ""
					echo $line
					echo ""
					$sleep
					if [ ! "$HazEgg" ]; then
						cp -fr $initrcbackup $initrcpath1
						rm $initrcbackup
					fi
				fi
				for rc in $allrcpaths; do
					if [ -f "$rc.unsuper" ] && [ ! -s "$rc.unsuper" ]; then
						if [ ! "$HazEgg" ]; then rm $rc; rm $rc.unsuper; fi
						continue
					elif [ "`dirname $rc`" != "/"] && [ ! -f "$rc.unsuper" ]; then
						echo "      ERROR... ERROR... ERROR... ERROR..."
						echo ""
						$sleep
						echo "          AN RC BACKUP WAS NOT FOUND!"
						echo ""
						$sleep
						echo "       CAN'T restore some default values!"
						echo ""
						sleep 3
						UnSuperChargerError=1
						cat > $storage/UnSuperChargerError.html <<EOF
The backup file, $rc.unsuper, WAS NOT found!<br>
Please do a manual restore of $rc from your ROM's update file!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://goo.gl/qM6yR">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
						echo $line
						echo " See $storagename/UnSuperChargerError.html for help!"
						if  [ "${rc##*/}" != "init.rc" ]; then
							echo $line
							echo ""
							sleep 4
							if [ ! "$HazEgg" ]; then
								sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d
										/SuperCharger_Service/,/SuperCharged_Service/d
										/BulletProof_Apps_Service/,/BulletProofed_Apps_Service/d' $rc
							fi
							echo " Cleaned "$rc
							echo ""
						fi
					else
						echo "                 BACKUP FOUND!"
						echo ""
						$sleep
						echo " Restoring ${rc##*/}..."
						if [ ! "$HazEgg" ]; then mv $rc.unsuper $rc; fi
						echo ""
					fi
					echo $line
					echo ""
					$sleep
				done
			fi 2>/dev/null
		fi
		for p in /data/local.prop /system/build.prop /system/bin/build.prop /system/etc/ram.conf; do
			if [ -f "$p" ]; then
				if [ "$opt" -eq 14 ] && [ ! -f "$p.unsuper" ] || [ "$opt" -le 13 ]; then
					if [ "$UnSuperCharged" -ne 1 ]; then
						echo " Cleaning ADJ values from ${p##*/}..."
						echo ""
						$sleep
					fi
					if [ ! "$HazEgg" ]; then
						sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d
								/.*_ADJ/d' $p
					fi
					if [ "$UnSuperCharged" -ne 1 ]; then
						echo " Cleaning MEM values from ${p##*/}..."
						echo ""
						$sleep
					fi
					if [ "$scminfree" ] && [ ! "$HazEgg" ]; then sed -i '/.*_MEM/d' $p; fi
				fi
			fi
		done 2>/dev/null
		if [ "`ls /system/etc/init.d/*SuperCharger*`" ]; then
			if [ "$opt" -eq 14 ] || [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ] && [ ! "$newsupercharger" ]; then
				echo " Cleaning Up SuperCharge from /init.d folder"
				echo ""
				$sleep
				echo " Cleaning Up Grouping Fixes from /init.d folder"
				echo ""
				$sleep
			fi
			if [ ! "$HazEgg" ]; then rm /system/etc/init.d/*SuperCharger*; fi
		fi 2>/dev/null
		if [ -f "/data/99SuperCharger.sh" ]; then
			if [ "$opt" -eq 14 ] || [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ] && [ ! "$newsupercharger" ]; then
				echo " Cleaning Up SuperCharge from /data folder"
				echo ""
				$sleep
				echo " Cleaning Up Grouping Fixes from /data folder"
				echo ""
				$sleep
			fi
			if [ ! "$HazEgg" ]; then rm /data/99SuperCharger.sh; fi
		fi
		if [ -f "/data/local/userinit.sh" ] && [ ! "$HazEgg" ]; then sed -i '/.*SuperCharger/d' /data/local/userinit.sh; fi
		if [ -f "/system/etc/hw_config.sh" ]; then
			if [ ! "$HazEgg" ]; then sed -i '/.*V6 SuperCharger/,/.*V6 SuperCharged/d' /system/etc/hw_config.sh; fi
			if [ "$UnSuperCharged" -ne 1 ] && [ ! "$newsupercharger" ]; then
				echo " Cleaning Up SuperCharge from hw_config.sh..."
				echo ""
				$sleep
			fi
		fi
		if [ "$opt" -eq 14 ]; then
			if [ ! "$HazEgg" ]; then
				rm -fr /data/V6_SuperCharger
				rm -f /data/*SuperCharger*
				rm -f /data/*BulletProof_Apps*
				rm -f /data/*_*\.log
				rm -f /system/etc/init.d/*BulletProof_Apps*
				rm -f /system/xbin/v6
				rm -f /system/xbin/99super
				rm -f /system/xbin/vac
				rm -f /system/xbin/zepalign
				rm -f /system/xbin/fixfc
				rm -f /system/xbin/fixalign
				rm -f /system/xbin/flush
				rm -f /system/xbin/sclean
				rm -f /system/etc/init.d/92vac
				rm -f /system/etc/init.d/93zepalign
				rm -f /system/etc/init.d/94fixfc
				rm -f /system/etc/init.d/95fixalign
				rm -f /system/etc/init.d/96superflush
			fi
			if [ "$UnSuperCharged" -ne 1 ]; then
				for p in /data/local.prop /system/build.prop /system/bin/build.prop /system/etc/hw_config.sh /system/etc/ram.conf; do
					if [ -f "$p.unsuper" ] && [ ! -s "$p.unsuper" ] && [ ! "$HazEgg" ]; then rm $p; rm $p.unsuper
					elif [ -f "$p.unsuper" ]; then
						echo " Restoring ORIGINAL ${p##*/}..."
						echo ""
						$sleep
						if [ ! "$HazEgg" ]; then mv $p.unsuper $p; fi
					fi
				done 2>/dev/null
				echo " Removed Kernel & Virtual Memory Tweaks..."
				echo ""
				$sleep
				if [ "$pyness" -ne 0 ]; then
					echo "            ...Removed Entropy-ness Enlarger..."
					echo ""
					$sleep
				fi
				if [ "$deduper" -ne 0 ]; then
					echo "              ...Removed Super Duper DeDuper..."
					echo ""
					$sleep
				fi
				if [ "$propaccessories" -eq 1 ]; then
					echo " ...Removed System Property Accessory Tweaks..."
					echo ""
					$sleep
				fi
				if [ "$tc3g" -eq 1 ]; then
					echo "      ...Removed 3G TurboCharger Enhancement..."
					echo ""
					$sleep
				fi
				if [ "$sdtweak" -gt 0 ]; then
					echo "              ...Removed SD Read Speed Tweak..."
					echo ""
					$sleep
				fi
				if [ "$UnSuperChargerError" -ne 1 ]; then
					echo " Your ROM's default minfree values are restored!"
					echo ""
					echo $line
				fi
				if [ ! "$servicesjarpatched" ]; then
					echo ""
					$sleep
					blurb_unsupercharge
					echo " REBOOT NOW..."
					echo ""
					$sleep
					echo "           ...FOR UNSUPERCHARGE TO TAKE EFFECT!"
					echo ""
				fi
				scminfree=;sccminfree=;scminfreeold=;bpapplist=;allrcbackups=;ran=0;minfrees=0
			fi
			if [ "$servicesjarpatched" ] && [ -f "$storage/V6_SuperCharger/services.jar.unsuper" ]; then UnIScream=yes; fi
		else
			if [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ]; then
				if [ "$opt" -eq 10 ]; then
					echo $line
					echo ""
					if [ "$restore" -eq 1 ]; then echo "     Restoring Prior Cust-OOMizer Settings!"
					else
						if [ "$sccminfree" ] && [ "$calculatorcharge" -eq 0 ]; then
							echo " Removing Prior Cust-OOMizer Settings..."
							echo ""
							$sleep
						fi
						if [ "$quickcharge" -eq 1 ]; then echo "      Saving Quick Cust-OOMizer Settings!"
						elif [ "$calculatorcharge" -eq 1 ]; then echo "   Applying SuperMinFree Calculator Settings!"
						elif [ "$revert" -eq 1 ]; then echo "        Reverting to Prior V6 Minfrees!"
						else echo "     Saving Your New Cust-OOMizer Settings!"
						fi
					fi
					if [ "$calculatorcharge" -eq 0 ]; then cp -fr /data/V6_SuperCharger/SuperChargerMinfree /data/V6_SuperCharger/SuperChargerCustomMinfree; fi
					echo ""
					$sleep
				fi
				echo $line
				if [ "$ReSuperCharge" -eq 1 ]; then echo "         Re-SuperCharging Performance!"
				else echo " SuperCharging Performance: $CONFIG!"
				fi
				echo $line
				echo ""
				$sleep
				echo " Out Of Memory (OOM) / lowmemorykiller values:"
				echo ""
				$sleep
				echo $currentminfree | awk -F, '{OFMT="%.0f"; print "    Old MB = "$1/256", "$2/256", "$3/256", "$4/256", "$5/256", "$6/256" MB"}'
				echo "    New MB = $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB"
				echo ""
				$sleep
				echo " Old Pages = "$currentminfree
				echo " New Pages = $scminfree"
				echo ""
				$sleep
			fi
			#
			# MFK Calculator (for min_free_kbytes) created by zeppelinrox.
			#
			slot=3
			MFK_Calculator
			echo $line
			echo " Make Foreground AND Background Apps STAY FAST!"
			echo $line
			echo ""
			$sleep
			echo " With The MFK Calculator!"
			echo " ========================"
			echo ""
			$sleep
			echo " Key Settings That Impact Typical Free RAM..."
			echo ""
			$sleep
			echo "         $SSADJ = Secondary Server ADJ"
			echo "         $slot = Secondary Server Slot"
			echo "        $((SSMF/256)) = Secondary Server LMK MB"
			echo ""
			$sleep
			echo $line
			echo " Balanced MFK Calculation Complete..."
			echo $line
			echo ""
			$sleep
			echo "      $MFK = Customized MFK (min_free_kbytes)"
			echo ""
			for rc in $initrcpath $rcpaths; do
				if [ "`grep -s "on early-boot" $rc`" ] && [ "$preics" ]; then sed -i '/on early-boot/ a\
    # V6 SuperCharger, OOM Grouping & Priority Fixes created by -=zeppelinrox=-' $rc
				else sed -i '/on boot/ a\
    # V6 SuperCharger, OOM Grouping & Priority Fixes created by -=zeppelinrox=-' $rc
				fi
				sed -i '/V6 SuperCharger/ a\
    # SuperMinFree Calculator & MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]\
    #\
    # See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article!\
    # See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why '"'Free RAM'"' Is NOT Wasted RAM!"\
    # See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.\
    #\
    # DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
    #\
    # BEGIN OOM_MEM_Settings\
    # END OOM_MEM_Settings\
    # BEGIN OOM_ADJ_Settings\
    # END OOM_ADJ_Settings\
    # End of V6 SuperCharged Entries.' $rc
				if [ "`grep -s "on early-boot" $rc`" ] && [ "$preics" ]; then sed -i '/on boot/ a\
      #################=##################' $rc
				else sed -i '/END OOM_ADJ_Settings/ a\
      #################=##################' $rc
				fi
				sed -i '/#=#/ a\
     #  Kernel & Virtual Memory Tweaks  #\
    ####################################\
    write /proc/sys/vm/min_free_kbytes '$MFK'\
    write /proc/sys/vm/oom_kill_allocating_task 0\
    write /proc/sys/vm/panic_on_oom 0\
    write /proc/sys/vm/vfs_cache_pressure 10\
    write /proc/sys/vm/overcommit_memory 1\
    write /proc/sys/vm/swappiness 20\
#   write /proc/sys/kernel/panic_on_oops '$kpoops'\
#   write /proc/sys/kernel/panic '$kpanic'\
#   write /proc/sys/kernel/random/write_wakeup_threshold 128\
#   write /proc/sys/kernel/random/read_wakeup_threshold 1376\
#   write /sys/block/mmcblk0/bdi/read_ahead_kb '$sdtweak'\
    # End of KVM Tweaks' $rc
				if [ "$panicmode" -gt 0 ]; then sed -i '/^#.*kernel\/panic/s/#/ /' $rc; fi
				if [ "$pyness" -ne 0 ]; then sed -i '/^#.*kernel\/random/s/#/ /' $rc; fi
				if [ "$sdtweak" -gt 0 ]; then sed -i '/^#.*bdi\/read_ahead_kb/s/#/ /' $rc; fi
				if [ "$preics" ]; then
					if [ "$scminfree" ]; then sed -i '/on boot/ a\
    write '$minfreefile' '$scminfree $rc
						sed -i '/BEGIN OOM_MEM_Settings/ a\
    setprop ro.FOREGROUND_APP_MEM '$SL1'\
    setprop ro.VISIBLE_APP_MEM '$SL2'\
    setprop ro.SECONDARY_SERVER_MEM '$SL3'\
    setprop ro.BACKUP_APP_MEM '$SL4'\
    setprop ro.HOME_APP_MEM '$SL3'\
    setprop ro.HIDDEN_APP_MEM '$SL4'\
    setprop ro.EMPTY_APP_MEM '$SL6 $rc
						if [ "$gb" -eq 1 ]; then sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.PERCEPTIBLE_APP_MEM '$SL0'\
    setprop ro.HEAVY_WEIGHT_APP_MEM '$SL3 $rc
						else sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.CONTENT_PROVIDER_MEM '$SL5 $rc
						fi
					fi
					sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/adj '$scadj $rc
					sed -i '/BEGIN OOM_ADJ_Settings/ a\
    setprop ro.FOREGROUND_APP_ADJ '$adj1'\
    setprop ro.VISIBLE_APP_ADJ '$adj2'\
    setprop ro.SECONDARY_SERVER_ADJ '$adj3'\
    setprop ro.BACKUP_APP_ADJ '$((adj3+1))'\
    setprop ro.HOME_APP_ADJ '$launcheradj'\
    setprop ro.HIDDEN_APP_MIN_ADJ '$((adj4-1))'\
    setprop ro.EMPTY_APP_ADJ '$adj6 $rc
					if [ "$gb" -eq 1 ]; then sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.PERCEPTIBLE_APP_ADJ '$((adj1+2))'\
    setprop ro.HEAVY_WEIGHT_APP_ADJ '$((adj2+1)) $rc
					else sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.CONTENT_PROVIDER_ADJ '$adj4 $rc
					fi
					$sleep
					echo $line
					echo -n " "
					if [ "$rc" = "$initrcpath" ] && [ "$initrc" -eq 0 ]; then echo -n "/data/"
					elif [ "$rc" = "$initrcpath" ]; then echo -n "/"
					fi
					if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ] && [ "$ReSuperCharge" -eq 0 ]; then echo "${rc##*/} has been OOM Fixed!"
					else echo "${rc##*/} has been SuperCharged!"
					fi
				else sed -i '/OOM_MEM_Settings/d
							 /BEGIN OOM_ADJ_Settings/ a\
    #\
    # This ROM (Android 4.0 and greater) requires a PATCHED services.jar\
    # If you don'"'"'t have it patched yet, go to http://goo.gl/IvGL1\
    # The ADJ priorities that were here DO NOT work anymore!\
    #' $rc
				fi
			done
			if [ "$preics" ]; then
				echo $line
				echo ""
				$sleep
				echo " Fixing Out Of Memory (OOM) Groupings..."
				echo ""
				$sleep
				echo "                    ...Fixing OOM Priorities..."
				echo ""
				$sleep
			fi
			for p in /system/etc/ram.conf $prop; do
				if [ -f "$p" ]; then
					echo "# V6 SuperCharger, OOM Grouping & Priority Fixes created by -=zeppelinrox=-" >> $p
					sed -i '/OOM Grouping/ a\
# SuperMinFree Calculator & MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]\
#\
# See http://goo.gl/krtf9 - Linux Memory Consumption - Nice article!\
# See http://goo.gl/hFdNO - Memory and SuperCharging Overview, or... "Why '"'Free RAM'"' Is NOT Wasted RAM!"\
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.\
#\
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
#\
# BEGIN OOM_MEM_Settings\
# END OOM_MEM_Settings\
# BEGIN OOM_ADJ_Settings\
# END OOM_ADJ_Settings\
# End of V6 SuperCharged Entries.' $p
					if [ "$p" = "/system/etc/ram.conf" ]; then sed -i '/END OOM_ADJ_Settings/ a\
LMK_ADJ="'$scadj'"\
LMK_MINFREE="'$scminfree'"' $p
					else sed -i '/END OOM_ADJ_Settings/ a\
  #######################\
 #  Accessory Tweaks!  #\
#######################\
# dalvik.vm.heapgrowthlimit='$heapgrowthlimit'm\
# dalvik.vm.heapsize='$heapsize'm\
# persist.sys.vm.heapsize='$heapsize'm\
# persist.sys.purgeable_assets=1\
# wifi.supplicant_scan_interval=180\
# windowsmgr.max_events_per_sec=90\
  ##################################\
 #  3G TurboCharger Enhancement!  #\
##################################\
# net.dns1=8.8.8.8\
# net.dns2=8.8.4.4\
# net.tcp.buffersize.default=6144,87380,110208,6144,16384,110208\
# net.tcp.buffersize.wifi=262144,524288,1048576,262144,524288,1048576\
# net.tcp.buffersize.lte=262144,524288,3145728,262144,524288,3145728\
# net.tcp.buffersize.hsdpa=6144,262144,1048576,6144,262144,1048576\
# net.tcp.buffersize.evdo_b=6144,262144,1048576,6144,262144,1048576\
# net.tcp.buffersize.umts=6144,87380,110208,6144,16384,110208\
# net.tcp.buffersize.hspa=6144,87380,262144,6144,16384,262144\
# net.tcp.buffersize.gprs=6144,8760,11680,6144,8760,11680\
# net.tcp.buffersize.edge=6144,26280,35040,6144,16384,35040' $p
						if [ ! "`getprop | grep heapgrowthlimit`" ]; then sed -i '/heapgrowthlimit/d' $p; fi
						if [ ! "`getprop | grep persist.sys.vm.heapsize`" ]; then sed -i '/persist.sys.vm.heapsize/d' $p; fi
						if [ "$propaccessories" -eq 1 ]; then sed -i '/Accessory Tweaks/,/max_events_per_sec/s/^# //' $p; fi
						if [ "$tc3g" -eq 1 ]; then sed -i '/TurboCharger Enhancement/,/edge=/s/^# //' $p; fi
					fi
					if [ "$preics" ]; then
						if [ "$scminfree" ]; then sed -i '/BEGIN OOM_MEM_Settings/ a\
ro.FOREGROUND_APP_MEM='$SL1'\
ro.VISIBLE_APP_MEM='$SL2'\
ro.SECONDARY_SERVER_MEM='$SL3'\
ro.BACKUP_APP_MEM='$SL4'\
ro.HOME_APP_MEM='$SL3'\
ro.HIDDEN_APP_MEM='$SL4'\
ro.EMPTY_APP_MEM='$SL6 $p
							if [ "$gb" -eq 1 ]; then sed -i '/ro.VISIBLE_APP_MEM/ a\
ro.PERCEPTIBLE_APP_MEM='$SL0'\
ro.HEAVY_WEIGHT_APP_MEM='$SL3 $p
							else sed -i '/ro.HIDDEN_APP_MEM/ a\
ro.CONTENT_PROVIDER_MEM='$SL5 $p
							fi
						fi
						sed -i '/BEGIN OOM_ADJ_Settings/ a\
ro.FOREGROUND_APP_ADJ='$adj1'\
ro.VISIBLE_APP_ADJ='$adj2'\
ro.SECONDARY_SERVER_ADJ='$adj3'\
ro.BACKUP_APP_ADJ='$((adj3+1))'\
ro.HOME_APP_ADJ='$launcheradj'\
ro.HIDDEN_APP_MIN_ADJ='$((adj4-1))'\
ro.EMPTY_APP_ADJ='$adj6 $p
						if [ "$gb" -eq 1 ]; then sed -i '/ro.VISIBLE_APP_ADJ/ a\
ro.PERCEPTIBLE_APP_ADJ='$((adj1+2))'\
ro.HEAVY_WEIGHT_APP_ADJ='$((adj2+1)) $p
						else sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
ro.CONTENT_PROVIDER_ADJ='$adj4 $p
						fi
					else sed -i '/OOM_MEM_Settings/d
								 /BEGIN OOM_ADJ_Settings/ a\
#\
# This ROM (Android 4.0 and greater) requires a PATCHED services.jar\
# If you don'"'"'t have it patched yet, go to http://goo.gl/IvGL1\
# The ADJ priorities that were here DO NOT work anymore!\
#' $p
					fi
				fi
			done 2>/dev/null
			if [ "$preics" ]; then
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				$sleep
				echo $line
				if [ "$launcheradj" -eq 0 ]; then
					echo ""
					echo " Applied BulletProof Launcher..."
					echo ""
					$sleep
					echo " Launcher is not only SuperCharged..."
					echo ""
					$sleep
					echo $line
					echo "                           ...It's BULLETPROOF!"
				elif [ "$launcheradj" -eq 2 ]; then echo "         Hard To Kill Launcher APPLIED!"
				else echo "           Die-Hard Launcher APPLIED!"
				fi
				if [ "$homeadj" -ne "$launcheradj" ]; then newlauncher=1; fi
			fi
			echo $line
			echo ""
			$sleep
			echo " Applying Kernel & Virtual Memory Tweaks..."
			echo ""
			$sleep
			echo -n "                    ";busybox sysctl -w vm.min_free_kbytes=$MFK
			Apply_KVM_Tweaks
			if [ "$propaccessories" -eq 1 ]; then
				Apply_Accessories
				echo $line
				echo ""
				$sleep
			fi
			if [ "$tc3g" -eq 1 ]; then
				Apply_3G_TCE
				echo $line
				echo ""
				$sleep
			fi
			if [ "$sdtweak" -gt 0 ]; then
				Apply_SD_Speed
				echo $line
				echo ""
				$sleep
			fi
			Re_Generate_99SuperCharger
			echo "                  GEEK ALERT!!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo " \"Start Up Script\" to be copied to /system/xbin!"
			echo "  ==============="
			echo ""
			$sleep
			echo " If need be, you can run it quick and easy..."
			blurb_Terminal 99super =======
			echo ""
			$sleep
			if [ ! -f "/system/xbin/99super" ] || [ "`diff /data/99SuperCharger.sh /system/xbin/99super`" ]; then
				info_free_space_error /system/xbin 99super
				echo ""
			fi
			echo $line
			echo ""
			$sleep
			if [ -f "/system/etc/hw_config.sh" ]; then
				echo " SuperCharging /system/etc/hw_config.sh..."
				echo ""
				echo $line
				echo ""
				$sleep
			fi
			if [ -d "/system/etc/init.d" ]; then
				if [ "$rcpaths" ] && [ "$initrc" -eq 1 ]; then
					echo " For Super Stickiness..."
					echo ""
					$sleep
				fi
				echo " SuperCharging /system/etc/init.d folder..."
				echo ""
				$sleep
				if [ ! "`diff /data/99SuperCharger.sh $desiredname`" ]; then
					if [ "$desiredname" = "/system/etc/init.d/99SuperCharger" ]; then echo -n "  "
					elif [ "$desiredname" = "/system/etc/init.d/S99SuperCharger" ]; then echo -n " "
					fi
					echo "   ...with $desiredname!"
					echo ""
					$sleep
					echo " If it successfully runs on boot..."
					echo ""
					$sleep
					echo " .../data/BootLog_SuperCharger.log is created!"
				else info_free_space_error init.d `basename $desiredname`
				fi
				if [ "`ls /system/etc/init.d/*oopy*`" ] && [ /system/etc/init.d/*oopy* != "/system/etc/init.d/zzloopy_runs_last_so_others_do_too" ]; then
					echo ""
					echo $line
					echo ""
					$sleep
					echo " Found `ls /system/etc/init.d/*oopy*`..."
					echo ""
					$sleep
					echo " ...it stops other init.d scripts from running!"
					echo ""
					$sleep
					echo " Renaming it to..."
					echo ""
					$sleep
					echo "   ...\"zzloopy_runs_last_so_others_do_too\" lol!"
					echo ""
					$sleep
					mv "/system/etc/init.d/*oopy*" /system/etc/init.d/zzloopy_runs_last_so_others_do_too
					sed -i '1 a\
#\
# Hey you should try BulletProofing Apps from within V6 SuperCharger instead!\
#' /system/etc/init.d/zzloopy_runs_last_so_others_do_too
					echo " But it's better to just delete it..."
					echo ""
					$sleep
					echo "       ...and from the Driver's Console..."
					echo ""
					$sleep
					echo "                 ...\"BulletProof Apps\" instead!"
				fi 2>/dev/null
				echo ""
			else
				echo " Stock ROM? - Additional Configuration Required!"
				echo ""
				$sleep
				echo " You have no /system/etc/init.d folder..."
				echo ""
				$sleep
				echo $line
				echo "    ...so instead, use /data/99SuperCharger.sh!"
				echo $line
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
					echo -n " Some Changes are TEMPORARY & "
					if [ "$allrcpaths" ]; then echo "MAY NOT PERSIST!"
					else echo "WON'T PERSIST!"
					fi
					echo ""
					$sleep
					echo " To enable PERSISTENT SuperCharger settings...."
					echo ""
					$sleep
					echo "                   ...and OOM Grouping Fixes..."
				else echo " To enable PERSISTENT OOM Grouping Fixes..."
				fi
				echo ""
				$sleep
				if [ "$allrcpaths" ]; then
					echo "       ...The SuperCharger Service should work!"
					echo ""
					$sleep
					echo " BUT if it doesn't..."
					echo ""
					$sleep
				fi
				if [ "$smrun" ]; then
					SuperChargerScriptManagerHelp=1
					cat > $storage/SuperChargerScriptManagerHelp.html <<EOF
Yay! You already have <a href="http://play.google.com/store/apps/details?id=os.tools.scriptmanager">Script Manager!</a><br>
After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, enable "Browse as Root."<br>
Press the menu key and then Browser.<br>
Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" (ie. SuperUser) and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
<br>
Another option is to make a Script Manager widget for <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically ;^]<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://goo.gl/qM6yR">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
					echo " Use THIS app to make a \"Quick Widget\" for..."
					echo ""
					$sleep
					echo "                    .../data/99SuperCharger.sh!"
					echo ""
					$sleep
					echo " Or use it to load 99SuperCharger.sh on boot!"
					echo ""
					$sleep
					echo " OR, as per the \"Geek Alert\" mentioned above..."
					echo ""
					$sleep
					echo " ...use Terminal Emulator & do \"su -c 99super\"!"
					echo "                                ============="
					echo ""
					$sleep
					echo $line
					echo " See $storagename/SuperChargerScriptManagerHelp.html"
				else
					echo " ..Please ENABLE boot scripts to be run from..."
					echo "                  .../system/etc/init.d folder!"
					echo " Easier: Script Manager can solve everything ;)"
					echo ""
					$sleep
					echo " But for now... "
					echo ""
					$sleep
					echo "  ...as per the \"Geek Alert\" mentioned above..."
					echo ""
					$sleep
					echo " ...use Terminal Emulator & do \"su -c 99super\"!"
					echo "                                ============="
					echo ""
					$sleep
					SuperChargerHelp=1
					cat > $storage/SuperChargerHelp.html <<EOF
To enable init.d boot scripts, go <a href="http://goo.gl/rZTyW">HERE</a><br>
This is for Motorolas! At least some of them anyway.<br>
If that page is incompatible with your phone, do some reasearch!<br>
<br>
A very nice and easy solution is to simply use<br>
Script Manager to load scripts on boot - on ANY ROM!<br>
Here is the <a href="http://play.google.com/store/apps/details?id=os.tools.scriptmanager">Google Play Link</a><br>
So first, you use Script Manager to run the V6 SuperCharger script.<br>
Then use it again to load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the 99SuperCharger.sh properties dialogue box, check "Run as root" (ie. SuperUser) and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
<br>
Another option is to make a Script Manager widget for <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically ;^]<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://goo.gl/qM6yR">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
					echo $line
					echo "See $storagename/SuperChargerHelp.htm for more help!"
				fi
			fi
			echo $line
			if [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ]; then
				if [ "$allrcpaths" ] && [ ! "$scsinfo" ]; then
					if [ -d "/system/etc/init.d" ]; then
						echo ""
						$sleep
						echo " And for added, Auto Insurance..."
						echo ""
						$sleep
						echo $line
					fi
					if [ ! "$scservice" ]; then echo " Installing SuperCharger Service to..."
					else echo " SuperCharger Service had been installed to..."
					fi
					echo $line
					echo ""
					$sleep
				fi
				install_sc_service
				if [ "$allrcpaths" ] && [ ! "$scsinfo" ]; then
					echo ""
					echo $line
					echo ""
					$sleep
					echo " You can leave the service on by either..."
					echo ""
					$sleep
					echo " ...reading comments in /data/99SuperCharger.sh"
					echo ""
					$sleep
					echo " Or... Run Terminal Emulator..."
					echo ""
					$sleep
					echo "              ...type \"su\" and Enter..."
					echo "                       =="
					echo ""
					$sleep
					echo "       ...type \"start super_service\" and Enter."
					echo "                ==================="
					echo ""
					$sleep
					echo " To stop the SuperCharger Service..."
					echo ""
					$sleep
					echo "        ...type \"stop super_service\" and Enter."
					echo "                 =================="
					echo ""
					echo $line
					echo ""
					$sleep
					echo " If the service is running and you type..."
					echo ""
					$sleep
					echo "           ...\"grep -h [S]uper /proc/*/cmdline\""
					echo ""
					$sleep
					echo " The output would be \"/data/99SuperCharger.sh\""
					echo ""
					echo $line
					echo ""
					$sleep
					echo " Easier: Similar results can be had with..."
					echo ""
					$sleep
					echo "                 ...\"busybox ps | grep [S]uper\""
					echo ""
					echo $line
				elif [ ! "$allrcpaths" ] && [ ! "$scsinfo" ]; then
					echo $line
					echo "    SuperCharger Service Entries Installed!"
					echo $line
					echo ""
					$sleep
					echo " This won't work on this ROM but... "
					echo ""
					$sleep
					echo "       ...it makes for easy cooking into a ROM!"
					echo ""
					$sleep
					echo " Just read the comments in $initrcpath :)"
					echo ""
					echo $line
				fi
				echo ""
				$sleep
				echo " Setting LowMemoryKiller to..."
				echo ""
				$sleep
				echo "         ...$MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB"
				echo ""
				$sleep
				echo "$scminfree" > $minfreefile
				currentminfree=`cat $minfreefile`
				echo " OOM Minfree levels are now set to..."
				echo ""
				$sleep
				echo "         ..."$currentminfree
				echo ""
				if [ "$newlauncher" -eq 0 ]; then
					$sleep
					echo $line
					echo "      SUPERCHARGE IN EFFECT IMMEDIATELY!!"
				fi
				echo $line
				echo ""
				$sleep
				PowerShiftScript="$CONFIG-($MB1,$MB2,$MB3,$MB4,$MB5,$MB6)-PowerShift.sh"
				Re_Generate_PowerShift_Script "$PowerShiftScript"
				echo " A PowerShift Script was saved as..."
				echo ""
				$sleep
				echo " $PowerShiftScript!"
				echo ""
				$sleep
				echo " Goto data/V6_SuperCharger/PowerShift_Scripts.."
				echo ""
				$sleep
				echo "             ...make a \"Quick Widget\" for it..."
				echo ""
				$sleep
				echo "            ...and PowerShift between settings!"
				echo ""
				$sleep
				echo "  They'll also be your new SuperCharger values!"
				echo ""
				echo $line
				scsinfo=shown
			fi
			if [ "$adjfile" = "/sys/module/lowmemorykiller/parameters/adj" ]; then echo "$scadj" > $adjfile; fi
			if [ "$newlauncher" -eq 1 ]; then
				$sleep
				echo "           LAUNCHER CHANGE DETECTED!"
				echo $line
				echo ""
				$sleep
				echo " REBOOT NOW TO ENABLE..."
				echo ""
				$sleep
				if [ "$launcheradj" -eq 0 ]; then echo "          ...BULLETPROOF LAUNCHER..."
				elif [ "$launcheradj" -eq 2 ]; then echo "         ...HARD TO KILL LAUNCHER..."
				else echo "             ...DIE-HARD LAUNCHER..."
				fi
				echo ""
				$sleep
				echo "                     ...AND OOM GROUPING FIXES!"
				echo ""
				$sleep
				echo $line
			fi
			if [ "$SuperChargerHelp" -eq 1 ]; then
				$sleep
				echo " RUN /data/99SuperCharger.sh AFTER EACH REBOOT!"
			elif [ "$SuperChargerScriptManagerHelp" -eq 1 ]; then
				$sleep
				echo " DON'T FORGET to have Script Manager load..."
				echo "            .../data/99SuperCharger.sh on boot!"
				echo "     ...or make a Script Manager WIDGET for it!"
			elif [ "$opt" -le 10 ] || [ "$postics" ] || [ "$ReSuperCharge" -eq 1 ]; then
				$sleep
				if [ "$ReSuperCharge" -eq 1 ]; then echo -n " Restored"
				else echo -n "$CONFIG"
				fi
				echo " Settings WILL PERSIST after reboot!"
				echo $line
				echo ""
				$sleep
				echo " If they don't persist, read the Owner's Guide!"
				echo ""
			else
				echo ""
				$sleep
				echo " If OOM Fixes are't in effect after a reboot..."
				echo ""
				$sleep
				echo "                 ...and the Launcher is weak..."
				echo ""
				$sleep
				echo "                     ...read the Owner's Guide!"
				echo ""
			fi
			echo $line
			echo ""
			$sleep
			echo " SO... you know if it works or not by..."
			echo ""
			$sleep
			echo " ...READING THE INFO Under The Driver's Console!"
			echo ""
			$sleep
			echo $line
			echo " PLEASE: READ THE ABOVE MESSAGES BEFORE ASKING!"
			echo $line
			echo ""
			$sleep
			echo "   Because I may SNAP and call you names! ;^]"
			echo ""
			$sleep
			echo " And I'll likely add you to my IGNORE list..."
			echo ""
			$sleep
			echo " ...because you think it's OK to WASTE MY TIME!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
			echo ""
			if [ "$opt" -le 10 ] || [ "$ReSuperCharge" -eq 1 ] || [ "$postics" ]; then ran=1; fi
			if [ -f "$initrcpath" ] && [ "$initrc" -eq 1 ]; then cp -fr $initrcpath $initrcpath1; fi
			if [ -f "/system/bin/build.prop" ]; then cp -frp /system/build.prop /system/bin; fi
			echo " Backing up refreshed files to $storagename..."
			echo ""
			$sleep
			if [ -d "/data/V6_SuperCharger" ]; then cp -fr /data/V6_SuperCharger $storage/V6_SuperCharger/data; fi
			for rc in $initrcpath $allrcpaths; do
				mkdir $storage/V6_SuperCharger`dirname $rc` 2>/dev/null
				cp -fr $rc* $storage/V6_SuperCharger`dirname $rc`
			done
			cp -fr $storage/V6_SuperCharger/data/init* $storage/V6_SuperCharger
			if [ -f "/data/local.prop" ]; then cp -fr /data/local.prop* $storage/V6_SuperCharger/data; fi
			if [ -f "/system/build.prop" ]; then cp -fr /system/build.prop* $storage/V6_SuperCharger/system; fi
			if [ -f "/system/etc/ram.conf" ]; then cp -fr /system/etc/ram.conf* $storage/V6_SuperCharger/system/etc; fi
			echo "            ...Re-SuperCharger backup complete!"
			echo ""
			if [ "$newsupercharger" ] || [ "$postics" ]; then
				if [ "$preics" ]; then opt=34
					echo $line
					if [ "$autoresupercharge" ] || [ "$ReSuperCharge" -eq 1 ]; then
						script_version_check
						echo ""
						$sleep
						echo " Re-SuperCharger is ALMOST done!"
					else
						echo ""
						$sleep
						echo " I think this is your FIRST SuperCharge..."
					fi
					echo ""
					$sleep
				elif [ "$servicesjarpatched" ] || [ "$servicesjarinstalled" ]; then
					echo $line
					echo "             I Scream SUPERCHARGED!"
				elif [ ! "$showedparlor" ]; then opt=27
					echo $line
					echo ""
					$sleep
					echo " Now off to the \"Jelly ISCream Parlor\"..."
					echo ""
					$sleep
				fi
				autoresupercharge=
			fi
		fi
	fi
	if [ "$opt" -eq 15 ]; then
		echo "             Does Your OOM Stick?!"
		echo "             ====================="
		echo ""
		$sleep
		echo " Find Out Here... AND Find Your Home Launcher!!"
		echo ""
		$sleep
		echo " Choose from 2 bitchin' OOM Sticks..."
		echo ""
		$sleep
		echo " zOOM Stick (Quick) Mode is faster..."
		echo ""
		$sleep
		echo " ...it shows App Name, Priority (ADJ), and PID!"
		echo ""
		$sleep
		echo " vrOOM Stick (Verbose) mode is slower..."
		echo ""
		$sleep
		echo "         ...but adds Path and/or Apk file info!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Do you want vrOOM or zOOM Stick mode?"
		echo ""
		$sleep
		echo -n " Enter V for vrOOM, any key for zOOM: "
		read chooseverifier
		echo ""
		echo $line
		case $chooseverifier in
		  v|V)echo " vrOOM Stick Verifier (Verbose) selected..."
			  boomstick=vrOOM;;
			*)echo " zOOM Stick Verifier (Quick) selected..."
			  boomstick=zOOM;;
		esac
		echo $line
		bOOM_Stick $boomstick
	fi
	if [ "$opt" -eq 16 ]; then
		if [ "$bpapplist" ] && [ "`busybox ps | grep [B]ulletProof`" ]; then
			echo " You are currently BulletProofing..."
			echo ""
			$sleep
			for bpapp in $bpapplist; do echo "          $bpapp"; done
			echo ""
			echo $line
			$sleep
			echo " Note you can merely DISABLE this in Options..."
			echo ""
			$sleep
			echo "                    ...or in the script itself!"
			echo $line
			echo ""
			$sleep
			echo " ANYWAY... if you want to..."
			echo ""
			$sleep
			echo " Un-BulletProof Previously BulletProofed Apps?"
			echo ""
			$sleep
			echo " You can Un-BulletProof All or Individually ;^]"
			echo ""
			$sleep
			echo " \"One-Shot\" scripts will remain untouched..."
			echo ""
			$sleep
			echo -n " Enter Y for Yes, any key for No: "
			read unbp
			echo ""
			echo $line
			case $unbp in
			  y|Y)while :; do
					echo ""
					$sleep
					echo -n " Un-BulletProof (A)ll (I)ndividually E(X)it? "
					read unbpopt
					echo ""
					echo $line
					case $unbpopt in
					  a|A)rm -f /data/V6_SuperCharger/BulletProof_Apps*
						  rm -f /data/*BulletProof_Apps*
						  rm -f /system/etc/init.d/*BulletProof_Apps*
						  echo "           Un-BulletProofed ALL Apps!"
						  bpapplist=; opt=15
						  break;;
					  i|I)for unbpapp in $bpapplist; do
							echo ""
							$sleep
							echo " Un-Bulletproof $unbpapp?"
							echo ""
							echo -n " Enter Y for Yes, any key for No: "
							read unbpone
							echo ""
							echo $line
							case $unbpone in
							  y|Y)sed -i '/Begin '$unbpapp'/,/End '$unbpapp'/d' /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh
								  sed -i '/'$unbpapp'/d' /data/V6_SuperCharger/BulletProof_Apps_HitList
								  echo " Un-BulletProofed $unbpapp!"
								  echo $line;;
							    *);;
							esac
						  done
						  bpapplist=`cat /data/V6_SuperCharger/BulletProof_Apps_HitList`
						  echo ""
						  $sleep
						  echo " Here's Your Updated HitList!"
						  echo ""
						  $sleep
						  for bpapp in $bpapplist; do echo "          $bpapp"; done
						  echo ""
						  showedbpapplist=yes; opt=15
						  break;;
					  x|X)echo "       Ok... let's BulletProof something!"
						  break;;
						*)echo "      Invalid entry... Please try again :p"
						  echo $line;;
					esac
				  done;;
				*)echo "                   Cool Beans!";;
			esac
			if [ "$opt" -eq 16 ]; then
				echo $line
				echo ""
				$sleep
			fi
		fi 2>/dev/null
		if [ "$opt" -eq 16 ]; then
			blurb_BulletProof_Apps
			echo " To undo, come back here to \"Un-Bulletproof\"!"
			echo ""
			$sleep
			echo " Do you want to view the current process list?"
			echo ""
			$sleep
			echo " You can BulletProof Apps without viewing it!"
			echo ""
			$sleep
			install_bp_service
			Re_Generate_97BulletProof_Apps
			Re_Generate_BulletProof_Apps_Fine_Tuner
			echo -n " Enter N for No, any key for Yes: "
			read bp
			echo ""
			echo $line
			case $bp in
			  n|N)echo " Okay... I hope you know what process to enter!"
				  echo $line
				  echo ""
				  $sleep;;
				*)echo " Loading zOOM Stick Verifier (Quick)..."
				  echo $line
				  boomstick=zOOM
				  bOOM_Stick;;
			esac
			while :; do
			  bpps=;bppid=;bpappname=;apprunning=;addedtohitlist=;addedtofinetuner=
			  if [ ! "$bptips" ]; then
				echo " Ideas: BulletProof the Phone, Media or SMS App!"
				echo ""
				$sleep
				if [ "$postics" ] && [ ! "$servicesjarpatched" ]; then
					echo $line
					echo " POST-ICS TIP! Try BulletProofing The Launcher!"
					echo $line
					echo ""
					$sleep
				fi
				bptips=shown
			  fi
			  echo " Enter a unique segment of the process name..."
			  echo ""
			  $sleep
			  echo " Example: \"Opera\" for Opera Browser..."
			  echo ""
			  $sleep
			  echo -n " Or press the Enter key to exit: "
			  read bpps
			  echo ""
			  echo $line
			  if [ ! "$bpps" ]; then
				echo " Okay... See Ya Later! ;^]"
				break
			  else
				if [ ! "`pgrep $bpps`" ]; then
					echo " Can't find $bpps running..."
					echo ""
					$sleep
					echo "             ...so it can't be BulletProofed :("
					echo $line
					echo ""
					$sleep
					echo " Tip: You can manually edit/add apps to..."
					echo ""
					$sleep
					echo " /data/V6_SuperCharger/BulletProof_Apps_HitList!"
					bpappname=$bpps
				else bppid=`pgrep $bpps`; apprunning=true
					if [ -f "/proc/$bppid/cmdline" ]; then bpappname=$(basename `cat /proc/$bppid/cmdline`)
					else
						echo ""
						echo " Grrrr... there's more than one match!"
						echo ""
						for bphit in `pgrep $bpps`; do
							$sleep
							if [ "`cat /proc/$bphit/cmdline`" ]; then
								bpappnametemp=$(basename `cat /proc/$bphit/cmdline`)
								echo -n " Want $bpappnametemp? (Y)es or E(N)ter: "
								read pick
								case $pick in
								  y|Y)bpappname=$bpappnametemp;;
									*)echo "";;
								esac
							fi
							if [ "$bpappname" ]; then break; fi
						done
					fi 2>/dev/null
				fi
				if [ "$bpappname" ]; then bpappname=${bpappname%:*}
					echo ""
					echo $line
					if [ "$apprunning" ]; then
						echo ""
						$sleep
						if [ "$bpappname" = "$lname" ] && [ "$oomstick" -eq 1 ]; then
							echo " LOL WUT!? The Launcher is ALREADY SuperCharged!"
							echo ""
							$sleep
							echo " You still want to use BulletProof Apps for it?"
							echo ""
							$sleep
							echo -n " Enter Y for Yes, any key for No: "
							read bpl
							echo ""
							echo $line
							case $bpl in
							  y|Y)echo " Wow... I don't think you \"get it\"... LOL";;
								*)echo " Awww... I wanted to make fun of you!"
								  break;;
							esac
							echo $line
							echo ""
							$sleep
						fi
						echo " BulletProofing $bpappname..."
						echo ""
						$sleep
						echo "-17" > /proc/`pgrep $bpps`/oom_adj
						echo "-1000" > /proc/`pgrep $bpps`/oom_score_adj
						renice -10 `pgrep $bpps`
						echo " $bpappname has been BulletProofed!"
						echo ""
						$sleep
						echo " $bpappname's oom score is `cat /proc/`pgrep $bpps`/oom_score`"
						echo ""
						$sleep
						echo -n " $bpappname's oom priority is "
						if [ -f "/proc/`pgrep $bpps`/oom_adj" ]; then cat /proc/`pgrep $bpps`/oom_adj
						else cat /proc/`pgrep $bpps`/oom_score_adj
						fi
						echo ""
						echo $line
					fi 2>/dev/null
					if [ "`ls /data/V6_SuperCharger/BulletProof_One_Shots | grep $bpappname`" ]; then
						$sleep
						echo " Existing \"One-Shot\" Script To Be Updated! :o)"
						echo $line
					fi 2>/dev/null
					echo ""
					$sleep
					Re_Generate_BulletProof_1Shot $bpappname
					blurb_was_created " Script 1Shot-$bpappname.sh in..." "..data/V6_SuperCharger/BulletProof_One_Shots..."
					if [ ! "$bpwinfo" ]; then
						blurb_Quick_Widget
						$sleep
						echo " OR, with Terminal Emulator..."
						echo ""
						$sleep
						echo " ...you can quickly run ALL \"One-Shot\" scripts!"
						echo ""
						$sleep
						echo " Type: \"su\" and enter..."
						echo "        =="
						echo ""
						$sleep
						echo " \"/data/V6*/Bullet*/1Shot*\" and enter!"
						echo "  ========================"
						echo ""
						$sleep
						echo "                  THAT'S IT!"
						echo ""
						$sleep
						echo $line
						echo "    NOTE: DO NOT put it on a timed schedule!"
						echo $line
						echo ""
						$sleep
						echo " Just launch it... wait \"xx\" seconds and..."
						echo ""
						$sleep
						echo "  ...the script will relaunch then kill itself!"
						echo ""
						$sleep
						echo " You can then close the app and..."
						echo ""
						$sleep
						echo "   ...the BulletProof \"One-Shot\" keeps running!"
						echo ""
						$sleep
						echo " You can change how often a 1Shot script runs.."
						echo ""
						$sleep
						echo "                 ...by changing the \"xx\" value!"
						echo ""
						$sleep
						echo " To tweak this value (default is 30 seconds)..."
						echo ""
						$sleep
						echo $line
						echo "      READ THE COMMENTS inside the script!"
						bpwinfo=shown
					fi
					if [ ! "$bpainfo" ]; then
						echo $line
						echo ""
						$sleep
						echo " To see if it's working..."
						echo ""
						$sleep
						echo "        ...in Terminal Emulator, you can type..."
						echo ""
						$sleep
						echo " \"pstree | grep 1Shot\" OR \"pstree | grep sleep\""
						echo ""
						$sleep
						echo " OR... get COMPLETE information with..."
						echo ""
						$sleep
						echo "          ...\"grep -h [1]Shot /proc/*/cmdline\"!"
						echo ""
						$sleep
						echo " The output should look like this:"
						echo ""
						$sleep
						echo "    /path/to/1Shot-$bpappname.sh"
						echo "    1Shot-$bpappname is In Effect!"
						echo ""
						echo $line
						echo ""
						$sleep
						echo " Easier: Similar results can be had with..."
						echo ""
						$sleep
						echo "                 ...\"busybox ps | grep [1]Shot\""
						echo ""
						echo $line
						echo ""
						$sleep
						echo " The *97BulletProof_Apps Boot Script loads..."
						echo ""
						$sleep
						echo " /data/V6_SuperCharger/BulletProof_Apps_HitList."
						echo ""
						$sleep
						echo $line
						echo " Tip: Manually trim or add apps to this list!"
						echo $line
						echo ""
						$sleep
						echo " If it DOESN'T run automatically..."
						echo "       ======="
						echo ""
						$sleep
						echo " Script Manager can be used a couple of ways ;)"
						echo ""
						$sleep
						echo " Use it to make a \"Quick Widget\" for..."
						echo ""
						$sleep
						echo "                 .../data/97BulletProof_Apps.sh!"
						echo ""
						$sleep
						echo " Or make it load 97BulletProof_Apps.sh on boot!"
						echo ""
						$sleep
						echo " OR, for LESS overhead... use Terminal Emulator!"
						echo ""
						$sleep
						echo " Type: \"su\" and enter, \"/data/97*\" and enter!"
						echo "        ==              ========="
						echo ""
						$sleep
						echo "                  THAT'S IT!"
						echo ""
						$sleep
						echo $line
						echo "    NOTE: DO NOT put it on a timed schedule!"
						echo $line
						echo ""
						$sleep
						echo " Just launch it... wait $bpwait seconds and..."
						echo ""
						$sleep
						echo "  ...the script will relaunch then kill itself!"
						echo ""
						$sleep
						echo " You can then close the app and..."
						echo ""
						$sleep
						echo "  ...the BulletProof Apps script keeps running!"
						echo ""
						echo $line
						echo ""
						$sleep
						echo " Also, in the /data/V6_SuperCharger folder..."
						echo ""
						$sleep
						echo "         ...find BulletProof_Apps_Fine_Tuner.sh"
						echo ""
						$sleep
						echo $line
						echo " Read its notes and \"Fine Tune\" App Priorities!"
						bpainfo=shown
					fi
					if [ "$bpapplist" ] && [ ! "$showedbpapplist" ]; then
						echo $line
						echo ""
						$sleep
						echo " You are already BulletProofing..."
						echo ""
						$sleep
						for bpapp in $bpapplist; do echo "          $bpapp"; done
						showedbpapplist=
					fi
					echo $line
					if [ "`echo $bpapplist | grep $bpappname`" ]; then
						$sleep
						echo " $bpappname's on the Hit List! ;^]"
					else
						$sleep
						echo " Add $bpappname to the HitList?"
						echo ""
						$sleep
						echo -n " Enter Y for Yes, any key for No: "
						read bpabs
						echo ""
						case $bpabs in
						  y|Y)echo $bpappname >> /data/V6_SuperCharger/BulletProof_Apps_HitList
							  echo $bpappname >> $storage/V6_SuperCharger/data/V6_SuperCharger/BulletProof_Apps_HitList
							  bpapplist=`cat /data/V6_SuperCharger/BulletProof_Apps_HitList`
							  addedtohitlist=yes;;
							*)echo $line
							  echo " Okay... maybe next time!";;
						esac
					fi
					if [ "`grep $bpappname /data/V6_SuperCharger/BulletProof_Apps_Fine_Tuner.sh`" ]; then
						echo $line
						echo ""
						$sleep
						echo " Overwrite your prior Fine Tune Setting for it?"
						echo ""
						$sleep
						echo -n " Enter Y for Yes, any key for No: "
						read bpaft
						echo ""
						case $bpaft in
						  y|Y)addedtofinetuner=yes;;
							*);;
						esac
					else addedtofinetuner=yes
					fi
					if [ "$addedtofinetuner" ]; then
						echo $line
						echo ""
						$sleep
						echo " Updating BulletProof_Apps_Fine_Tuner.sh..."
						echo ""
						Re_Generate_BulletProof_Fine_Tunes $bpappname
					fi
					if [ "$addedtohitlist" ]; then
						echo $line
						echo ""
						$sleep
						echo " Here's Your Updated HitList!"
						echo ""
						$sleep
						for bpapp in $bpapplist; do echo "          $bpapp"; done
						echo ""
						if [ ! "$bpsinfo" ]; then
							echo $line
							echo ""
							$sleep
							echo " BulletProof_Apps_HitList will be loaded via..."
							echo ""
							$sleep
							if [ -d "/system/etc/init.d" ] && [ ! "`diff /data/97BulletProof_Apps.sh $bpname`" ]; then echo "     ...$bpname"
							elif [ -d "/system/etc/init.d" ]; then info_free_space_error init.d `basename $bpname`
							else echo "                .../data/97BulletProof_Apps.sh!"
							fi
							echo ""
							$sleep
							echo $line
							echo " Is it working? See /data/Ran_BulletProof_Apps!"
							echo $line
							echo ""
							$sleep
							echo " Or... in Terminal Emulator, you can type..."
							echo ""
							$sleep
							echo " \"pstree | grep Bullet\" OR \"pstree | grep sleep\""
							echo ""
							$sleep
							echo " OR... get COMPLETE information with..."
							echo ""
							$sleep
							echo "          ...\"grep -h [B]ullet /proc/*/cmdline\"!"
							echo ""
							$sleep
							echo " The output should look like this:"
							echo ""
							$sleep
							echo "      /path/to/*97BulletProof_Apps*"
							echo "      BulletProof Apps is In Effect!"
							echo ""
							echo $line
							echo ""
							$sleep
							echo " Easier: Similar results can be had with..."
							echo ""
							$sleep
							echo "                ...\"busybox ps | grep [B]ullet\""
							echo ""
						fi
						if [ "$allrcpaths" ] && [ ! "$bpsinfo" ]; then
							echo $line
							echo ""
							$sleep
							echo " The BulletProof Apps Service should..."
							echo ""
							$sleep
							echo "       ...automatically run this on a schedule!"
							echo ""
							$sleep
							echo " BUT if it doesn't, just be sure that..."
							echo ""
							$sleep
							echo " ...the *97BulletProof_Apps script runs at boot!"
							echo ""
							$sleep
							echo $line
							echo " BulletProof Apps Service was installed to..."
							echo $line
							echo ""
							$sleep
							for bps in $allrcpaths; do
								echo "   ...$bps!"
								if [ ! "$bpservice" ]; then $sleep; fi
							done
							echo ""
							echo $line
							echo ""
							$sleep
							echo " You can stop the service by either..."
							echo ""
							$sleep
							echo "   ...reading comments in 97BulletProof_Apps.sh"
							echo ""
							$sleep
							echo " Or... Run Terminal Emulator..."
							echo ""
							$sleep
							echo "              ...type \"su\" and Enter..."
							echo "                       =="
							echo ""
							$sleep
							echo "       ...type \"stop bullet_service\" and Enter."
							echo "                ==================="
							echo ""
							$sleep
							echo " To restart the BulletProof Apps Service..."
							echo ""
							$sleep
							echo "       ..type \"start bullet_service\" and Enter."
							echo "               ===================="
							echo ""
							echo $line
							echo ""
							$sleep
							echo " \"grep -h [B]ullet /proc/*/cmdline\"..."
							echo ""
							$sleep
							echo "    ...OR... \"busybox ps | grep [B]ullet\"..."
							echo ""
							$sleep
							echo "   ...will also show if the service is running!"
							echo ""
						elif [ ! "$allrcpaths" ] && [ ! "$bpsinfo" ]; then
							echo $line
							$sleep
							echo " BulletProof Apps Service Entries Installed!"
							echo $line
							echo ""
							$sleep
							echo " This won't work on this ROM but... "
							echo ""
							$sleep
							echo "       ...it makes for easy cooking into a ROM!"
							echo ""
							$sleep
							echo " Just read the comments in $initrcpath :)"
							echo ""
						fi
						bpsinfo=shown
					fi
				fi
			  fi
			  echo $line
			  echo ""
			  $sleep
			done
			if [ "$bpapplist" ]; then
				echo $line
				echo ""
				$sleep
				if [ ! "`busybox ps | grep [B]ulletProof`" ]; then
					echo $line
					echo " Now launching /data/97BulletProof_Apps.sh..."
					echo ""
					$sleep
					echo "    ... and it will stay in the background! ;^]"
					echo $line
					echo ""
					$sleep
					if [ "`busybox --help | grep nohup`" ]; then (busybox nohup /data/97BulletProof_Apps.sh > /dev/null &)
					elif [ "`busybox --help | grep start-stop-daemon`" ]; then busybox start-stop-daemon -S -b -x /data/97BulletProof_Apps.sh
					else info_bb_no_nohup
					fi
				fi
				Configure_BulletProof_Apps
				echo $line
				echo ""
				$sleep
				echo $line
				echo " ALL BulletProof* files backed up to $storagename..."
			fi
		fi
	fi
	if [ "$opt" -eq 17 ]; then
		if [ "`echo $flushOmaticHours | awk '$1==0'`" ]; then
			blurb_FastEngineFlush
			$sleep
			echo $line
			echo "    NOTE: DO NOT put it on a timed schedule!"
			echo $line
			echo ""
			$sleep
			echo " It's better to just enable..."
			echo ""
			$sleep
			echo $line
			echo "           -=Engine Flush-O-Matic=- !"
			echo $line
			echo ""
			$sleep
			echo "            ...and choose how often it runs ;^]"
			echo ""
			$sleep
			echo " The script will relaunch and kill itself..."
			echo ""
			$sleep
			echo "  ...and the new instance waits to flush again!"
			echo ""
			echo $line
			echo ""
			$sleep
		fi
		Re_Generate_FastEngineFlush
		echo " Continue and Flush it all away?"
		echo ""
		$sleep
		echo -n " Enter N for No, any key for Yes: "
		read flush
		echo ""
		echo $line
		case $flush in
		  n|N)echo "      Okay... just stay full of cache then!"
			  echo $line
			  echo ""
			  $sleep
			  flushnotrun=yes;;
			*)echo "    Nice! Gonna dump some cache... flush too!"
			  echo $line
			  sleep 2
			  if [ "`busybox --help | awk '/nohup|start-stop-daemon/'`" ]; then
				sh /data/V6_SuperCharger/!FastEngineFlush.sh
				flushOmaticHours=`awk -F, '{print $13}' /data/V6_SuperCharger/SuperChargerOptions`
			  else info_bb_no_nohup; flushnotrun=yes
			  fi;;
		esac
		blurb_was_created " For Fast Flushing..." " ../data/V6_SuperCharger/!FastEngineFlush.sh..."
		blurb_Quick_Widget
		echo $line
		echo ""
		$sleep
		if [ ! "`diff /data/V6_SuperCharger/!FastEngineFlush.sh /system/xbin/flush`" ]; then
			echo " There is another copy in /system/xbin..."
			blurb_Terminal flush =====
		else info_free_space_error /system/xbin flush
		fi
		echo ""
		if [ ! -f "/system/etc/init.d/96superflush" ] || [ "`diff /data/V6_SuperCharger/!FastEngineFlush.sh /system/etc/init.d/96superflush`" ] && [ -d "/system/etc/init.d" ]; then
			echo $line
			echo ""
			$sleep
			info_free_space_error /etc/init.d 96superflush
		fi
		if [ "$flushnotrun" ]; then flushnotrun=
			echo $line
			echo ""
			$sleep
			Configure_FastEngineFlush
		fi 2>/dev/null
	fi
	if [ "$opt" -eq 18 ]; then
		if [ "$detailinterval" -eq 0 ]; then blurb_Detailing; fi
		if [ "`which sqlite3`" ]; then
			Re_Generate_Detailing
			echo " Optimize SQLite databases now?"
			echo ""
			$sleep
			echo -n " Enter N for No, any key for Yes: "
			read detail
			echo ""
			echo $line
			case $detail in
			  n|N)echo "     SQLite Optimization Declined... meh..."
				  echo $line
				  echo ""
				  $sleep
				  detailingnotrun=yes;;
				*)echo "         Time to clean up after you! ;^]"
				  echo $line
				  sleep 2
				  sh /data/V6_SuperCharger/!Detailing.sh
				  detailinterval=`awk -F, '{print $14}' /data/V6_SuperCharger/SuperChargerOptions`;;
			esac
			blurb_was_created " For Diligent Detailing..." "      .../data/V6_SuperCharger/!Detailing.sh..."
			blurb_Quick_Widget
			echo $line
			echo ""
			$sleep
			if [ ! "`diff /data/V6_SuperCharger/!Detailing.sh /system/xbin/vac`" ]; then
				echo " There is another copy in /system/xbin..."
				blurb_Terminal vac ===
			else info_free_space_error /system/xbin vac
			fi
			echo ""
			if [ ! -f "/system/etc/init.d/92vac" ] || [ "`diff /data/V6_SuperCharger/!Detailing.sh /system/etc/init.d/92vac`" ] && [ -d "/system/etc/init.d" ]; then
				echo $line
				echo ""
				$sleep
				info_free_space_error /etc/init.d 92vac
			elif [ -d "/system/etc/init.d" ] && [ "$detailingnotrun" ]; then detailingnotrun=
				echo $line
				echo ""
				$sleep
				blurb_boot_script "Detailing" "Detailing"
				Configure_Detailing
			fi 2>/dev/null
		else info_missing_binary sqlite3 Vacuuming
		fi
	fi
	if [ "$opt" -eq 19 ]; then
		if [ "$zepalign" -ne 1 ]; then blurb_WheelAlignment; fi
		if [ "`which zipalign`" ]; then
			Re_Generate_WheelAlignment
			echo " ZipAlign data and system APKs now?"
			echo ""
			$sleep
			echo -n " Enter N for No, any key for Yes: "
			read align
			echo ""
			echo $line
			case $align in
			  n|N)echo "  No Wheel Alignment? Watch out for teh curbs!"
				  echo $line
				  echo ""
				  $sleep
				  zepalignnotrun=yes;;
				*)echo "        Gonna \"ZepAlign\" in no time! ;^]"
				  echo $line
				  sleep 2
				  sh /data/V6_SuperCharger/!WheelAlignment.sh
				  autofixemissions=yes
				  zepalign=`awk -F, '{print $15}' /data/V6_SuperCharger/SuperChargerOptions`
				  fixalign=`awk -F, '{print $17}' /data/V6_SuperCharger/SuperChargerOptions`;;
			esac
			blurb_was_created " For Zippy... uhh... \"ZepAligning\"..." " .../data/V6_SuperCharger/!WheelAlignment.sh..."
			blurb_Quick_Widget
			echo $line
			echo ""
			$sleep
			if [ ! "`diff /data/V6_SuperCharger/!WheelAlignment.sh /system/xbin/zepalign`" ]; then
				echo " There is another copy in /system/xbin..."
				blurb_Terminal zepalign ========
			else info_free_space_error /system/xbin zepalign
			fi
			echo ""
			if [ ! -f "/system/etc/init.d/93zepalign" ] || [ "`diff /data/V6_SuperCharger/!WheelAlignment.sh /system/etc/init.d/93zepalign`" ] && [ -d "/system/etc/init.d" ]; then
				echo $line
				echo ""
				$sleep
				info_free_space_error /etc/init.d 93zepalign
			elif [ -d "/system/etc/init.d" ] && [ "$zepalignnotrun" ]; then zepalignnotrun=
				echo $line
				echo ""
				$sleep
				blurb_boot_script "Wheel Alignment" "ZepAlign"
				Configure_WheelAlignment
			fi 2>/dev/null
			if [ "$autofixemissions" ]; then
				echo $line
				echo ""
				$sleep
				echo " Run the Fix Permissions option?"
				echo ""
				$sleep
				echo -n " Enter N for No, any key for Yes: "
				read emissions
				echo ""
				echo $line
				case $emissions in
				  n|N)autofixemissions=
					  echo "       Okay... but run it if you get FCs!!";;
					*)opt=20
					  remount rw
					  echo ""
					  echo "              ====================="
					  echo "             //// FIX EMISSIONS \\\\\\\\"
					  echo $line
					  echo ""
					  $sleep;;
				esac
			fi
		else info_missing_binary zipalign ZepAligning
		fi
	fi
	if [ "$opt" -eq 20 ]; then
		if [ "$fixemissions" -ne 1 ]; then blurb_FixEmissions; fi
		Re_Generate_FixEmissions
		echo " Fix Permissions now?"
		echo ""
		$sleep
		echo -n " Enter N for No, any key for Yes: "
		if [ "$autofixemissions" ]; then emissions=Y; autofixemissions=; echo $emissions
		else read emissions
		fi
		echo ""
		echo $line
		case $emissions in
		  n|N)echo "     Fix Emissions Declined... What The FC!?"
			  echo $line
			  echo ""
			  $sleep
			  fixemissionsnotrun=yes;;
			*)echo "      Cool... This won't take too long ;^]"
			  echo $line
			  sleep 2
			  sh /data/V6_SuperCharger/!FixEmissions.sh
			  fixemissions=`awk -F, '{print $16}' /data/V6_SuperCharger/SuperChargerOptions`
			  fixalign=`awk -F, '{print $17}' /data/V6_SuperCharger/SuperChargerOptions`;;
		esac
		blurb_was_created " For a Fast FCing Fix..." "   .../data/V6_SuperCharger/!FixEmissions.sh..."
		blurb_Quick_Widget
		echo $line
		echo ""
		$sleep
		if [ ! "`diff /data/V6_SuperCharger/!FixEmissions.sh /system/xbin/fixfc`" ]; then
			echo " There is another copy in /system/xbin..."
			blurb_Terminal fixfc =====
		else info_free_space_error /system/xbin fixfc
		fi
		echo ""
		if [ ! -f "/system/etc/init.d/94fixfc" ] || [ "`diff /data/V6_SuperCharger/!FixEmissions.sh /system/etc/init.d/94fixfc`" ] && [ -d "/system/etc/init.d" ]; then
			echo $line
			echo ""
			$sleep
			info_free_space_error /etc/init.d 94fixfc
		elif [ -d "/system/etc/init.d" ] && [ "$fixemissionsnotrun" ]; then fixemissionsnotrun=
			echo $line
			echo ""
			$sleep
			blurb_boot_script "Fix Emissions" "FixEmissions"
			Configure_FixEmissions
		fi 2>/dev/null
	fi
	if [ "$opt" -eq 21 ]; then
		if [ "$fixalign" -ne 1 ]; then blurb_FixAlignment; fi
		if [ "`which zipalign`" ]; then
			Re_Generate_FixAlignment
			echo " FixAlign data and system APKs now?"
			echo ""
			$sleep
			echo -n " Enter N for No, any key for Yes: "
			read align
			echo ""
			echo $line
			case $align in
			  n|N)echo "  No Fix Alignment? Try and drive straight!"
				  echo $line
				  echo ""
				  $sleep
				  fixalignnotrun=yes;;
				*)echo "        Gonna \"FixAlign\" in no time! ;^]"
				  echo $line
				  sleep 2
				  sh /data/V6_SuperCharger/!FixAlignment.sh
				  zepalign=`awk -F, '{print $15}' /data/V6_SuperCharger/SuperChargerOptions`
				  fixemissions=`awk -F, '{print $16}' /data/V6_SuperCharger/SuperChargerOptions`
				  fixalign=`awk -F, '{print $17}' /data/V6_SuperCharger/SuperChargerOptions`;;
			esac
			blurb_was_created " For Fast 'n Furious FixAligning..." "   .../data/V6_SuperCharger/!FixAlignment.sh..."
			blurb_Quick_Widget
			echo $line
			echo ""
			$sleep
			if [ ! "`diff /data/V6_SuperCharger/!FixAlignment.sh /system/xbin/fixalign`" ]; then
				echo " There is another copy in /system/xbin..."
				blurb_Terminal fixalign ========
			else info_free_space_error /system/xbin fixalign
			fi
			echo ""
			if [ ! -f "/system/etc/init.d/95fixalign" ] || [ "`diff /data/V6_SuperCharger/!FixAlignment.sh /system/etc/init.d/95fixalign`" ] && [ -d "/system/etc/init.d" ]; then
				echo $line
				echo ""
				$sleep
				info_free_space_error /etc/init.d 95fixalign
			elif [ -d "/system/etc/init.d" ] && [ "$fixalignnotrun" ]; then fixalignnotrun=
				echo $line
				echo ""
				$sleep
				blurb_boot_script "Fix Alignment" "FixAlign"
				Configure_FixAlignment
			fi 2>/dev/null
		else info_missing_binary zipalign FixAligning
			echo $line
			echo ""
			$sleep
			echo " But for now, you can just run Fix Emissions!"
			echo ""
		fi
	fi
	if [ "$opt" -eq 22 ]; then
		echo " Many kernels have a feature available..."
		echo ""
		$sleep
		echo "  ...which is called Kernel SamePage Merging..."
		echo ""
		$sleep
		echo " ...or the newer Ultra Kernel SamePage Merging!"
		echo ""
		$sleep
		echo " *KSM can potentially save alot of RAM usage..."
		echo ""
		$sleep
		echo "  ...by sharing information among processes ;^]"
		echo ""
		$sleep
		echo " This is also known as \"Data DeDuplication\"!"
		echo "                        ==== ============="
		echo ""
		echo $line
		echo ""
		$sleep
		echo " SO... Let's see what we got here..."
		echo ""
		$sleep
		echo " ..if you're lucky, I'll do some analyzing too!"
		echo ""
		$sleep
		bootytimeapprox=`stat -t /dev/alarm | awk '{print $13}'`
		uptimeapprox=$((`date +%s`-bootytimeapprox))
		uptimefile=`awk -F. '{print $1}' /proc/uptime`
		if [ "$uptimeapprox" -gt "$uptimefile" ]; then uptime=$uptimeapprox
		else uptime=$uptimefile
		fi
		uphours=$((uptime/3600)); upmins=$((uptime/60%60)); upsecs=$((uptime%60))
		waketime=`awk '{sum+=$2} END {printf "%d\n", sum/100+2}' /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state`
		whours=$((waketime/3600)); wmins=$((waketime/60%60)); wsecs=$((waketime%60))
		idletime=`awk '{printf "%d\n", $2}' /proc/uptime`
		idhours=$((idletime/3600)); idmins=$((idletime/60%60)); idsecs=$((idletime%60))
		deepsleep=$((uptime-waketime))
		dshours=$((deepsleep/3600)); dsmins=$((deepsleep/60%60)); dssecs=$((deepsleep%60))
		echo $line
		printf "%28s" "Data DeDuping $KSM "
		if [ "$ksmdir" ]; then
			if [ "`cat /sys/kernel/mm/$ksmdir/run`" -eq 1 ]; then
				fullscans=`cat /sys/kernel/mm/$ksmdir/full_scans`
				shared=`cat /sys/kernel/mm/$ksmdir/pages_shared`
				sharing=`cat /sys/kernel/mm/$ksmdir/pages_sharing`
				unshared=`cat /sys/kernel/mm/$ksmdir/pages_unshared`
				sleepmills=`cat /sys/kernel/mm/$ksmdir/sleep_millisecs`
				if [ "$shared" -ne 0 ]; then
					pool=`echo $shared | awk '{printf "%.02f\n", $1/256}'`
					deduped=`echo $sharing | awk '{printf "%.02f\n", $1/256}'`
					duped=`echo $unshared | awk '{printf "%.02f\n", $1/256}'`
					secondsperscan=$((waketime/(fullscans+1)))
					minsperscan=$((secondsperscan/60))
					secsperscan=$((secondsperscan%60))
					ksmrunsperscan=`echo $secondsperscan $sleepmills | awk '{printf "%.02f\n", $1/$2*1000}'`
					ksmrunspermin=$((1000*60/sleepmills))
					echo "savings - $deduped MB!"
					echo $line
					$sleep
					echo $sharing $shared $unshared | awk '{printf " %.02f = Benefit/Cost Ratio -> HIGHER IS BETTER!\n", $1*$1/$2/$3}'
					echo $sharing $shared | awk '{printf " %.02f Benefit Ratio x Shared '$pool' MB = '$deduped' MB\n", $1/$2}'
					echo $unshared $sharing | awk '{printf " %.02f Cost Ratio x '$deduped' MB = '$duped' MB (Unique)\n", $1/$2}'
					echo $line
					$sleep
					echo " $fullscans - Full Scans SINCE BOOT."
					echo " $minsperscan min $secsperscan secs ($secondsperscan seconds) Needed Per Scan"
					echo " $KSM Executes $ksmrunsperscan Times Per Full Scan"
					echo $line
					$sleep
					echo " $KSM Per Minute Summary (Based on Awake Time)"
					echo "     $KSM Executes $ksmrunspermin Times."
					echo $sharing $secondsperscan | awk '{printf "%10.02f MB - Scanned Beneficially Per Minute.\n", $1/256*60/$2}'
					echo $unshared $secondsperscan | awk '{printf "%10.02f MB - Scanned Wastefully Per Minute.\n", $1/256*60/$2}'
				else echo "is On But No Data!"
				fi
			else echo "is NOT Enabled!"
			fi
			echo $line
			echo ""
			$sleep
			echo " Current $KSM Values:"
			echo " ==================="
			echo ""
			$sleep
			for i in /sys/kernel/mm/$ksmdir/*; do printf "%20s - `cat $i`\n" `basename $i`; done
			echo ""
		else
			echo "is NOT AVAILABLE!"
			echo $line
			echo ""
		fi
		$sleep
		echo $line
		printf "%30s %d:%02d:%02d\n" "System Awake Time is" $whours $wmins $wsecs
		echo $line
		printf "%30s %d:%02d:%02d\n" "System Idle Time is" $idhours $idmins $idsecs
		echo $line
		printf "%30s %d:%02d:%02d\n" "System Deep Sleep Time is" $dshours $dsmins $dssecs
		echo $line
		printf "%30s %d:%02d:%02d\n" "System Up Time is" $uphours $upmins $upsecs
	fi
	if [ "$opt" -eq 23 ]; then
		echo " This is EXPERIMENTAL..."
		echo ""
		$sleep
		echo "              ...it may improve multitasking..."
		echo ""
		$sleep
		echo "    ...it may make your device even snappier..."
		echo ""
		$sleep
		echo "                 ...it may really do nothing..."
		echo ""
		$sleep
		echo "     But some people swear that it's great!"
		echo ""
		$sleep
		echo " Values are added at the bottom of build.prop!"
		echo ""
		$sleep
		echo $line
		echo " Warning: 3G, WiFi or BlueTooth issues reported!"
		while :; do
			echo $line
			echo ""
			$sleep
			echo -n " Enter (N)ullify, (U)n-Nullify, E(X)it: "
			read nln
			echo ""
			echo $line
			case $nln in
			  n|N)nitro=1;break;;
			  u|U)nitro=2;break;;
			  x|X)nitro=3;break;;
				*)echo "      Invalid entry... Please try again :p";;
			esac
		done
		if [ "$nitro" -ne 3 ]; then
			if [ "$nitro" -eq 1 ]; then p=/system/build.prop
				backup_prop $p
				echo $line
				cp -fr $p $storage/V6_SuperCharger/system/build.prop.unsuper
			fi
			echo ""
			$sleep
			if [ -f "/system/bin/build.prop" ] && [ ! -f "/system/bin/build.prop.unsuper" ]; then cp -rp /system/bin/build.prop /system/bin/build.prop.unsuper; fi
			sed -i '/Nullifier/,/Nullified/d' /system/build.prop
			if [ "$nitro" -eq 1 ]; then
				cat >> /system/build.prop <<EOF
# Nitro Lag Nullifier created by -=zeppelinrox=-
#
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!
#
ENFORCE_PROCESS_LIMIT=false
MAX_SERVICE_INACTIVITY=
MIN_HIDDEN_APPS=
MAX_HIDDEN_APPS=
CONTENT_APP_IDLE_OFFSET=
EMPTY_APP_IDLE_OFFSET=
MAX_ACTIVITIES=
ACTIVITY_INACTIVE_RESET_TIME=
# End of Nullified Entries.
EOF
				echo " Nitro Lag Nullifier installed..."
			else echo " Uninstalled Nitro Lag Nullifier..."
			fi
			echo ""
			$sleep
			if [ -f "/system/bin/build.prop" ]; then cp -frp /system/build.prop /system/bin; fi
			echo "                            ...Reboot required!"
		fi
		echo ""
	fi
	if [ "$opt" -eq 24 ]; then
		echo " This will copy V6 SuperCharger to /system/xbin"
		blurb_Terminal v6 ==
		echo ""
		$sleep
		echo " Note that su is short for SuperUser..."
		echo ""
		echo $line
		echo ""
		$sleep
		echo " So... continue installation?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read v6xbin
		echo ""
		case $v6xbin in
		  y|Y)if [ "$0" = "v6" ] || [ "$0" = "/system/xbin/v6" ]; then echo $line; echo " You are already running it from system/xbin!"
			  else
				dd if=$0 of=/system/xbin/v6 2>/dev/null
				cp -fr $0 $storage/V6_SuperCharger/system/xbin/v6
				if [ ! "`diff $0 /system/xbin/v6`" ]; then
					chown 0.0 /system/xbin/v6; chmod 777 /system/xbin/v6
					echo $line
					echo "  FABULOUS! Installation Was A Great Success!"
				else
					info_free_space_error /system/xbin v6
					echo ""
				fi
			  fi;;
			*)echo $line; echo " Well... forget it then...";;
		esac
	fi
	if [ "$opt" -eq 26 ]; then
		echo " This lets you update ALL V6 Generated Scripts!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " This includes those in system/xbin & /init.d..."
		echo ""
		$sleep
		echo "  ...BulletProof One Shots & PowerShift Scripts!"
		echo ""
		$sleep
		echo " Literally DOZENS of scripts get updated..."
		echo ""
		$sleep
		echo "  ============================================="
		echo "   \\\\\\\\//// A U T O M A G I C A L L Y \\\\\\\\////"
		echo "    ========================================="
		echo ""
		$sleep
		echo " All embedded settings will be retained too ;^]"
		echo ""
		$sleep
		echo $line
		echo " Only PREVIOUSLY generated scripts are updated!"
		echo $line
		echo ""
		$sleep
		echo " Why? To force you to know what the hell..."
		echo ""
		$sleep
		echo "...they do BEFORE you EFF it all up - THATS WHY!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Re-Generate ALL splits, lickity script?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read generate
		echo ""
		echo $line
		case $generate in
		  y|Y)echo "  OK... Now this is PFC - Pretty Friggin' Cool!"
			  echo $line
			  echo ""
			  $sleep
			  script_version_check force;;
			*)echo "      Well that was a waste of time, eh? :P";;
		esac
	fi
	if [ "$opt" -eq 27 ] || [ "$UnIScream" ]; then
		if [ "$servicesjarpatched" ]; then
			if [ ! "$UnIScream" ]; then
				echo "  Hey... services.jar is ALREADY SuperCharged!"
				echo ""
				echo $line
			fi
			if [ -f "$storage/V6_SuperCharger/services.jar.unsuper" ]; then
				echo ""
				$sleep
				echo " A backup services.jar was found..."
				echo ""
				$sleep
				echo " ie.$storagename/V6_SuperCharger/services.jar.unsupr"
				echo ""
				$sleep
				echo " Do you want to restore it (with permissions)?"
				echo "             (services.odex too, if it exists)"
				echo ""
				$sleep
				if [ "/system/bin/getprop" -nt "$storage/V6_SuperCharger/services.jar.unsuper" ]; then
					romnewer="yes"
					echo $line
					echo " WARNING: This backup was created BEFORE..."
					echo "               ...this ROM's installation date!"
					echo $line
					echo ""
					$sleep
					echo " It MIGHT be from a different ROM! Go ahead?"
					echo ""
					$sleep
				else romnewer=
				fi
				echo -n " Enter Y for Yes, any key for No: "
				if [ "$UnIScream" ] && [ ! "$romnewer" ]; then restorejar=Y; echo $restorejar
				else read restorejar
				fi
				echo ""
				case $restorejar in
				  y|Y)if [ ! "$HazEgg" ]; then
						cp -fr $storage/V6_SuperCharger/services.jar.unsuper /system/framework/services.jar
						cp -fr $storage/V6_SuperCharger/services.odex.unsuper /system/framework/services.odex 2>/dev/null
					  fi
					  if [ ! "`diff $storage/V6_SuperCharger/services.jar.unsuper /system/framework/services.jar`" ]; then
						echo $line
						echo "       Successfully restored services.jar!"
						echo $line
						echo ""
						$sleep
						if [ "$UnIScream" ]; then blurb_unsupercharge; fi
					  else
						info_free_space_error /framework services.jar
						echo ""
						$sleep
					  fi
					  echo $line;;
					*)if [ ! "$usedwebapp" ] && [ ! "$romnewer" ]; then echo $line; fi;;
				esac
			fi
			if [ "$usedwebapp" ] || [ "$romnewer" ]; then echo ""; fi
		fi
		if [ ! "$servicesjarpatched" ] || [ "$usedwebapp" ] || [ "$romnewer" ] && [ ! "$UnIScream" ]; then
			if [ "$newsupercharger" ] && [ "$ran" -eq 1 ]; then
				echo -n " Press The Enter Key... "
				read enter
				echo ""
				echo "          ============================"
				echo "         //// JELLY ISCREAM PARLOR \\\\\\\\"
				echo $line
				echo ""
				$sleep
			fi
			if [ "$odex" ] || [ "$jb" -eq 1 ]; then
				if [ "$odex" ]; then
					echo "             You have an ODEXED ROM!"
					echo "             ======================="
					echo ""
					$sleep
				fi
				echo " The ICS Priority Charger WebApp WON'T work..."
				echo ""
				$sleep
				if [ "$jb" -eq 1 ]; then
					echo "                     ...on Jelly Bean as of yet!"
					echo ""
					$sleep
				fi
				if [ "$odex" ]; then
					echo " This tool CAN install a pre-patched..."
					echo ""
					$sleep
					echo "   ...services.jar and services.odex..."
				else
					echo " This tool CAN install..."
					echo ""
					$sleep
					echo "   ...a pre-patched services.jar..."
				fi
				echo ""
				$sleep
				echo "     ...from $storagename to /system/framework..."
			else
				echo " This will download a patched services.jar..."
				echo ""
				$sleep
				echo "              ...OR install one from $storagename..."
				echo ""
				$sleep
				echo "        ...to /system/framework/services.jar..."
			fi
			echo ""
			$sleep
			echo "        ...AND apply permissions and ownership!"
			echo ""
			$sleep
			echo " If you had ALREADY copied to framework..."
			echo ""
			$sleep
			echo "     ...permissions will be applied ANYWAY! ;^]"
			echo ""
			echo $line
			echo ""
			$sleep
			echo " BUT the BEST and EASIEST method is to use..."
			echo ""
			$sleep
			echo "     ...the -=Ultimatic Jar Patcher Tools=- ;^]"
			echo ""
			$sleep
			echo " Choosing \"Ultimatic\" will open the XDA thread!"
			echo ""
			$sleep
			echo $line
			if [ "$odex" ]; then echo ""; echo "  ODEX ROMS can only do Manual Method for now!"
			elif [ "$jb" -eq 1 ]; then echo ""; echo "  Jelly Bean can only do Manual Method for now!"
			else
				if [ ! "$usedwebapp" ]; then
					echo "   Note: Downloaded services.jar will be WEAK!"
					echo $line
					echo ""
					$sleep
				fi
				echo " To get 100% SuperCharged,choose Manual Method!"
				echo ""
				$sleep
				echo " So hey, you have 2 choices!"
			fi
			echo ""
			$sleep
			echo "   Automatic Transmission: Automagical Install"
			$sleep
			echo "                       OR"
			$sleep
			echo "  Manual Method: See tools in thread to assist!"
			echo ""
			if [ ! "$odex" ] && [ "$jb" -eq 0 ]; then
				$sleep
				echo $line
				echo " WARNING: Priority Charger WebApp is OUT OF DATE"
				echo $line
				echo ""
				$sleep
				echo " It's missing the latest enhancements..."
				echo ""
				$sleep
				echo "           ...and the NEWEST MultiTasking Mods!"
				echo ""
				$sleep
				echo " The Launcher will still be WEAK-ish and..."
				echo ""
				$sleep
				echo " ...your SuperCharger Level will be reduced 25%!"
				echo ""
				$sleep
				echo $line
				echo " MANUAL METHOD RECOMMENDED FOR 100% SUPERCHARGE!"
			fi
			while :; do
				echo $line
				echo ""
				$sleep
				echo -n " Enter (A)utomatic or (M)anual or E(X)it: "
				if [ "$odex" ] || [ "$jb" -eq 1 ] || [ "$usedwebapp" ]; then transmit=M; echo $transmit
				else read transmit
				fi
				echo ""
				echo $line
				case $transmit in
				  a|A)autotransmit=yes
					  echo "        Automatic Transmission Selected!";;
				  m|M)manualtransmit=yes
					  echo "             Manual Method Selected!";;
				  x|X)break;;
					*)echo "      Invalid entry... Please try again :p";;
				esac
				while [ "$autotransmit" ] || [ "$manualtransmit" ] && [ ! "$newservicesjar" ]; do
					echo $line
					echo ""
					$sleep
					echo -n " Enter (U)ltimatic, (I)nstall, E(X)it: "
					if [ "$autotransmit" ]; then servicechoice=D; echo $servicechoice
					elif [ "$autoinstalljar" ]; then servicechoice=I; echo $servicechoice
					else read servicechoice
					fi
					echo ""
					echo $line
					case $servicechoice in
				  d|D|u|U)echo ""
						  $sleep
						  if [ "$autotransmit" ]; then
							if [ "`busybox ping -c 1 108.163.181.154 | grep statistics`" ]; then
								echo "           Sweet... Device is Online!"
								echo ""
								$sleep
								echo $line
								if [ ! -f "/system/xbin/curl" ]; then
									echo " Installing download tool..."
									echo $line
									echo ""
									$sleep
									wget -O /system/xbin/curl http://108.163.181.154/curl
									chown 0.0 /system/xbin/curl; chmod 777 /system/xbin/curl
								fi
								echo ""
								MD5=`md5sum /system/framework/services.jar | awk '{print $1}'`
								Patch_Exists=`curl http://android.mimic.ca/check_md5/$MD5`
								echo ""
								$sleep
								if [ "$Patch_Exists" = "True" ]; then curl -D $TMP_DIR/tmp_header http://android.mimic.ca/super_download/$MD5 -o $TMP_DIR/tmp_output
								else curl -D $TMP_DIR/tmp_header -F services_file=@/system/framework/services.jar -F is_super=True http://android.mimic.ca/ -o $TMP_DIR/tmp_output
								fi
								echo ""
								$sleep
								HEADER_MD5=`grep md5sum $TMP_DIR/tmp_header | awk '/md5sum/{sub(/.*md5sum=/, ""); print $1}'`
								HEADER_MD5=`echo $HEADER_MD5 | tr -d '\n\r'`
								if [ ! "$HEADER_MD5" ]; then
									# Header does not contain md5hash, checking file output!
									# We replace the HEADER_MD5 output with the webpage output (tmp_output) since
									# The header's output no longer matters...
									HEADER_MD5=`cat $TMP_DIR/tmp_output`
								fi
								rm -f $TMP_DIR/tmp_header
								echo $line
								case $HEADER_MD5 in
								  $a|$b)# This is a legit reason, not a bad download.
										echo "     ERROR: services.jar cannot be patched!"
										echo $line
										echo ""
										$sleep
										echo -n " Reason: It's "
										if [ "$HEADER_MD5" = "$b" ]; then echo -n "a "; fi
										echo "$HEADER_MD5 :p";;
									  *)echo " Patched services.jar MD5hash should be:"
										echo "         [$HEADER_MD5]"
										echo $line
										$sleep
										FILE_MD5=`md5sum $TMP_DIR/tmp_output | awk '{print $1}'`
										echo " Downloaded services.jar MD5hash is:"
										echo "         [$FILE_MD5]"
										echo $line
										echo ""
										$sleep
										echo $line
										if [ "X$HEADER_MD5" = "X$FILE_MD5" ]; then autoinstalljar=yes
											echo "   Clean Download Success! MD5sums Match! ;^]"
											echo $line
											echo ""
											$sleep
											mv $TMP_DIR/tmp_output $storage/V6_SuperCharger/services_supercharged.jar
											echo "      Now off to Auto Install services.jar!"
										else
											echo "          ERROR: MD5sums DO NOT Match!"
											echo $line
											echo ""
											$sleep
											echo " There is a possible download issue... :("
										fi;;
								esac
							else
								echo ""
								echo $line
								echo ""
								$sleep
								echo "       FAIL... Cannot Connect to Server :("
							fi
							echo ""
						  else
							echo " Going to load the..."
							echo ""
							$sleep
							echo "  ...Ultimatic Jar Patcher Tools thread at XDA!"
							echo ""
							$sleep
							echo " These tools (including MultiTasking Mods)..."
							echo ""
							$sleep
							echo "            ...can patch and install it all..."
							echo ""
							$sleep
							echo "                    ...from start to finish :o)"
							echo ""
							if [ ! "$odex" ]; then
								$sleep
								echo " But if you run it and do \"Offline\" Mode..."
								echo ""
								$sleep
								echo "             ...you can patch any services.jar!"
								echo ""
								$sleep
								echo " If you do that... you can come back..."
								echo ""
								$sleep
								echo $line
								echo "       ...and select \"(I)nstall\" to install it!"
							fi
						  fi
						  echo $line
						  echo ""
						  $sleep
						  echo -n " Press The Enter Key... "
						  read enter
						  echo ""
						  if [ ! "$autotransmit" ]; then load_page IvGL1; fi
						  manualtransmit=yes;autotransmit=;;
					  i|I)echo ""
						  if [ "$autoinstalljar" ]; then foundjars="$storage/V6_SuperCharger/services_supercharged.jar"
						  else
							  echo " Wait... looking for *services*.jar on $storagename!"
							  echo ""
							  busybox find $storage/ -iname "*services*.jar" > $storage/foundjars.tmp
							  while read searchjar; do jarnospace=`echo $searchjar | sed 's/ /_/g'`
								if [ "$searchjar" != "$jarnospace" ]; then
									echo $line
									echo ""
									echo " Renaming:" /${searchjar#*/}
									$sleep
									echo " New Name:" /${jarnospace#*/}
									echo ""
									$sleep
									mv "$searchjar" $jarnospace
								fi
								foundjars="$foundjars $jarnospace"
							  done < $storage/foundjars.tmp
							  rm $storage/foundjars.tmp
							  echo $line
						  fi
						  if [ "$foundjars" ]; then
							if [ "$autoinstalljar" ]; then
								$sleep
								echo " Automatic Transmission Almost Complete..."
								echo ""
							else
								echo " Cool... look what I found... ;^]"
								echo $line
								echo ""
								$sleep
								busybox ls -lc $foundjars | awk -v storage=$storage '{gsub(storage,"");printf "%4s %2s %5s %s\n", $6,$7,$8,$9}'
								echo ""
								$sleep
								echo $line
								echo " Newest files are listed first!"
							fi
							for jar in `busybox ls -lc $foundjars | awk '{print $9}'`; do
								echo $line
								echo ""
								$sleep
								echo " Install $storagename/${jar##*/}?"
								echo ""
								$sleep
								if [ "/system/bin/getprop" -nt "$jar" ]; then
									echo $line
									echo " WARNING: This file was created BEFORE..."
									echo "               ...this ROM's installation date!"
									echo $line
									echo ""
									$sleep
									echo " It MIGHT be from a different ROM! Go ahead?"
									echo ""
									$sleep
								fi
								echo -n " Enter Y for Yes, any key for No: "
								if [ "$autoinstalljar" ]; then installjar=Y; echo $installjar
								else read installjar
								fi
								echo ""
								case $installjar in
								  y|Y)if [ "/system/bin/getprop" -nt "$storage/V6_SuperCharger/services.jar.unsuper" ]; then
										  echo " Backing up services.jar to $storage..."
										  echo ""
										  $sleep
										  cp -fr /system/framework/services.jar $storage/V6_SuperCharger/services.jar.unsuper
										  cp -fr /system/framework/services.odex $storage/V6_SuperCharger/services.odex.unsuper 2>/dev/null
									  fi 2>/dev/null
									  echo "   ...now installing SuperCharged services.jar!"
									  echo ""
									  $sleep
									  cp -fr $jar /system/framework/services.jar
									  cp -fr ${jar%.jar}.odex /system/framework/services.odex 2>/dev/null
									  if [ ! "`diff $jar /system/framework/services.jar`" ]; then opt=34; newservicesjar=woohoo; servicesjarinstalled=yes
										echo $line
										echo "             I Scream SUPERCHARGED!"
										echo $line
										echo ""
										$sleep
										echo $line
									  else
										info_free_space_error /framework services.jar
										echo ""
										echo $line
										echo ""
										$sleep
										echo " Restoring original services.jar!"
										echo ""
										cp -fr $storage/V6_SuperCharger/services.jar.unsuper /system/framework/services.jar
										cp -fr $storage/V6_SuperCharger/services.odex.unsuper /system/framework/services.odex 2>/dev/null
									  fi
									  break;;
									*);;
								esac
							done
						  else echo "    No *services*.jar were found on $storagename!"
						  fi
						  foundjars=;autoinstalljar=;;
					  x|X)break;;
						*)echo "      Invalid entry... Please try again :p";;
					esac
				done
				if [ "$autotransmit" ] || [ "$manualtransmit" ]; then break; fi
			done
		fi
		chown 0.0 /system/framework/services.*; chmod 644 /system/framework/services.*
		echo " Applied permissions to /framework/services.jar!"
		if [ "$newservicesjar" ] || [ "$UnIScream" ]; then
			echo $line
			echo ""
			$sleep
			echo " Reboot Required: Boot will take a LONG Time!"
			echo ""
		fi
		showparlor=;showedparlor=yes;manualtransmit=;UnIScream=
	fi
	if [ "$opt" -eq 34 ]; then
		if [ "$newsupercharger" ] && [ "$ran" -eq 1 ] || [ "$newservicesjar" ]; then
			echo " Select YES in the next step to..."
			echo ""
			$sleep
			echo $line
			echo "                       ...SuperClean & ReStart!"
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
			echo ""
			echo "              ==================="
			echo "             //// SUPERCLEAN! \\\\\\\\"
			echo $line
			echo ""
			$sleep
			newsupercharger=; newservicesjar=
		fi
		echo " This tool will wipe your dalvik-cache..."
		echo ""
		$sleep
		echo " As well as other garbage/temp folders..."
		echo ""
		$sleep
		echo " ...tombstones,LOST.DIR,lost+found & local/tmp!"
		echo ""
		$sleep
		echo $line
		echo "     Bootloops are LESS likely to happen :^)"
		echo $line
		echo ""
		$sleep
		echo " Initial boot will take a long time but..."
		echo ""
		$sleep
		echo "    ...your system will be clean and efficient!"
		echo ""
		$sleep
		echo $line
		echo " If the screen freezes during boot..."
		echo ""
		$sleep
		echo "         ...pull the battery and retry..."
		echo ""
		$sleep
		echo "    ...sometimes it takes 3 or more tries..."
		echo ""
		$sleep
		echo "           ...as everything gets re-configured!"
		echo $line
		echo ""
		$sleep
		Re_Generate_SuperClean
		blurb_was_created " For Speedy SuperCleaning..." "     .../data/V6_SuperCharger/!SuperClean.sh..."
		blurb_Quick_Widget
		echo $line
		echo ""
		$sleep
		if [ ! "`diff /data/V6_SuperCharger/!SuperClean.sh /system/xbin/sclean`" ]; then
			echo " There is another copy in /system/xbin..."
			blurb_Terminal sclean ======
		else info_free_space_error /system/xbin sclean
		fi
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Do you want to SuperClean & ReStart now?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read superclean
		echo ""
		case $superclean in
			y|Y)if [ "$madesqlitefolder" -eq 1 ]; then rm -fr /sqlite_stmt_journals; fi
				for cleanup in dalvik-* tombstones LOST.DIR lost+found local/tmp; do
					if [ -d /*/$cleanup ]; then
						echo -n " Cleaning " /*/$cleanup; echo "..."
						$sleep
						rm -fr /*/$cleanup/
					fi
				done
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
			  *)echo $line
				echo " Okay... maybe next time!";;
		esac
	fi
 fi
 if [ "$opt" -lt 35 ]; then
	echo $line
	echo ""
	$sleep
	echo " To Return to Driver's Console..."
	echo ""
	$sleep
	echo -n "              ...Press the Return or Any Key: "
	if [ "$HazEgg" ] || [ "$crapp" ]; then echo " "
	else read enter
	fi
 fi
 if [ "$opt" -le 14 ] || [ "$opt" -ge 24 ] && [ "$opt" -le 27 ] || [ "$opt" -eq 35 ]; then
	echo ""
	echo $line
	echo ""
	$sleep
	if [ "$opt" -eq 1 ]; then echo " SuperCharger and Launcher Status..."
	elif [ "$opt" -eq 14 ]; then echo " UnSuperCharging..."
	else
		echo " SuperCharging, OOM Grouping & Priority Fixes.."
		echo ""
		$sleep
		echo "    ...BulletProof, Die-Hard & HTK Launchers..."
	fi
	echo ""
	$sleep
	echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
	if [ "$HazEgg" ] || [ "$crapp" ]; then
		echo ""
		echo $line
		echo ""
		$sleep
		echo " If there's a next time, say Yes to UnCr-app..."
		echo ""
		$sleep
		echo " ...and SuperCharge the current minfrees... duh!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Oh... and I just deleted myself too..."
		echo ""
		sleep="sleep $speed"
		$sleep
		echo $line
		echo "                    !! OLE !!"
		echo $line
		if [ "$crapp" ]; then  opt=35; rm $0
		else
			echo ""
			$sleep
			echo "              Easter Egg Complete!"
			echo ""
			$sleep
			echo $line
			echo "               MUHAHAHAHAHAHAHA!!"
			echo $line
			echo ""
			$sleep
			echo -n " Press The Enter Key... "
			read enter
		fi
	else sleep 2
	fi
 fi
 if [ "$madesqlitefolder" -eq 1 ]; then rm -fr /sqlite_stmt_journals; fi
 remount ro
 if [ "$opt" -eq 35 ]; then
	echo ""
	$sleep
	echo "                                    Buh Bye ;^]"
	echo ""
	echo $line
	echo ""
	$sleep
	exit 0
 fi
done
