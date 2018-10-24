#!/system/bin/sh
#
# The 3G TurboCharger Update 3 RC11 created by zeppelinrox.
#
# Wi-Fi AfterBurner created by zeppelinrox also ;^]
# It's based on info found in this XDA thread http://forum.xda-developers.com/showthread.php?t=1019371
#
# Some additional resources from which I gathered information
# XDA Thread 1 http://forum.xda-developers.com/showthread.php?t=595108
# XDA Thread 2 http://forum.xda-developers.com/showthread.php?t=924440
# XDA Thread 3 http://forum.xda-developers.com/showpost.php?p=5123531&postcount=46
# This Blog... http://www.nickshertzer.com/wordpress/?p=600
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
cat > $storage/!3GTurboCharger.html <<EOF
<br>
<br>
<i><u><b>The -=3G TurboCharger=-</b></u> by zeppelinrox.</i><br>
<br>
In case of connection issues, see the notes in the 3G TurboCharger section at the top of /system/build.prop!<br>
<br>
<b>Homework/Background Info...</b> see the folllowing links for resources used.<br>
<br>
<a href="http://forum.xda-developers.com/showthread.php?t=595108">XDA Thread 1</a><br>
<a href="http://forum.xda-developers.com/showthread.php?t=924440">XDA Thread 2</a><br>
<a href="http://forum.xda-developers.com/showpost.php?p=5123531&postcount=46">XDA Thread 3</a><br>
<a href="http://www.nickshertzer.com/wordpress/?p=600">And a blog...</a><br>
<br>
Wi-Fi AfterBurner.<br>
<br>
<a href="http://forum.xda-developers.com/showthread.php?t=1019371">XDA Thread (Faster WIFI - N Standard Enabling)</a><br>
<br>
The 3g build.prop tweaks aren't really anything new... but I did put a new spin on it!  ;^]<br>
<br>
You can find various individual configurations but as far as I know, my script is the only one that lets the user choose from more than one configuration.<br>
<br>
<b>Options 1 and 2</b> aren't anything out of the ordinary... they are pretty much typical 3g tweaks. I may have tweaked a couple of values in each one.<br>
<br>
<b>Option 3</b> has maximum values from initial/older 3g tweaks.<br>
<br>
<b>Option 4</b> has maximum values from newer 3g tweaks and personal research.<br>
<br>
<b>Option 5</b> has mximum, perhaps unconfirmed maximum values that aren't very well known.<br>
For example, googling hsxpa=5 or gprsclass=34 won't give many results. heh.<br>
<br>
<b>Option 6</b> is pretty cool and came about by accident - nulled values.<br>
I made a scripting error on a beta/test and all options applied no values so you had gprsclass= and hsxpa= etc etc... (oops)<br>
But many users reported great results (uh... I knew that would happen... honest!)<br>
So I figured, in theory, that could make sense too - instead of applying maximum values, apply NO values and let the OS figure it out and without limitation (the more you know... lol)<br>
<br>
So, I pretty much came up with configurations/options 3 to 6 based on research and user results (from the XDA SuperCharger thread) :D<br>
<br>
<br>
<u><b>Option 1 - QUICK!</b></u><br>
<br>
ro.ril.hsxpa=2<br>
ro.ril.gprsclass=10<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=8<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=4294967295<br>
ro.ril.htcmaskw1=14449<br>
ro.ril.hsupa.category=6<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=0<br>
ro.ril.enable.a52=0<br>
ro.ril.enable.a53=0<br>
ro.ril.enable.dtm=0<br>
<br>
<u><b>Option 2 - FAST!?</b></u><br>
<br>
ro.ril.hsxpa=2<br>
ro.ril.gprsclass=12<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=8<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=4294967295<br>
ro.ril.htcmaskw1=14449<br>
ro.ril.hsupa.category=6<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=0<br>
ro.ril.enable.a52=0<br>
ro.ril.enable.a53=0<br>
ro.ril.enable.dtm=0<br>
<br>
<u><b>Option 3 - FASTER!?</b></u> (From Update 2)<br>
<br>
ro.ril.hsxpa=2<br>
ro.ril.gprsclass=12<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=28<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=4294967295<br>
ro.ril.htcmaskw1=14449<br>
ro.ril.hsupa.category=9<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=1<br>
ro.ril.enable.a52=0<br>
ro.ril.enable.a53=1<br>
ro.ril.enable.dtm=1<br>
<br>
<u><b>Option 4 - FASTEST!?</b></u> (From Update 3 test 8)<br>
<br>
ro.ril.hsxpa=3<br>
ro.ril.gprsclass=32<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=28<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=4294967295<br>
ro.ril.htcmaskw1=268449905<br>
ro.ril.hsupa.category=9<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=1<br>
ro.ril.enable.a52=0<br>
ro.ril.enable.a53=1<br>
ro.ril.enable.dtm=1<br>
<br>
<u><b>Option 5 - EXPERIMENTAL 1</b></u><br>
<br>
ro.ril.hsxpa=5<br>
ro.ril.gprsclass=34<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=28<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=4294967295<br>
ro.ril.htcmaskw1=268449905<br>
ro.ril.hsupa.category=9<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=1<br>
ro.ril.enable.a52=1<br>
ro.ril.enable.a53=1<br>
ro.ril.enable.dtm=1<br>
<br>
<u><b>Option 6 - EXPERIMENTAL 2</b></u><br>
<br>
ro.ril.hsxpa=<br>
ro.ril.gprsclass=<br>
ro.ril.hep=1<br>
ro.ril.hsdpa.category=<br>
ro.ril.enable.3g.prefix=1<br>
ro.ril.htcmaskw1.bitmask=<br>
ro.ril.htcmaskw1=<br>
ro.ril.hsupa.category=<br>
ro.ril.def.agps.mode=2<br>
ro.ril.def.agps.feature=1<br>
ro.ril.enable.sdr=1<br>
ro.ril.enable.gea3=1<br>
ro.ril.enable.fd.plmn.prefix=23402,23410,23411<br>
ro.ril.disable.power.collapse=1<br>
ro.ril.enable.a52=<br>
ro.ril.enable.a53=<br>
ro.ril.enable.dtm=<br>
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
if [ "$madesqlitefolder" -eq 1 ]; then rm -r /sqlite_stmt_journals; fi 2>/dev/null
busybox mount -o remount,ro / 2>/dev/null
busybox mount -o remount,ro rootfs 2>/dev/null
speed=2
sleep="sleep $speed"
clear;echo "";echo "";echo "  The...                                       |";echo "";echo "";echo "";echo "";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|               3                              |";echo "";echo ""; echo "                                       zoom... |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|               3G                             |";echo "";echo "";echo "| zoom...                                      |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|               3G TurboCharger                |";echo "";echo ""; echo "| zoom...                              zoom... |";echo "";$sleep
clear;echo "";echo "";echo "| The...                                       |";echo "|             -=3G TurboCharger=-              |";echo "| by:                                          |";echo "";echo "| zoOM...                              zoOM... |";echo "";$sleep
clear;echo "";echo $line;echo "| The...                                       |";echo "|             -=3G TurboCharger=-              |";echo "| by:                                          |";echo "|               -=zeppelinrox=-                |";echo "| zOOM...                              zOOM... |"
id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%% *}`
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	echo $line
	$sleep
	echo ""
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
while :; do
 echo $line
 $sleep
 echo " View settings in $storage/!3GTurboCharger.html!"
 echo $line
 busybox echo " \\\\\\\\ T H E  3 G   T U R B O C H A R G E R ////"
 echo "  ============================================"
 echo "  { 1. Quick!               {Battery Friendly}"
 echo "  { 2. Fast!?                {\"Normal\" Values}"
 echo "  { 3. Faster!?             {Nearly Maxed Out}"
 echo "  { 4. Fastest!?             {Known Maxed Out}"
 echo "  { 5. Experimental 1     {\"Secret\" Maxed Out}"
 echo "  { 6. Experimental 2          {Nulled Values}"
 echo "  { 7. Wi-Fi AfterBurner       {Tiwlan Tweaks}"
 echo "  { 8. UnTurboCharger     {Revert 3G Settings}"
 echo "  { 9. Wi-Fixer              {Possible Repair}"
 echo "  {10. Help File        {!3GTurboCharger.html}"
 echo "  {11. SpeedTest App!   {Get It @ Google Play}"
 echo "  {12. Reboot                          {Poof!}"
 echo "  {13. Exit                          {Buh Bye}"
 echo "  ============================================"
 busybox echo "   \\\\\\\\           Update 3 RC11           ////"
 echo "    ========================================="
 if [ "`grep ro.cdma /system/build.prop`" ] || [ "`grep CdmaDevice /system/build.prop`" ]; then
	 busybox echo "        \\\\\\\\  CDMA Mode Activated!  ////"
	 echo "         =============================="
 else
	 busybox echo "        \\\\\\\\   GSM Mode Activated!  ////"
	 echo "         =============================="
 fi
 echo ""
 echo " Settings are applied at the top of build.prop!"
 echo ""
 echo $line
 if [ "`grep "3G Settings" /system/build.prop`" ]; then
	echo "         `grep "3G Settings" /system/build.prop | sed '/3G Settings/s/#//'` Found!"
 else echo "        No 3G TurboCharger Settings Found!"
 fi
 echo $line
 echo ""
 echo "    Your Mileage WILL Vary So Test Them All!"
 echo ""
 echo " The SpeedTest.Net app is highly recommended :)"
 echo ""
 for b in `busybox find /system -iname "tiwlan*.ini"`; do
	if [ "`grep 'Single_Dual_Band_Solution = 1' $b`" ]; then burner=yep; break; fi
 done
 if [ "$burner" ]; then
	echo "   ==========================================="
	busybox echo "  ////   Wi-Fi AfterBurner is Installed!   \\\\\\\\"
 else
	echo "   ==========================================="
	busybox echo "  //// Wi-Fi AfterBurner is NOT Installed! \\\\\\\\"
 fi
 echo " ==============================================="
 if [ "$setting" ]; then
	busybox echo "  \\\\\\\\  SETTINGS CHANGE REQUIRES A REBOOT  ////"
	echo "   ==========================================="
 fi
 echo -n "         Please Enter Option [1 - 13]: "
 read turboopt
 echo $line
 busybox echo "            \\\\\\\\ 3G TURBOCHARGER ////"
 echo "             ======================="
 echo ""
 $sleep
 if [ "$turboopt" -lt 12 ] 2>/dev/null; then
	busybox mount -o remount,rw / 2>/dev/null
	busybox mount -o remount,rw rootfs 2>/dev/null
	mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw $(busybox mount | grep system | awk '{print $1,$3}' | sed -n 1p) 2>/dev/null
	if [ -d "/sqlite_stmt_journals" ]; then madesqlitefolder=0
	else mkdir /sqlite_stmt_journals; madesqlitefolder=1
	fi
 fi
 case $turboopt in
  1) echo "                      QUICK!"
	 tcconfig="Quick!";hsxpa=2;gprsclass=10;hsdpa=8;bitmask=4294967295;htcmaskw1=14449;hsupa=6;dpc=0;afivetwo=0;afivethree=0;dtm=0;;
  2) echo "                      FAST!?"
	 tcconfig="Fast!?"; hsxpa=2;gprsclass=12;hsdpa=8;bitmask=4294967295;htcmaskw1=14449;hsupa=6;dpc=0;afivetwo=0;afivethree=0;dtm=0;;
  3) echo "                     FASTER!?"
	 tcconfig="Faster!?";hsxpa=2;gprsclass=12;hsdpa=28;bitmask=4294967295;htcmaskw1=14449;hsupa=9;dpc=1;afivetwo=0;afivethree=1;dtm=1;;
  4) echo "                     FASTEST!?"
	 tcconfig="Fastest!?";hsxpa=3;gprsclass=32;hsdpa=28;bitmask=4294967295;htcmaskw1=268449905;hsupa=9;dpc=1;afivetwo=0;afivethree=1;dtm=1;;
  5) echo "                 EXPERIMENTAL 1!"
	 tcconfig="Experimental_1";hsxpa=5;gprsclass=34;hsdpa=28;bitmask=4294967295;htcmaskw1=268449905;hsupa=9;dpc=1;afivetwo=1;afivethree=1;dtm=1;;
  6) echo "                 EXPERIMENTAL 2!"
	 tcconfig="Experimental_2";hsxpa=;gprsclass=;hsdpa=;bitmask=;htcmaskw1=;hsupa=;dpc=1;afivetwo=;afivethree=;dtm=;;
  7) echo "           =========================="
	 busybox echo "          //// WI-FI AfterBurner! \\\\\\\\"
	 echo $line
	 $sleep
	 echo " HEY! If tiwlan.ini don't exist, I can make one!"
	 echo $line
	 echo ""
	 $sleep
	 echo " Your tiwlan.ini file will be tweaked like so:"
	 echo ""
	 $sleep
	 echo "                 HT_Enable = 1"
	 echo "           BurstModeEnable = 1"
	 echo "                 WiFiAdhoc = 1"
	 echo " Single_Dual_Band_Solution = 1"
	 echo "            RoamScanEnable = 1"
	 echo "                   SRState = 1"
	 echo ""
	 $sleep
	 echo "    Most of these are set to 0 by default :P"
	 echo ""
	 $sleep
	 echo " You may need to also configure your router..."
	 echo ""
	 $sleep
	 echo " If it's now set to the 2.4GHz band..."
	 echo ""
	 $sleep
	 echo " ...if it has the option, enable the 5GHz band!"
	 echo ""
	 $sleep
	 echo $line
	 echo " See $storage/!3GTurboCharger.html for more info!"
	 echo $line
	 echo ""
	 $sleep
	 while :; do
		echo -n " Enter Wi-Fi (A)fterBurner, (U)n-Burn, E(X)it:"
		read wb
		echo ""
		echo $line
		case $wb in
		  a|A)if [ "`busybox find /system -iname "tiwlan*.ini"`" ]; then
				setting="changed"
				for i in `busybox find /system -iname "tiwlan*.ini"`; do
					echo ""
					$sleep
					echo " Found $i!"
					echo ""
					$sleep
					if [ -f "$i.un3g" ]; then echo " Leaving ORIGINAL ${i##*/} backup intact..."
					else
						echo " Backing up ORIGINAL ${i##*/}..."
						echo ""
						$sleep
						cp -r $i $i.un3g
						if [ "`diff $i $i.un3g`" ]; then echo " ERROR BACKING UP $i!"
						else echo "    ...as $i.un3g!"
						fi
					fi
					echo ""
					$sleep
					echo $line
					echo " AfterBurning $i..."
					echo $line
					sed -i '/HT_Enable=/s/e= *./e=1/' $i
					sed -i '/HT_Enable =/s/e = *./e = 1/' $i
					sed -i '/BurstModeEnable =/s/e = *./e = 1/' $i
					sed -i '/WiFiAdhoc =/s/c = *./c = 1/' $i
					sed -i '/Single_Dual_Band_Solution =/s/n = *./n = 1/' $i
					sed -i '/RoamScanEnable =/s/e = *./e = 1/' $i
					sed -i '/SRState =/s/e = *./e = 1/' $i
					sed -i '/SRF/s/^#//' $i
				done
			  else
				echo "    DAMN... No tiwlan.ini file was found! :("
				echo $line
				echo ""
				$sleep
				echo " But funny story... some users claim that..."
				echo ""
				$sleep
				echo "         ...simply CREATING one actually works!"
				echo ""
				$sleep
				echo " Even posting before and after speed tests :p"
				echo ""
				$sleep
				echo " It very well could be placebo but..."
				echo ""
				$sleep
				echo " ...do you wanna make a tiwlan.ini file anyway?"
				echo ""
				$sleep
				echo -n " Enter Y for Yes, any key for No: "
				read maketiwlan
				echo ""
				echo $line
				case $maketiwlan in
				  y|Y)setting="changed"
					  touch /system/etc/wifi/tiwlan.ini.unsuper
					  cat > /system/etc/wifi/tiwlan.ini <<EOF
# Note: The letters in this file are NOT case sensitive.

# dot11BeaconPeriod = 100
# ConnSelfTimeout = 60000

SmeConnectMode = 1               #0 - auto, 1 - manual
ScanResultAging = 0              # in Second - range 0..1000
WME_Enable = 1                   #0=diable WME support / 1=Enable
dot11NetworkType = 3             #2 - A only mode, 3 - B/G mode, 4 - A/G Dual mode
SmeScanGChannelList = 1,2,3,4,5,6,7,8,9,10,11,12,13,14
SmeScanAChannelList = 36,40,44,48,52,56,60,64
RecoveryEnable = 1               #0 -Disabled 1- Enabled
BThWlanCoexistEnable = 1         #0 - SG disable, 1 - SG protective
TxAggregationPktsLimit = 0       # Disable Tx packets aggregation for Linux (degrades TP)

#
# Power Manager
#
BeaconListenInterval = 1        # the number of N-Beacon or N-DTim
DtimListenInterval = 1          #

ReAuthActivePriority = 0

dot11PowerMode = 0              #0 - Auto
                                #1 - Active
                                #2 - Short Doze
                                #3 - Long Doze

PowerMgmtHangOverPeriod = 10    #in mSec units

AutoPowerModeDozeMode = 3       #2 - Short Doze
                                #3 - Long Doze

AutoPowerModeActiveTh = 2       #packets per second

AutoPowerModeDozeTh = 8         #packets per seconds - threshold for entering ELP in Auto mode

defaultPowerLevel = 0   #0 - ELP
                        #1 - PD
                        #2 - AWAKE

PowerSavePowerLevel = 0 #0 - ELP
                        #1 - PD
                        #2 - AWAKE

DcoItrimEnabled = 0  # 0 - Disabled  1 - Enabled
DcoItrimModerationTimeout = 50000

TxPower = 205           #set Default Tx Power Level in DBM * 10
dot11FragmentationThreshold = 4096
dot11RTSThreshold = 4096
WPAMixedMode= 1
RSNPreAuthentication = 1

CalibrationChannel24 = 7
# CalibrationChannel24 = 1
CalibrationChannel5 = 36

# Regulatury Domain tables.
# Each byte correlates to one channel in sequential order.  Table 2.4 starts from channel 1, Table 5.0 starts from channel 36.
# Bits 0..4 - Max power allowed in Dbm.
# Bit 6 - Channel is allowed for Active scan
# BIt 7 - Channel is allowed
AllowedChannelsTable24 = FFFFFFFFFFFFFFFFFFFFFFFFFFFF
AllowedChannelsTable5 = FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000000000000000000000000000000000000000000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000FF000000FF000000FF000000FF000000FF000000000000000000000000000000

SpectrumManagement = 0          # 0 - Disable 802.11h, 1 - Enable

RxBroadcastInPs = 1

#arp ip filter - must be written 8 characters for example 10.2.43.3 -> 0a 02 2b 21 and not a 2 2b 21
ArpIp_Addr = 0a 02 0a b7
ArpIp_Filter_ena = 0


#mac filter
Mac_Filter_Enabled = 0
numGroupAddrs = 4
Group_addr0 = 10 01 02 03 04 05
Group_addr1 = 11 11 12 13 14 15
Group_addr2 = 12 21 22 23 24 25
Group_addr3 = 13 31 32 33 34 35
Group_addr4 = 14 41 42 43 44 45
Group_addr5 = 15 51 52 53 54 55
Group_addr6 = 16 61 62 63 64 65
Group_addr7 = 17 71 72 73 74 75

#beacon filter
Beacon_Filter_Desired_State = 1
Beacon_Filter_Stored = 1

#beacon IE table
#the size is the len of the string - spaces = number of bytes
Beacon_IE_Num_Of_Elem = 16
Beacon_IE_Table_Size = 37
Beacon_IE_Table = 00 01 01 01 32 01 2a 01 03 01 06 01 07 01 20 01 25 01 23 01 30 01 28 01 2e 01 3d 01 85 01 dd 01 00 52 f2 02 00 01

# rate policy - short / long retries
RatePolicyUserShortRetryLimit   = 10
RatePolicyUserLongRetryLimit    = 10

#rate policies
#rates guide: -->>mcs7,msc6,mcs5,mcs4,mcs3,mcs2,mcs1,mcs0,54,58,36,24,22,18,12,11,9,6,5.5,2,1


OsDbgState = 0x01e9003c         # -1 or 0xffffffff -all (opens debug messages in o.s. only - sevirity+modules)

#############################################################
#   Configure the severity table (0 = Disable/ 1 = Enable)
#
#   Byte #0: Init
#   Byte #1: Information
#   Byte #2: Warning
#   Byte #3: Error
#   Byte #4: Fatal Error
#   Byte #5: SM
#   Byte #6: Console
#############################################################

# LAUNCH Logging Mask
ReportSeverityTable = 0000000
# Default Logging Mask
# ReportSeverityTable = 0001101

BeaconReceiveTime = 50

#
# QOS UPSD
#

desiredPsMode       = 1          # Global Power save delivery protocol (1 - UPSD, 0 - Legacy)
QOS_wmePsModeBE     = 0          # Power save delivery protocol for BE AC (1 - UPSD, 0 - Legacy)
QOS_wmePsModeBK     = 0          # Power save delivery protocol for BK AC (1 - UPSD, 0 - Legacy)
QOS_wmePsModeVI     = 0          # Power save delivery protocol for VI AC (1 - UPSD, 0 - Legacy)
QOS_wmePsModeVO     = 1          # Power save delivery protocol for VO AC (1 - UPSD, 0 - Legacy)

#
# QOS Classifier
#
Clsfr_Type = 1                  # 1 - DSCP, 2 - Port, 3 - IP+port


NumOfCodePoints = 4
DSCPClassifier00_CodePoint = 0                #Best Effort
DSCPClassifier00_DTag = 0

DSCPClassifier01_CodePoint = 8                #Background
DSCPClassifier01_DTag = 1

DSCPClassifier02_CodePoint = 40               #Video
DSCPClassifier02_DTag = 5

DSCPClassifier03_CodePoint = 56               #Voice
DSCPClassifier03_DTag = 6

dot11MaxReceiveLifetime=512000

WiFiAdhoc = 1
WiFiWmmPS = 0	# Use 1 on WiFi test in order to configure PS to work in WMM mode

TriggeredScanTimeOut = 50000 # Maximum time in Us between 2 channels on triggered scan
# PsPoll delivery failure solution
PsPollDeliveryFailureRecoveryPeriod = 20		# Time in Ms to stay ACTIVE ('0' to disable feature)
ConsecutivePsPollDeliveryFailureThreshold = 4   # Number of failed PsPoll's to start ACTIVE time out


# Weights in percent for RSSI/SNR Average calculations
RssiBeaconAverageWeight = 20
RssiPacketAverageWeight = 10
SnrBeaconAverageWeight = 20
SnrPacketAverageWeight = 10

HT_Enable=1                     # 0 = disable 802.11n support / 1=Enable
IbssProtectionType = 1          # 0 = CTS protaction disable ; 1 = Standard CTS protaction
BurstModeEnable = 1             # 0 - Disabled  1 - Enabled
RoamScanEnable = 1              # 1- roaming and immidate scan enable by deafult 0- allowing roaming & scannig due to CLI confguration
RoamingOperationalMode = 1      # 0=Manual , 1=Auto

SendTspecInReassPkt = 0 # 0=do not send, 1=send

FmCoexuSwallowPeriod = 5
FmCoexuNDividerFrefSet2 = 12
FmCoexuMDividerFrefSet2 = 148

BaPolicyTid_0 = 3

##############################################################################################################################
################################################## Radio parameters data - Start #############################################
##############################################################################################################################

################################ General parameters ################################
STRFRefClock = 9                # Unit: Options 5'bXX000 : Bit 0,1,2 - (0: 19.2MHz; 1: 26MHz; 2: 38.4MHz  (Default); 3: 52MHz;  4: 38.4MHz XTAL) ;
                                # 5'bX0XXX : Bit 3 - CLK_REQ type;  0 = wired-OR (Default) , 1= push-pull
                                # 5'b0XXXX : Bit 4 - CLK_REQ polarity; 0 = Normal (Default) , 1=Inverted, Format: Unsigned, Source: Customer
STRFRefClockSettingTime = 5
TXBiPFEMAutoDetect = 0          # Unit: Options (0: Manual Mode; 1: Automatic mode), Format: Unsigned, Source: Customer
TXBiPFEMManufacturer = 1        # Unit: Options (0: RFMD; 1: Triquint), Format: Unsigned, Source: Customer
ClockValidOnWakeup = 0
DC2DCMode = 0                   # Unit: Options (0: btSPI is not used; 1: mux DC2DC mode to BT_FUNC2), Format: Unsigned, Source: Customer
Single_Dual_Band_Solution = 1   # Unit: Options (0: Single band. 2.4GHz only; 1: Dual band = 2.4GHz and 5GHz solution), Format: Unsigned, Source: Customer
# SEMC_BEGIN (DMS00718059 New inifile for W-LN/BT for AP1 build w.50)
Settings  = 65                  #  0x41 Unit: Options (Bit0: NBI (0: Off; 1: On), Bit1: Telec channel 14 (0: Off; 1: On), Format: Unsigned, Source: Customer
                                # Bit2: FEM0-LB, Bit3: FEM0-HB, Bit4: FEM1-LB, Bit5: FEM1-HB - TX BiP load (0: Internal; 1: External),
                                # Bit6: LPD Low band, Bit7: LPD High band
# SEMC_END (DMS00718059 New inifile for W-LN/BT for AP1 build w.50)

# Smart Reflex params
SRState = 1                                 # Unit: Options ( 1 - Enabled ��?0- Disabled) Format: Decimal, Source: TI
SRF1 = 07,03,18,10,05,fb,f0,e8, 0,0,0,0,0,0,0f,3f  # Unit: SRF1 values, Format: Signed, Source: TI
SRF2 = 07,03,18,10,05,f6,f0,e8              # Unit: SRF2 values, Format: Signed, Source: TI
SRF3 = 07,03,18,10,05,fb,f0,e8              # Unit: SRF3 values, Format: Signed, Source: TI

################################ FEM dependents parameters #######################################
###################### FEM1 parameters ######################

# (for Single bend 2.4G parameters FEM1 (TQS 2.5) HDK20)

RxTraceInsertionLoss_2_4G = 0x12
# RxTraceInsertionLoss_2_4G = 0
TXTraceLoss_2_4G  = 0x12
# TXTraceLoss_2_4G  = 0
RxRssiAndProcessCompensation_2_4G = ec,f6,00,0c,18,f8,fc,00,08,10,f0,f8,00,0a,14
TXBiPReferencePDvoltage_2_4G = 375  # 0x177
TxBiPReferencePower_2_4G = 128      # 0x80
TxBiPOffsetdB_2_4G = 0
TxPerRatePowerLimits_2_4G_Normal = 1a, 1f, 23, 23, 23, 27
# TxPerRatePowerLimits_2_4G_Normal = 1d, 1f, 22, 26, 28, 29
TxPerRatePowerLimits_2_4G_Degraded = 1a, 1f, 22, 24, 26, 26
# TxPerRatePowerLimits_2_4G_Degraded = 1a, 1f, 22, 24, 26, 28
TxPerRatePowerLimits_2_4G_Extreme = 16, 1d, 1e, 20, 24, 23 # Unit: 1/2dB, Format: Signed, Source: Customer
# TxPerRatePowerLimits_2_4G_Extreme = 16, 1d, 1e, 20, 24, 25 # Unit: 1/2dB, Format: Signed, Source: Customer
DegradedLowToNormalThr_2_4G = 30 # 0x1e Unit: 1/10 volts, Format: Unsigned, Source: TI
NormalToDegradedHighThr_2_4G = 45 # 0x2d Unit: 1/10 volts, Format: Unsigned, Source: TI
TxPerChannelPowerLimits_2_4G_11b = 50,50,50,50,50,50,50,50,50,50,50,50,50,50
TxPerChannelPowerLimits_2_4G_OFDM = 50,50,50,50,50,50,50,50,50,50,50,50,50,50
TxPDVsRateOffsets_2_4G = 01,02,02,02,02,00
# for Triquent 2.5 should use this, but needs factory OTP support, for now use the same as Triquent 2.6
#TxIbiasTable_2_4G = 11,11,15,11,15,0f
TxIbiasTable_2_4G = 15,15,15,11,15,15
RxFemInsertionLoss_2_4G  = 14  # 0x0e
EOF
					  chown 0.0 /system/etc/wifi/tiwlan.ini; chmod 644 /system/etc/wifi/tiwlan.ini
					  echo " Mint! /system/etc/wifi/tiwlan.ini was created!"
					  echo $line
					  echo ""
					  $sleep
					  echo " Have fun testing wifi speed..."
					  echo ""
					  $sleep
					  echo "                      ...to see if it works :o)"
					  echo ""
					  $sleep
					  echo " Just toggle wifi on and off and test now!"
					  echo ""
					  $sleep
					  echo " ...if it don't work... come back and \"UnBurn\"!";;
					*)echo "           No Placebo for You! :p lol"; break;;
				esac
			  fi
			  echo ""
			  $sleep
			  echo $line
			  echo "           Wi-Fi AfterBurner Complete!"
			  break;;
		  u|U)setting="changed"
			  burner=
			  if [ "`busybox find /system -iname tiwlan*.un3g`" ]; then
				for i in `busybox find /system -iname "tiwlan*.ini"`; do
					if [ -f "$i.un3g" ]; then
						echo ""
						$sleep
						if [ -s "$i.un3g" ]; then
							echo " Restoring ORIGINAL ${i##*/}..."
							mv $i.un3g $i
						else
							echo " Removing ${i##*/}..."
							rm $i; rm $i.un3g
						fi
						echo ""
						$sleep
						echo $line
					fi
				done
				echo "                 Wi-Fi Un-Burned!"
			  else echo "     Can't Un-Burn Wi-Fi! No Backups Found!"
			  fi
			  break;;
		  x|X)echo " Returning to main menu..."
			  break;;
			*)echo "      Invalid entry... Please try again :p"
			  echo $line
			  echo ""
			  $sleep;;
		esac
	 done;;
  8) echo "             ======================"
	 busybox echo "            //// UNTURBOCHARGER \\\\\\\\";;
  9) echo "                ================"
	 busybox echo "               //// WI-FIXER \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " If Wi-Fi doesn't work after using..."
	 echo ""
	 $sleep
	 echo "                ...The 3G TurboCharger..."
	 echo ""
	 $sleep
	 echo "                          ...this MIGHT fix it!"
	 echo ""
	 $sleep
	 echo " The problem is often wpa_supplicant.conf..."
	 echo ""
	 $sleep
	 if [ -f "`ls /d*/misc/wifi/wpa_supplicant.conf`" ]; then
		 chown 1000.1010 /d*/misc/wifi/wpa_supplicant.conf; chmod 660 /d*/misc/wifi/wpa_supplicant.conf
		 echo $line
		 echo " So proper permissions were just applied to it!"
		 echo $line
		 echo ""
		 $sleep
		 echo $line
		 echo "   Toggle WiFi Off/On NOW to see if it works!"
		 echo $line
		 echo ""
		 $sleep
		 echo " If it works, you're already done..."
		 echo ""
		 $sleep
		 echo "             ...and should choose to exit next!"
		 echo ""
		 $sleep
		 echo " If not... I hope \"Plan B\" works... lol"
		 echo ""
		 $sleep
		 echo -n " Press The Enter Key... "
		 read enter
		 echo ""
		 echo $line
		 echo ""
		 $sleep
	 fi 2>/dev/null
	 echo " This will simply rename wpa_supplicant.conf..."
	 echo ""
	 $sleep
	 echo "               ...so that a new one is created!"
	 echo ""
	 $sleep
	 echo " First, Turn Wifi OFF..."
	 echo ""
	 $sleep
	 echo "            ...Apply The WiFi-xer..."
	 echo ""
	 $sleep
	 echo "                          ...then Turn WiFi ON!"
	 echo ""
	 $sleep
	 echo $line
	 echo " Note: You will need to re-enter WiFi passwords!"
	 echo $line
	 echo ""
	 $sleep
	 echo " This will overwrite previously renamed file!"
	 echo ""
	 $sleep
	 echo " Un-Wi-Fixer will restore the renamed file!"
	 echo ""
	 while :; do
		echo $line
		echo ""
		$sleep
		echo -n " Enter Wi-(F)ixer, (U)n-Wi-Fixer, E(X)it: "
		read wifixer
		echo ""
		echo $line
		case $wifixer in
		  f|F)if [ -f "/d*/misc/wifi/wpa_supplicant.conf" ]; then
				mv /d*/misc/wifi/wpa_supplicant.conf /d*/misc/wifi/wpa_supplicant.conf.un3g
				echo " Current wpa_supplicant.conf was saved..."
				echo ""
				$sleep
				echo " ...as /*data/misc/wifi/wpa_supplicant.conf.un3g"
			  else echo " oops... did NOT find wpa_supplicant.conf!"
			  fi
			  echo $line
			  echo ""
			  $sleep
			  echo " Another Tip: Unplug and Replug your router...."
			  echo ""
			  $sleep
			  echo "                    ....before turning on WiFi!"
			  echo ""
			  break;;
		  u|U)if [ -f "/d*/misc/wifi/wpa_supplicant.conf.un3g" ]; then
				cp -fr /d*/misc/wifi/wpa_supplicant.conf.un3g /d*/misc/wifi/wpa_supplicant.conf
				echo " wpa_supplicant.conf was restored!"
			  else echo " oops... did NOT find wpa_supplicant.conf.un3g!"
			  fi
			  break;;
		  x|X)echo " Returning to main menu..."
			  break;;
			*)echo "      Invalid entry... Please try again :p";;
		esac
	 done;;
  10)echo "                ================="
	 echo "               //// HELP FILE \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Loading Help File..."
	 echo ""
	 $sleep
	 su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!3GTurboCharger.html"
	 echo ""
	 echo " I hope that helped! :^)"
	 echo "";;
 11) echo $line
	 echo ""
	 echo " Loading Google Play..."
	 echo ""
	 $sleep
	 su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start http://play.google.com/store/apps/details?id=org.zwanoo.android.speedtest"
	 echo "";;
 12) echo $line
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
 13) echo " Did you find this useful? Feedback is welcome!";;
  *) echo "      Invalid entry... Please try again..."
	 echo ""
	 sleep 2
	 echo "            1 <= Valid Option => 13 !!"
	 echo ""
	 sleep 2
	 echo -n "     Press the Enter Key to continue... ;) "
	 read enterKey
	 echo ""
	 turboopt=0;;
 esac
 if [ "$turboopt" -ge 1 ] && [ "$turboopt" -le 13 ]; then
	echo $line
	echo ""
	$sleep
	if [ "$turboopt" -eq 8 ] && [ ! "`grep "3G Settings" /system/build.prop`" ]; then echo "  Nice Try! No 3G TurboCharger Settings Found!"
	elif [ "$turboopt" -le 8 ] && [ "$turboopt" -ne 7 ]; then
		if [ "$turboopt" -ne 8 ]; then
			if [ -f "/system/build.prop.unsuper" ]; then
				echo " Leaving ORIGINAL build.prop backup intact..."
			else
				echo " Backing up ORIGINAL build.prop..."
				echo ""
				$sleep
				cp -r /system/build.prop /system/build.prop.unsuper
				if [ "`diff /system/build.prop /system/build.prop.unsuper`" ]; then echo " ERROR BACKING UP /system/build.prop!"
				else echo "              ...as /system/build.prop.unsuper!"
				fi
			fi
			if [ -f "/system/bin/build.prop" ] && [ ! -f "/system/bin/build.prop.unsuper" ]; then cp -r /system/bin/build.prop /system/bin/build.prop.unsuper; fi
			$sleep
		else
			echo -n "         :|"
			sleep 3
			echo -n "    !@#?&%(*)(*)&(!)?!"
			sleep 3
			echo "    :/"
			sleep 3
		fi
		echo ""
		sed -i '/TurboCharger by/,/TurboCharged/d' /system/build.prop
		if [ "$turboopt" -ne 8 ]; then
			sed -i '2 a\
# 3G TurboCharger by zeppelinrox.\
#\
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
#\
# Homework/Background Info... see the following links for resources used.\
# http://forum.xda-developers.com/showthread.php?t=595108\
# http://forum.xda-developers.com/showthread.php?t=924440\
# http://forum.xda-developers.com/showpost.php?p=5123531&postcount=46\
# http://www.nickshertzer.com/wordpress/?p=600\
#\
# '$tcconfig' 3G Settings\
#\
ro.ril.hsxpa='$hsxpa'\
ro.ril.gprsclass='$gprsclass'\
ro.ril.hep=1\
ro.ril.hsdpa.category='$hsdpa'\
ro.ril.enable.3g.prefix=1\
ro.ril.htcmaskw1.bitmask='$bitmask'\
ro.ril.htcmaskw1='$htcmaskw1'\
ro.ril.hsupa.category='$hsupa'\
ro.ril.enable.sdr=1\
ro.ril.enable.gea3=1\
ro.ril.enable.fd.plmn.prefix=23402,23410,23411\
ro.ril.disable.power.collapse='$dpc'\
ro.ril.def.agps.mode=2\
# Note for the next setting - GSM=1, CDMA=2\
ro.ril.def.agps.feature=1\
# Note for the next setting - Credit and Thanks to metalspring at XDA\
ril.cdma.ppp.up=\
# Note for the next setting - Credit and Thanks to motcher41 at XDA\
persist.ril.uart.flowctrl=10\
ro.mot.eri.losalert.delay=2000\
ro.ril.enable.a52='$afivetwo'\
ro.ril.enable.a53='$afivethree'\
ro.ril.enable.dtm='$dtm'\
# To fix connection issues, change "enable.a53" and "enable.dtm" to be =0\
# End of 3G TurboCharged Entries.' /system/build.prop
			if [ "`grep ro.cdma /system/build.prop`" ] || [ "`grep CdmaDevice /system/build.prop`" ]; then sed -i 's/agps.feature=1/agps.feature=2/' /system/build.prop; fi
			if [ ! "`grep SuperCharged /system/build.prop`" ] && [ ! "`grep SuperCharged /data/local.prop`" ];then sed -i '/fix connection/ a\
#\
net.dns1=8.8.8.8\
net.dns2=8.8.4.4\
net.tcp.buffersize.default=6144,87380,110208,6144,16384,110208\
net.tcp.buffersize.wifi=262144,524288,1048576,262144,524288,1048576\
net.tcp.buffersize.lte=262144,524288,3145728,262144,524288,3145728\
net.tcp.buffersize.hsdpa=6144,262144,1048576,6144,262144,1048576\
net.tcp.buffersize.evdo_b=6144,262144,1048576,6144,262144,1048576\
net.tcp.buffersize.umts=6144,87380,110208,6144,16384,110208\
net.tcp.buffersize.hspa=6144,87380,262144,6144,16384,262144\
net.tcp.buffersize.gprs=6144,8760,11680,6144,8760,11680\
net.tcp.buffersize.edge=6144,26280,35040,6144,16384,35040\
#' /system/build.prop
			fi 2>/dev/null
			echo $line
			echo " $tcconfig Settings installed..."
		else
			echo $line
			echo " UnTurboCharging Complete..."
		fi
		echo $line
		echo ""
		$sleep
		echo "                            ...Reboot Required!"
		setting="changed"
		if [ -f "/system/bin/build.prop" ]; then cp -fr /system/build.prop /system/bin; fi
#		chmod 644 /system/build.prop
#		chmod 644 /system/bin/build.prop
	fi
	if [ "$turboopt" -le 8 ] && [ "$turboopt" -ne 7 ]; then
		echo ""
		echo $line
		echo ""
		$sleep
	fi
	echo " The 3G TurboCharger Installer..."
	echo ""
	$sleep
	echo "     ...Wi-Fi AfterBurner and WiFi-xer..."
	echo ""
	$sleep
	echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
	echo ""
	if [ "$turboopt" -eq 13 ]; then
		$sleep
		echo "                                    Buh Bye ;^]"
		echo ""
		echo $line
		echo ""
		$sleep
		exit 0
	fi
	if [ "$madesqlitefolder" -eq 1 ]; then rm -r /sqlite_stmt_journals; fi 2>/dev/null
	busybox mount -o remount,ro / 2>/dev/null
	busybox mount -o remount,ro rootfs 2>/dev/null
	mount -o remount,ro /system 2>/dev/null
	busybox mount -o remount,ro /system 2>/dev/null
	busybox mount -o remount,ro $(busybox mount | grep system | awk '{print $1,$3}' | sed -n 1p) 2>/dev/null
 fi
done
