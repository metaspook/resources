#!/system/bin/sh
#
# The Kick Ass Kernelizer Update 3 RC11 created by zeppelinrox.
#
# MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.
#
# Entropy-ness Enlarger (sysctl tweak for kernel.random.read_wakeup_threshold that keeps entropy_avail full) discovered by zeppelinrox.
# See http://goo.gl/P8Bvu - How Entropy-ness Enlarger works.
# See http://goo.gl/Zc85j - Possible reasons why it may actually do something :p
#
line=================================================
clear
echo ""
echo $line
echo " NOTE: BUSYBOX v1.16.2 OR HIGHER IS RECOMMENDED!"
echo $line
echo ""
sleep 3
busybox mount -o remount,rw / 2>/dev/null
busybox mount -o remount,rw rootfs 2>/dev/null
if [ -d "/sqlite_stmt_journals" ]; then madesqlitefolder=0
else mkdir /sqlite_stmt_journals; madesqlitefolder=1
fi
if [ "`ls $EXTERNAL_STORAGE`" ]; then storage=${EXTERNAL_STORAGE#*mnt}
elif [ "`ls $EXTERNAL_STORAGE2`" ]; then storage=${EXTERNAL_STORAGE2#*mnt}
elif [ "`ls $USBHOST_STORAGE`" ]; then storage=${USBHOST_STORAGE#*mnt}
elif [ "`ls $SECONDARY_STORAGE`" ]; then storage=${SECONDARY_STORAGE#*mnt}
elif [ "`ls $PHONE_STORAGE`" ]; then storage=${PHONE_STORAGE#*mnt}
else storage="/sdcard"
fi 2>/dev/null
cat > $storage/!KickAssKernel.html <<EOF
<br>
<br>
<i><u><b>The -=Kick Ass Kernelizer=-</b></u> by zeppelinrox.</i><br>
<br>
<i>What Does The Kick Ass Kernelizer Do?</i><br>
<br>
<u><b>Memory Management++</b></u><br>
<br>
<a href="http://goo.gl/4w0ba">MFK Calculator Info</a> - explanation for <b>vm.min_free_kbytes</b><br>
<a href="http://goo.gl/P8Bvu">Entropy-ness Enlarger Info</a> - explanation for <b>kernel.random.read_wakeup_threshold</b><br>
<a href="http://goo.gl/Zc85j">Entropy-ness Enlarger Musings...</a> - Possible reasons why it may actually do something :p<br>
<a href="http://www.linuxinsight.com/proc_sys_hierarchy.html">LinuxInsight</a> - <b>The /proc filesystem documentation</b> (Fantastic!)<br>
<a href="http://forum.xda-developers.com/showthread.php?t=813309">XDA [REF] Startup script speed tweaks</a> OP by <b>hardcore</b><br>
<a href="http://forum.xda-developers.com/showthread.php?p=12445735">XDA SD Tweakz v2</a><br>
<a href="http://forum.xda-developers.com/showthread.php?p=4806456">XDA Speed up your system with the noop scheduler</a><br>
<a href="http://intl.feedfury.com/content/47077504-tweak-skript-f-r-android-spica.html">script by voku1987</a> - just has alot of different ideas... though I used it alot less than I expected to.<br>
<a href="http://www.cyberciti.biz/files/linux-kernel/Documentation/sysctl/vm.txt">TMI 1</a> - Documentation for /proc/sys/vm/* aka <b>sysctl vm.*</b><br>
<a href="http://www.cyberciti.biz/files/linux-kernel/Documentation/sysctl/kernel.txt">TMI 2</a> - Documentation for /proc/sys/kernel/* aka <b>sysctl kernel.*</b><br>
<br>
<u><b>TCP Speed & Security</b></u><br>
<br>
<a href="http://www.cyberciti.biz/files/linux-kernel/Documentation/networking/ip-sysctl.txt">TMI 3</a> - Documentation for /proc/sys/net/ipv4/* aka <b>sysctl net.ipv4.*</b><br>
<a href="http://www.speedguide.net/articles/linux-tweaking-121">Linux Tweaking</a> - from speedguide.net<br>
<a href="http://www.psc.edu/networking/projects/tcptune/#Linux">Enabling High Performance Data Transfers</a> - Tuning TCP for Linux 2.4 and 2.6<br>
<a href="http://www.cyberciti.biz/faq/linux-tcp-tuning">Linux Tune Network Stack (Buffers Size) To Increase Networking Performance</a> - From nixCraft<br>
<br>
<u><b>Security and Hardening the TCP/IP stack to SYN attacks</b></u><br>
<br>
<a href="http://www.cyberciti.biz/faq/linux-kernel-etcsysctl-conf-security-hardening">Linux Kernel /etc/sysctl.conf Security Hardening</a> - From nixCraft<br>
<a href="http://www.symantec.com/connect/articles/hardening-tcpip-stack-syn-attacks">Hardening the TCP/IP stack to SYN attacks</a> - From Symantec<br>
<br>
For more help and info,<br>
See the <a href="http://goo.gl/qM6yR">-=V6 SuperCharger Thread=-</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://goo.gl/qM6yR">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
<br>
EOF
if [ ! -d "/sqlite_stmt_journals" ]; then
	echo ""
	echo $line
	echo ""
	sleep 2
	echo " Big Problem! Can't create a temporary folder!"
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
	echo $line
	sleep 2
fi
speed=2
sleep="sleep $speed"
iotweak=0
clear;echo "";echo "";echo "  The...                                       |";echo "";echo "";echo "";echo "";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|             Kick                             |";echo "";echo ""; echo "                                       zoom... |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|             Kick Ass                         |";echo "";echo "";echo "| zoom...                                      |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|             Kick Ass Kernelizer              |";echo "";echo ""; echo "| zoom...                              zoom... |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|           -=Kick Ass Kernelizer=-            |";echo "| by:                                          |";echo "";echo "| zoOM...                              zoOM... |";echo "";$sleep
clear;echo "";echo $line;echo "| The...                                       |";echo "|           -=Kick Ass Kernelizer=-            |";echo "| by:                                          |";echo "|               -=zeppelinrox=-                |";echo "| zOOM...                              zOOM... |";echo $line;$sleep
busybox echo "             \\\\\\\\ Update 3 RC11 ////"
echo "              ====================="
echo ""
$sleep
echo $line
echo "   Now Includes The -=Entropy-ness Enlarger=-!"
echo $line
echo ""
$sleep
id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%% *}`
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
echo " KAK applies DOZENS of integral..."
echo ""
$sleep
echo "   ...Memory and System Optimizations..."
echo ""
$sleep
echo "   ...regarding Kernel, Virtual Memory and Net!"
echo ""
$sleep
echo "          ...I/O Scheduler Tweaks Are Optional!"
echo ""
$sleep
echo $line
echo " See $storage/!KickAssKernel.html for more info!"
echo $line
echo ""
$sleep
ioschedlist=`cat /sys/block/mmcblk0/queue/scheduler | sed 's/\[//' | sed 's/\]//'`
echo " Available I/O Schedulers:"
echo " ========================"
echo ""
$sleep
echo " $ioschedlist"
echo ""
$sleep
echo " Current I/O Scheduler is in [square brackets]"
echo ""
$sleep
for i in /sys/block/*; do
	if [ "`cat $i/queue/scheduler`" != "none" ]; then
		echo -n "              `cat $i/queue/scheduler`"
		echo -e "\r ${i##*/}"
	fi
done
echo ""
$sleep
#
# MFK Calculator (for min_free_kbytes) created by zeppelinrox.
#
SSADJ=`getprop ro.SECONDARY_SERVER_ADJ`
if [ ! "$SSADJ" ] && [ -f "/data/V6_SuperCharger/SuperChargerAdj" ]; then SSADJ=6
elif [ ! "$SSADJ" ];then SSADJ=5
fi
minfreefile="/sys/module/lowmemorykiller/parameters/minfree"
minfree1=`awk -F , '{print $1}' $minfreefile`;minfree2=`awk -F , '{print $2}' $minfreefile`;minfree3=`awk -F , '{print $3}' $minfreefile`;minfree4=`awk -F , '{print $4}' $minfreefile`;minfree5=`awk -F , '{print $5}' $minfreefile`;minfree6=`awk -F , '{print $6}' $minfreefile`
if [ -f "/sys/module/lowmemorykiller/parameters/adj" ]; then adjfile="/sys/module/lowmemorykiller/parameters/adj"
elif [ -f "/data/V6_SuperCharger/SuperChargerAdj" ]; then adjfile="/data/V6_SuperCharger/SuperChargerAdj"
fi
if [ ! "$adjfile" ]; then oomadj1=0;oomadj2=1;oomadj3=2;oomadj4=4;oomadj5=9;oomadj6=15
elif [ "`awk -F , '{print $3}' $adjfile`" -gt 15 ]; then
	oomadj1=`awk -F , '{printf "%.0f\n", $1*17/1000}' $adjfile`;oomadj2=`awk -F , '{printf "%.0f\n", $2*17/1000}' $adjfile`;oomadj3=`awk -F , '{printf "%.0f\n", $3*17/1000}' $adjfile`;oomadj4=`awk -F , '{printf "%.0f\n", $4*17/1000}' $adjfile`;oomadj5=`awk -F , '{printf "%.0f\n", $5*17/1000}' $adjfile`;oomadj6=15
else
	oomadj1=`awk -F , '{print $1}' $adjfile`;oomadj2=`awk -F , '{print $2}' $adjfile`;oomadj3=`awk -F , '{print $3}' $adjfile`;oomadj4=`awk -F , '{print $4}' $adjfile`;oomadj5=`awk -F , '{print $5}' $adjfile`;oomadj6=`awk -F , '{print $6}' $adjfile`
fi
if [ "$SSADJ" -le "$oomadj1" ]; then SSMF=$minfree1;slot=1;
elif [ "$SSADJ" -le "$oomadj2" ]; then SSMF=$minfree2;slot=2;
elif [ "$SSADJ" -le "$oomadj3" ]; then SSMF=$minfree3;slot=3;
elif [ "$SSADJ" -le "$oomadj4" ]; then SSMF=$minfree4;slot=4;
elif [ "$SSADJ" -le "$oomadj5" ]; then SSMF=$minfree5;slot=5;
elif [ "$SSADJ" -le "$oomadj6" ]; then SSMF=$minfree6;slot=6;
fi
MFK=$(($SSMF*4/5))
echo $line
echo " Make Foreground AND Background Apps STAY FAST!"
echo $line
echo ""
$sleep
echo " With The MFK Calculator!"
echo " ========================"
echo ""
$sleep
echo " Key Setting That Impacts Typical Free RAM..."
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
$sleep
echo $line
echo "Warning: Users say \"Whoa, that's some good KAK!\""
while :; do
  echo $line
  echo ""
  $sleep
  echo -n " (K)ick Ass, Chew G(U)m, KAK (S)tick, E(X)it: "
  read KAK
  echo ""
  echo $line
  case $KAK in
	k|K)break;;
	u|U)break;;
	s|S)busybox echo "      \\\\\\\\ Is Your Kernel Kickin' Ass? ////"
		echo "       ==================================="
		echo ""
		echo "                          Current vs Kernelizer"
		echo "                          =======    =========="
		echo ""
		$sleep
		echo "        min_free_kbytes =    `cat /proc/sys/vm/min_free_kbytes` vs $MFK"
		echo " dirty_background_ratio =      `cat /proc/sys/vm/dirty_background_ratio` vs 60"
		echo "            dirty_ratio =      `cat /proc/sys/vm/dirty_ratio` vs 95"
		echo " tcp_congestion_control =   `cat /proc/sys/net/ipv4/tcp_congestion_control` vs cubic"
		echo "       lease-break-time =      `cat /proc/sys/fs/lease-break-time` vs 10"
		echo "     vfs_cache_pressure =      `cat /proc/sys/vm/vfs_cache_pressure` vs 10"
		echo "               rmem_max = `cat /proc/sys/net/core/rmem_max` vs 1048576"
		echo "           rmem_default =   `cat /proc/sys/net/core/optmem_max` vs 20480"
		echo "  read_wakeup_threshold =    `cat /proc/sys/kernel/random/read_wakeup_threshold` vs 1376"
		echo ""
		echo $line
		echo " Note: Last one's the -=Entropy-ness Enlarger=-!"
		echo $line
		echo ""
		$sleep
		if [ `cat /proc/sys/vm/min_free_kbytes` -eq $MFK ] && [ `cat /proc/sys/vm/dirty_background_ratio` -eq 60 ] && [ `cat /proc/sys/vm/dirty_ratio` -eq 95 ] && [ `cat /proc/sys/net/ipv4/tcp_congestion_control` = "cubic" ] && [ `cat /proc/sys/fs/lease-break-time` -eq 10 ] && [ `cat /proc/sys/vm/vfs_cache_pressure` -eq 10 ] && [ `cat /proc/sys/net/core/rmem_max` -eq 1048576 ] && [ `cat /proc/sys/net/core/optmem_max` -eq 20480 ] && [ `cat /proc/sys/kernel/random/read_wakeup_threshold` -eq 1376 ]; then
			echo "        ================================="
			busybox echo "       //// It's TOTALLY Kickin' Ass! \\\\\\\\"
		else
			echo "      ====================================="
			busybox echo "     //// Nope! It's Chewing Bubblegum! \\\\\\\\"
		fi;;
	x|X)break;;
	  *)echo "      Invalid entry... Please try again :p";;
  esac
done
if [ "$KAK" != "x" ] && [ "$KAK" != "X" ]; then
	echo ""
	$sleep
	busybox mount -o remount,rw /data 2>/dev/null
	mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw $(busybox mount | grep system | awk '{print $1,$3}' | sed -n 1p) 2>/dev/null
	if [ "$KAK" = "u" ] || [ "$KAK" = "U" ] && [ ! -f "`ls /system/etc/init.d/*KickAssKernel*`" ] && [ ! -f "`ls /data/*KickAssKernel*`" ]; then
		echo " You're just chewing Bubblegum..."
		echo ""
		$sleep
		echo "                  ...and nothing's Kickin' Ass!"
	else
		if [ "$KAK" = "u" ] || [ "$KAK" = "U" ]; then
			echo " Break out the Bubblegum!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo " De-Activating Kick Ass Kernelizer..."
			echo ""
			$sleep
		fi
		rm /data/*KickAssKernel*
		rm /system/etc/init.d/*KickAssKernel*
		if [ "$KAK" = "u" ] || [ "$KAK" = "U" ]; then
			echo "           ...Kick Ass Kernelizer De-Activated!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo "             Reboot is Recommended!"
		fi
	fi 2>/dev/null
	if [ "$KAK" = "k" ] || [ "$KAK" = "K" ]; then
		if [ ! -d "$storage/V6_SuperCharger" ]; then mkdir $storage/V6_SuperCharger; fi
		echo " I'm All Outta Bubblegum... Time to Kick Ass!"
		echo ""
		$sleep
		echo $line
		echo " Activating Kick Ass Kernelizer..."
		echo $line
		echo ""
		$sleep
		echo " \"Kernel Panics\" are inevitable..."
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
		echo $line
		echo ""
		$sleep
		echo " Pick a Kernel Strength..."
		echo ""
		$sleep
		echo -n " Rock(H)ard, (R)ock & Roll, any key Soft Rock: "
		read kvm
		echo ""
		echo $line
		case $kvm in
		  h|H)kpanic=0; kpoops=0
			  echo "     DON'T PANIC! Rock Hard Kernel Chosen!";;
		  r|R)kpanic=30; kpoops=0
			  echo " OOPS... DON'T PANIC! Rock & Roll Kernel Chosen!";;
			*)kpanic=30; kpoops=1
			  echo " EVERYBODY PANIC! Soft Rock Kernel Chosen!";;
		esac
		echo $line
		echo ""
		$sleep
		echo " I/O Info: sio is preferred over deadline..."
		echo ""
		$sleep
		echo "        ...and deadline is preferred over noop!"
		echo ""
		$sleep
		echo $line
		echo " WARNING: The I/O Tweaks can cause bootloops!"
		echo $line
		echo ""
		$sleep
		echo " Available I/O Schedulers:"
		echo " ========================"
		echo ""
		$sleep
		echo " $ioschedlist"
		echo ""
		$sleep
		echo " Include I/O Scheduler Tweaks? (You can pick)"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read io
		echo ""
		$sleep
		echo $line
		case $io in
		  y|Y)iotweak=1
			  echo " I/O Scheduler Tweaks Status: ENABLED!"
			  while :; do
				echo $line
				for sched in $ioschedlist; do
					echo ""
					$sleep
					echo -n " Use $sched? Enter (Y)es, any key for No: "
					read pick
					case $pick in
					  y|Y)usersched=$sched; break;;
						*);;
					esac
				done
			    echo ""
			    echo $line
				if [ "$usersched" ]; then echo " $usersched was selected!"; break
				else echo " Nothing was selected! Gonna try again..."
				fi
			  done;;
			*)iotweak=0
			  echo " I/O Scheduler Tweaks Status: DISABLED!";;
		esac
		echo $line
		echo ""
		$sleep
		cat > /data/98KickAssKernel.sh <<EOF
#!/system/bin/sh
#
# The Kick Ass Kernelizer created by zeppelinrox.
#
# MFK Calculator (for min_free_kbytes) created by zeppelinrox also ;^]
# See http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes.
#
# Entropy-ness Enlarger (sysctl tweak for kernel.random.read_wakeup_threshold that keeps entropy_avail full) discovered by zeppelinrox.
# See http://goo.gl/P8Bvu - How Entropy-ness Enlarger works.
# See http://goo.gl/Zc85j - Possible reasons why it may actually do something :p
#
# See included links (in the body of the script) for additional resources.
#
# Note: You can change the "usersched" variable and choose whatever available scheduler that you prefer.
#       Look for the comment before the super long if condition!
#       If the value is invalid or missing, it defaults to using sio, or deadline, or noop - in that order.
#       Example: If you want to use bfq scheduler, make the line read "usersched=bfq;
#
# echo ""; echo " See /data/Log_KickAssKernel.log for the output!"; echo "";
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Log_KickAssKernel.log file to see what may have fubarred.
# set -x;
# exec > /data/Log_KickAssKernel.log 2>&1;
#
line=================================================;
echo "";
echo \$line;
echo " The -=Kick Ass Kernelizer=- by -=zeppelinrox=-";
echo \$line;
echo "";
id=\`id\`; id=\`echo \${id#*=}\`; id=\`echo \${id%%\\(*}\`; id=\`echo \${id%% *}\`;
if [ "\$id" != "0" ] && [ "\$id" != "root" ]; then
	echo " You are NOT running this script as root...";
	echo "";
	echo \$line;
	echo "                      ...No SuperUser for you!!";
	echo \$line;
	echo "";
	echo "     ...Please Run as Root and try again...";
	echo "";
	echo \$line;
	echo "";
	exit 69;
fi;
echo " Time for your Kernel to Kick Some Ass!";
echo "";
echo " ...& double check via /data/Ran_KickAssKernel!";
echo "";
$sleep;
echo \$line;
busybox mount -o remount,rw /data 2>/dev/null;
EOF
		if [ "$iotweak" -eq 1 ]; then cat >> /data/98KickAssKernel.sh <<EOF
# Put your desired scheduler on the next line. See comments at the top for instuctions!
usersched=$usersched;
ioschedlist=\`cat /sys/block/mmcblk0/queue/scheduler | sed -e 's/\[\|\]//g'\`
for sched in \$ioschedlist; do if [ "\$sched" = "\$usersched" ];then userschedgood=yes; break; fi; done
if [ "\$userschedgood" ]; then iosched=\$usersched;
elif [ "\`cat /sys/block/mmcblk0/queue/scheduler | grep sio\`" ]; then iosched=sio;
elif [ "\`cat /sys/block/mmcblk0/queue/scheduler | grep deadline\`" ]; then iosched=deadline;
elif [ "\`cat /sys/block/mmcblk0/queue/scheduler | grep noop\`" ]; then iosched=noop;
fi;
for i in /sys/block/*/queue/scheduler; do
	if [ -f "\$i" ] && [ "\`cat \$i\`" != "none" ] && [ ! "\`cat \$i | grep "\\[\$iosched\\]"\`" ]; then doio=yes; break; fi;
done;
EOF
		fi
		cat >> /data/98KickAssKernel.sh <<EOF
if [ "\`cat /proc/sys/vm/dirty_background_ratio\`" -ne 60 ] || [ "\`cat /proc/sys/vm/dirty_ratio\`" -ne 95 ] || [ "\`cat /proc/sys/net/ipv4/tcp_congestion_control\`" != "cubic" ] || [ "\`cat /proc/sys/fs/lease-break-time\`" -ne 10 ] || [ "\`cat /proc/sys/vm/vfs_cache_pressure\`" -ne 10 ] || [ "\`cat /proc/sys/net/core/rmem_max\`" -ne 1048576 ] || [ "\`cat /proc/sys/net/core/optmem_max\`" -ne 20480 ] || [ "\`cat /proc/sys/kernel/random/read_wakeup_threshold\`" -ne 1376 ] || [ "\$doio" ]; then
	  ################################
	 #  Disable normalized sleeper  #
	################################
	#
	# Not applied if SmartReflex is found - since this breaks SmartReflex... lulz?
	# And DON'T ask me what SmartReflex is... Google shit for a change!
	#
	if [ -e "/sys/kernel/debug/sched_features" ]; then
		busybox mount -t debugfs none /sys/kernel/debug;
		echo NO_NORMALIZED_SLEEPER > /sys/kernel/debug/sched_features;
		busybox umount /sys/kernel/debug; fi;
	  #########################
	 #  Memory Management++  #
	#########################
	# http://goo.gl/4w0ba - MFK Calculator Info - explanation for vm.min_free_kbytes
	# http://www.linuxinsight.com/proc_sys_hierarchy.html
	# http://forum.xda-developers.com/showthread.php?t=813309
	# http://forum.xda-developers.com/showthread.php?p=12445735
	# http://forum.xda-developers.com/showthread.php?p=4806456
	# http://www.cyberciti.biz/files/linux-kernel/Documentation/sysctl/vm.txt
	# http://www.cyberciti.biz/files/linux-kernel/Documentation/sysctl/kernel.txt
	# http://intl.feedfury.com/content/47077504-tweak-skript-f-r-android-spica.html
	#
	echo " Applying Virtual Memory Tweaks...";
	echo \$line;
	echo "";
	$sleep;
	busybox sysctl -e -w vm.min_free_kbytes=$MFK;
	busybox sysctl -e -w vm.oom_kill_allocating_task=0;
	busybox sysctl -e -w vm.panic_on_oom=0;
	busybox sysctl -e -w vm.dirty_background_ratio=60;
	busybox sysctl -e -w vm.dirty_ratio=95;
	busybox sysctl -e -w vm.vfs_cache_pressure=10;
	busybox sysctl -e -w vm.overcommit_memory=1;
	busybox sysctl -e -w vm.min_free_order_shift=4;
	busybox sysctl -e -w vm.laptop_mode=0;
	busybox sysctl -e -w vm.block_dump=0;
	busybox sysctl -e -w vm.oom_dump_tasks=1;
	busybox sysctl -e -w vm.swappiness=20;
	#
	# Misc tweaks for battery life
	busybox sysctl -e -w vm.dirty_writeback_centisecs=2000;
	busybox sysctl -e -w vm.dirty_expire_centisecs=1000;
	#
	echo "";
	echo \$line;
	echo " Applying Kernel Tweaks...";
	echo \$line;
	echo "";
	$sleep;
	busybox sysctl -e -w kernel.panic=$kpanic;
	busybox sysctl -e -w kernel.panic_on_oops=$kpoops;
	busybox sysctl -e -w kernel.msgmni=2048;
	busybox sysctl -e -w kernel.msgmax=65536;
	busybox sysctl -e -w kernel.random.read_wakeup_threshold=1376;     # Entropy-ness Enlarger - keeps entropy_avail full - MAY save battery and/or boost responsiveness
	echo " ----------------------------------------------";
	echo " -=Entropy-ness Enlarger=- in Effect... heh ;^]";
	echo " ----------------------------------------------";
	busybox sysctl -e -w kernel.random.write_wakeup_threshold=256;
	for i in /sys/block/*/queue/add_random; do echo 0 > \$i; done 2>/dev/null;
	busybox sysctl -e -w kernel.shmmni=4096;
	busybox sysctl -e -w kernel.shmall=2097152;
	busybox sysctl -e -w kernel.shmmax=268435456;
	busybox sysctl -e -w kernel.sem='500 512000 64 2048';
	busybox sysctl -e -w kernel.sched_features=24189;
	busybox sysctl -e -w kernel.hung_task_timeout_secs=30;             # Set to 0 to disable but can cause black screen on incoming calls
	busybox sysctl -e -w kernel.sched_latency_ns=18000000;
	busybox sysctl -e -w kernel.sched_min_granularity_ns=1500000;
	busybox sysctl -e -w kernel.sched_wakeup_granularity_ns=3000000;
	busybox sysctl -e -w kernel.sched_compat_yield=1;
	busybox sysctl -e -w kernel.sched_shares_ratelimit=256000;
	busybox sysctl -e -w kernel.sched_child_runs_first=0;
	busybox sysctl -e -w kernel.threads-max=524288;
	echo "";
	echo \$line;
	echo " Applying File System Tweaks...";
	echo \$line;
	echo "";
	$sleep;
	busybox sysctl -e -w fs.lease-break-time=10;
	busybox sysctl -e -w fs.file-max=524288;
	busybox sysctl -e -w fs.inotify.max_queued_events=32000;
	busybox sysctl -e -w fs.inotify.max_user_instances=256;
	busybox sysctl -e -w fs.inotify.max_user_watches=10240;
	  ##########################
	 #  TCP Speed & Security  #
	##########################
	# http://www.speedguide.net/articles/linux-tweaking-121
	# http://www.psc.edu/networking/projects/tcptune/#Linux
	# http://www.cyberciti.biz/faq/linux-tcp-tuning
	# http://www.cyberciti.biz/files/linux-kernel/Documentation/networking/ip-sysctl.txt
	echo "";
	echo \$line;
	echo " Applying Network Tweaks...";
	echo \$line;
	echo "";
	$sleep;
	#
	# Queue size modifications
	busybox sysctl -e -w net.core.wmem_max=1048576;
	busybox sysctl -e -w net.core.rmem_max=1048576;
	#busybox sysctl -e -w net.core.rmem_default=262144;
	#busybox sysctl -e -w net.core.wmem_default=262144;
	busybox sysctl -e -w net.core.optmem_max=20480;
	busybox sysctl -e -w net.unix.max_dgram_qlen=50;
	#
	busybox sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1;               # Be sure that autotuning is in effect
	busybox sysctl -e -w net.ipv4.route.flush=1;
	busybox sysctl -e -w net.ipv4.udp_rmem_min=6144;
	busybox sysctl -e -w net.ipv4.udp_wmem_min=6144;
	busybox sysctl -e -w net.ipv4.tcp_rfc1337=1;
	busybox sysctl -e -w net.ipv4.ip_no_pmtu_disc=0;
	busybox sysctl -e -w net.ipv4.tcp_ecn=0;
	busybox sysctl -e -w net.ipv4.tcp_rmem='6144 87380 1048576';
	busybox sysctl -e -w net.ipv4.tcp_wmem='6144 87380 1048576';
	busybox sysctl -e -w net.ipv4.tcp_timestamps=0;
	busybox sysctl -e -w net.ipv4.tcp_sack=1;
	busybox sysctl -e -w net.ipv4.tcp_fack=1;
	busybox sysctl -e -w net.ipv4.tcp_window_scaling=1;
	#
	# Re-use sockets in time-wait state
	busybox sysctl -e -w net.ipv4.tcp_tw_recycle=1;
	busybox sysctl -e -w net.ipv4.tcp_tw_reuse=1;
	#
	# KickAss UnderUtilized Networking Tweaks below initially suggested by avgjoemomma (from XDA)
	# Refined and tweaked by zeppelinrox... duh.
	#
	busybox sysctl -e -w net.ipv4.tcp_congestion_control=cubic;        # Change network congestion algorithm to CUBIC
	#
	# Hardening the TCP/IP stack to SYN attacks (That's what she said)
	# http://www.cyberciti.biz/faq/linux-kernel-etcsysctl-conf-security-hardening
	# http://www.symantec.com/connect/articles/hardening-tcpip-stack-syn-attacks
	#
	busybox sysctl -e -w net.ipv4.tcp_syncookies=1;
	busybox sysctl -e -w net.ipv4.tcp_synack_retries=2;
	busybox sysctl -e -w net.ipv4.tcp_syn_retries=2;
	busybox sysctl -e -w net.ipv4.tcp_max_syn_backlog=1024;
	#
	busybox sysctl -e -w net.ipv4.tcp_max_tw_buckets=16384;            # Bump up tw_buckets in case we get DoS'd
	busybox sysctl -e -w net.ipv4.icmp_echo_ignore_all=1;              # Ignore pings
	busybox sysctl -e -w net.ipv4.icmp_echo_ignore_broadcasts=1;       # Don't reply to broadcasts (prevents joining a smurf attack)
	busybox sysctl -e -w net.ipv4.icmp_ignore_bogus_error_responses=1; # Enable bad error message protection (should be enabled by default)
	busybox sysctl -e -w net.ipv4.tcp_no_metrics_save=1;               # Don't cache connection metrics from previous connection
	busybox sysctl -e -w net.ipv4.tcp_fin_timeout=15;
	busybox sysctl -e -w net.ipv4.tcp_keepalive_intvl=30;
	busybox sysctl -e -w net.ipv4.tcp_keepalive_probes=5;
	busybox sysctl -e -w net.ipv4.tcp_keepalive_time=1800;
	#
	# Don't pass traffic between networks or act as a router
	busybox sysctl -e -w net.ipv4.ip_forward=0;                        # Disable IP Packet forwarding (should be disabled already)
	busybox sysctl -e -w net.ipv4.conf.all.send_redirects=0;
	busybox sysctl -e -w net.ipv4.conf.default.send_redirects=0;
	#
	# Enable spoofing protection (turn on reverse packet filtering)
	busybox sysctl -e -w net.ipv4.conf.all.rp_filter=1;
	busybox sysctl -e -w net.ipv4.conf.default.rp_filter=1;
	#
	# Don't accept source routing
	busybox sysctl -e -w net.ipv4.conf.all.accept_source_route=0;
	busybox sysctl -e -w net.ipv4.conf.default.accept_source_route=0 ;
	#
	# Don't accept redirects
	busybox sysctl -e -w net.ipv4.conf.all.accept_redirects=0;
	busybox sysctl -e -w net.ipv4.conf.default.accept_redirects=0;
	busybox sysctl -e -w net.ipv4.conf.all.secure_redirects=0;
	busybox sysctl -e -w net.ipv4.conf.default.secure_redirects=0;
	  #########################################
	 #  Remount with noatime and nodiratime  #
	#########################################
	echo "";
	echo \$line;
	echo " Remounting with noatime and nodiratime...";
	echo \$line;
	echo "";
	for k in \$(busybox mount | cut -d " " -f3); do
		busybox sync;
		busybox mount -o remount,noatime,noauto_da_alloc,barrier=0,data=writeback,nobh \$k 2>/dev/null;
	done;
EOF
		if [ "$iotweak" -eq 1 ]; then cat >> /data/98KickAssKernel.sh <<EOF
	  ###########################
	 #  Tweak I/O Scheduler++  #
	###########################
	echo \$line;
	echo " Applying I/O Scheduler Tweaks...";
	echo \$line;
	echo "";
	for i in /sys/block/*/queue; do
		if [ -f "\$i/scheduler" ] && [ "\`cat \$i/scheduler\`" != "none" ] && [ ! "\`cat \$i/scheduler | grep "\\[\$iosched\\]"\`" ]; then
			busybox sync; echo "cfq" > \$i/scheduler;
			if [ ! "\`echo \$i | grep loop\`" ] && [ ! "\`echo \$i | grep ram\`" ]; then
				if [ -f "\$i/rotational" ] && [ "\`cat \$i/rotational\`" -ne 0 ]; then echo "0" > \$i/rotational; fi 2>/dev/null;
				if [ -f "\$i/nr_requests" ] && [ "\`cat \$i/nr_requests\`" -ne 512 ]; then echo "512" > \$i/nr_requests; fi 2>/dev/null;
				if [ -f "\$i/iostats" ] && [ "\`cat \$i/iostats\`" -ne 0 ]; then echo "0" > \$i/iostats; fi 2>/dev/null;
				if [ -f "\$i/iosched/low_latency" ] && [ "\`cat \$i/iosched/low_latency\`" -ne 1 ]; then echo "1" > \$i/iosched/low_latency; fi 2>/dev/null;
				if [ -f "\$i/iosched/back_seek_penalty" ] && [ "\`cat \$i/iosched/back_seek_penalty\`" -ne 1 ]; then echo "1" > \$i/iosched/back_seek_penalty; fi 2>/dev/null;
				if [ -f "\$i/iosched/back_seek_max" ] && [ "\`cat \$i/iosched/back_seek_max\`" -ne 1000000000 ]; then echo "1000000000" > \$i/iosched/back_seek_max; fi 2>/dev/null;
				if [ -f "\$i/iosched/slice_idle" ] && [ "\`cat \$i/iosched/slice_idle\`" -ne 0 ]; then echo "0" > \$i/iosched/slice_idle; fi 2>/dev/null;
				if [ -f "\$i/iosched/fifo_batch" ] && [ "\`cat \$i/iosched/fifo_batch\`" -ne 1 ]; then echo "1" > \$i/iosched/fifo_batch; fi 2>/dev/null;
				if [ -f "\$i/iosched/quantum" ] && [ "\`cat \$i/iosched/quantum\`" -ne 16 ]; then echo "16" > \$i/iosched/quantum; fi 2>/dev/null;
			fi;
			busybox sync; echo "\$iosched" > \$i/scheduler;
		fi
	done
EOF
		fi
		cat >> /data/98KickAssKernel.sh <<EOF
	echo " \$( date +"%m-%d-%Y %H:%M:%S" ): Kernel's Kickin' Ass via \$0!" >> /data/Ran_KickAssKernel.log;
	echo \$line;
	echo "         Now Your Kernel's Kickin' Ass!";
else
	echo " \$( date +"%m-%d-%Y %H:%M:%S" ): No need to reapply settings from \$0!" >> /data/Ran_KickAssKernel.log;
	echo " Kick Ass Kernelizer was ALREADY In Effect...";
	echo "";
	echo "              ...there's no need to reapply it!";
fi;
echo \$line;
echo "";
echo " \$0 Executed...";
echo "";
echo "      ====================================";
echo "       ) Kick Ass Kernelizer Completed! (";
echo "      ====================================";
echo "";
EOF
		if [ -d "/sys/kernel/debug/smartreflex" ]; then sed -i '/kernel\/debug/s/^	/	# /' /data/98KickAssKernel.sh; fi
		chown 0.0 /data/98KickAssKernel.sh; chmod 777 /data/98KickAssKernel.sh
		cp -fr /data/98KickAssKernel.sh $storage/V6_SuperCharger
		echo " Successfully created..."
		echo ""
		$sleep
		if [ -d "/system/etc/init.d" ]; then cp -fr /data/98KickAssKernel.sh /system/etc/init.d/98KickAssKernel
			if [ ! "`diff /data/98KickAssKernel.sh /system/etc/init.d/98KickAssKernel`" ]; then
				sed -i '/'"$sleep"'/d' /system/etc/init.d/98KickAssKernel
				sed -i 's/# echo/echo/' /system/etc/init.d/98KickAssKernel
				sed -i 's/# set -x/set -x/' /system/etc/init.d/98KickAssKernel
				sed -i 's/# exec/exec/' /system/etc/init.d/98KickAssKernel
				sed -i '/remount,rw/ a\
mount -o remount,rw /system 2>/dev/null;\
busybox mount -o remount,rw /system 2>/dev/null;\
busybox mount -o remount,rw \$(busybox mount | grep system | awk '"'{print \$1,\$3}'"' | sed -n 1p) 2>/dev/null;\
mv \$0 /system/etc/init.d/98KickAssKernel;\
for i in \`busybox ls -r /system/etc/init.d\`; do\
	if [ "\$j" ]; then break; fi;\
	if [ ! -d "\$i" ]; then j=\$i; fi;\
done;\
echo " Kick Ass Kernelizer to run on boot as...";\
echo "";\
echo \$line;\
if [ "\$j" = "99SuperCharger" ] || [ "\$j" = "S99SuperCharger" ] || [ "\$j" = "SS99SuperCharger" ] && [ "\$i" \\< "98KickAssKernel1" ] || [ "\$j" \\< "98KickAssKernel1" ]; then\
	echo "         .../system/etc/init.d/98KickAssKernel!";\
elif [ "\$j" = "S99SuperCharger" ] || [ "\$j" = "SS99SuperCharger" ] && [ "\$i" \\< "S98KickAssKernel" ] || [ "\$j" \\< "S98KickAssKernel" ]; then\
	mv /system/etc/init.d/98KickAssKernel /system/etc/init.d/S98KickAssKernel;\
	echo "        .../system/etc/init.d/S98KickAssKernel!";\
else\
	mv /system/etc/init.d/98KickAssKernel /system/etc/init.d/SS98KickAssKernel;\
	echo "       .../system/etc/init.d/SS98KickAssKernel!";\
fi;\
echo \$line;\
echo "";\
mount -o remount,ro /system 2>/dev/null;\
busybox mount -o remount,ro /system 2>/dev/null;\
busybox mount -o remount,ro \$(busybox mount | grep system | awk '"'{print \$1,\$3}'"' | sed -n 1p) 2>/dev/null;' /system/etc/init.d/98KickAssKernel
				j=
				for i in `busybox ls -r /system/etc/init.d`; do
					if [ "$j" ]; then break; fi
					if [ ! -d "$i" ]; then j=$i; fi
				done
				if [ "$j" = "99SuperCharger" ] || [ "$j" = "S99SuperCharger" ] || [ "$j" = "SS99SuperCharger" ] && [ "$i" \< "98KickAssKernel1" ] || [ "$j" \< "98KickAssKernel1" ]; then
					echo "         .../system/etc/init.d/98KickAssKernel!"
				elif [ "$j" = "S99SuperCharger" ] || [ "$j" = "SS99SuperCharger" ] && [ "$i" \< "S98KickAssKernel" ] || [ "$j" \< "S98KickAssKernel" ]; then
					mv /system/etc/init.d/98KickAssKernel /system/etc/init.d/S98KickAssKernel
					echo "        .../system/etc/init.d/S98KickAssKernel!"
				else
					mv /system/etc/init.d/98KickAssKernel /system/etc/init.d/SS98KickAssKernel
					echo "       .../system/etc/init.d/SS98KickAssKernel!"
				fi
				cp -fr /system/etc/init.d/*KickAssKernel* $storage/V6_SuperCharger
			else
				echo " WARNING: ERROR copying file to /system/init.d!"
				echo ""
				$sleep
				echo " Got enough free space?"
				echo ""
				$sleep
				echo " System Partition has `busybox df -h /system | awk '{print $4,"Free ("$5" Used)"}' | tail -n 1`"
			fi
			echo ""
		else
			echo "                   .../data/98KickAssKernel.sh!"
			echo ""
			$sleep
			echo $line
			if [ "`pgrep scriptmanager`" ]; then echo " THIS app can load 98KickAssKernel.sh on boot!"
			else
				echo " Stock roms: Use Script Manager to run..."
				echo ""
				$sleep
				echo "     ...98KickAssKernel.sh at boot and as root!"
			fi
		fi
		echo $line
		echo ""
		$sleep
		echo "             Reboot is Recommended!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Now Launching 98KickAssKernel..."
		echo ""
		$sleep
		echo " Please ignore errors..."
		echo ""
		$sleep
		echo "             ...whatever can stick, will stick!"
		$sleep
		sh /data/98KickAssKernel.sh
		echo $line
		if [ "$iotweak" -eq 1 ]; then
			echo ""
			$sleep
			echo " Current I/O Scheduler is in [square brackets]"
			echo ""
			$sleep
			for i in /sys/block/*; do
				if [ "`cat $i/queue/scheduler`" != "none" ]; then
					echo -n "              `cat $i/queue/scheduler`"
					echo -e "\r ${i##*/}"
				fi
			done
			echo ""
			$sleep
			echo " It should now be [$usersched] !"
			echo ""
			$sleep
			echo $line
		fi
		echo " Check if it runs via /data/Ran_KickAssKernel!"
		echo $line
		echo ""
		$sleep
		echo "               ...Kick Ass Kernelizer Complete!"
	fi
	echo ""
	$sleep
	echo $line
fi
echo "              Have A Kick Ass Day!"
echo $line
echo ""
$sleep
echo " The Kick Ass Kernelizer Installer..."
echo ""
$sleep
echo "          ...and -=Entropy-ness Enlarger=-"
echo ""
$sleep
echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
$sleep
echo ""
echo "                                    Buh Bye ;^]"
echo ""
echo $line
echo ""
$sleep
if [ "$madesqlitefolder" -eq 1 ]; then rm -r /sqlite_stmt_journals; fi 2>/dev/null
busybox mount -o remount,ro / 2>/dev/null
busybox mount -o remount,ro rootfs 2>/dev/null
mount -o remount,ro /system 2>/dev/null
busybox mount -o remount,ro /system 2>/dev/null
busybox mount -o remount,ro $(busybox mount | grep system | awk '{print $1,$3}' | sed -n 1p) 2>/dev/null
exit 0
