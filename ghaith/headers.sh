# Reset
Color_Off='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

user=$(whoami)
day=$(date +%A)
Color_RED="\033[1;31m"
Color_Cyan='\033[0;36m'
Color_Blue='\033[0;23m'
Color_Green='\033[0;32m'
Color_Off="\033[0m"
NOW=$(date +%Y-%m-%d_%H-%M-%S)
IP='hostname -I'
CPU= ;
clear
function LoadingBar {
    let _progress=(${1}*100/${2}*100)/100
    let _done=(${_progress}*4)/10
    let _left=40-$_done
    _fill=$(printf "%${_done}s")
    _empty=$(printf "%${_left}s")
printf "\rLoading : ${_fill// /${Color_Green}▇${Color_Off}}${_empty// /${Color_Blue}-${Color_Off}} ${_progress}%%"
}


# _start=1
# _end=10

# for number in $(seq ${_start} ${_end})
# do
#     sleep 0.1
#     LoadingBar ${number} ${_end}
# done
# printf '\nFinished!\n'
#     sleep 0.2
clear
#sudo apt update
#sudo apt upgrade -y
#clear





ELAPSED_TIME=0
ELAPSED_TIME1=0
ELAPSED_TIME2=0
ELAPSED_TIME3=0
ELAPSED_TIME4=0
ELAPSED_TIME5=0
ELAPSED_TIME6=0
ELAPSED_TIME7=0
ELAPSED_TIME8=0
ELAPSED_TIME9=0


# Disk Usage Detection - Begin
detectdisk () {
	diskusage="Unknown"
	if type -p df >/dev/null 2>&1; then
		if [[ "${distro}" =~ (Free|Net|DragonFly)BSD ]]; then
			totaldisk=$(df -h -c 2>/dev/null | tail -1)
		elif [[ "${distro}" == "OpenBSD" ]]; then
			totaldisk=$(df -Pk 2> /dev/null | awk '
				/^\// {total+=$2; used+=$3; avail+=$4}
				END{printf("total %.1fG %.1fG %.1fG %d%%\n", total/1048576, used/1048576, avail/1048576, used*100/total)}')
		elif [[ "${distro}" == "Mac OS X" || "${distro}" == "macOS" ]]; then
                        majorVers=$(sw_vers | grep "ProductVersion" | cut -d ':' -f 2 | awk -F "." '{print $1}') # Major version
			minorVers=$(sw_vers | grep "ProductVersion" | cut -d ':' -f 2 | awk -F "." '{print $2}') # Minor version
			if [[ "${minorVers}" -ge "15" || "${majorVers}" -ge "11" ]]; then # Catalina or newer
				totaldisk=$(df -H /System/Volumes/Data 2>/dev/null | tail -1)
			else
				totaldisk=$(df -H / 2>/dev/null | tail -1)
			fi
		else
			totaldisk=$(df -h -x aufs -x tmpfs -x overlay -x drvfs -x devtmpfs --total 2>/dev/null | tail -1)
		fi
		disktotal=$(awk '{print $2}' <<< "${totaldisk}")
		diskused=$(awk '{print $3}' <<< "${totaldisk}")
		diskusedper=$(awk '{print $5}' <<< "${totaldisk}")
		diskusage="${diskused} / ${disktotal} (${diskusedper})"
		diskusage_verbose=$(sed 's/%/%%/' <<< "$diskusage")
	fi
	verboseOut "Finding current disk usage...found as '$diskusage_verbose'"
}
# Disk Usage Detection - End
colorize () {
	printf $'\033[0m\033[38;5;%sm' "$1"
}
getColor () {
	local tmp_color=""
	if [[ -n "$1" ]]; then
		if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
			if [[ ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -gt 1 ]] || [[ ${BASH_VERSINFO[0]} -gt 4 ]]; then
				tmp_color=${1,,}
			else
				tmp_color="$(tr '[:upper:]' '[:lower:]' <<< "${1}")"
			fi
		else
			tmp_color="$(tr '[:upper:]' '[:lower:]' <<< "${1}")"
		fi
		case "${tmp_color}" in
			# Standards
			'black')					color_ret='\033[0m\033[30m';;
			'red')						color_ret='\033[0m\033[31m';;
			'green')					color_ret='\033[0m\033[32m';;
			'brown')					color_ret='\033[0m\033[33m';;
			'blue')						color_ret='\033[0m\033[34m';;
			'purple')					color_ret='\033[0m\033[35m';;
			'cyan')						color_ret='\033[0m\033[36m';;
			'yellow')					color_ret='\033[0m\033[1;33m';;
			'white')					color_ret='\033[0m\033[1;37m';;
			# Bolds
			'dark grey'|'dark gray')	color_ret='\033[0m\033[1;30m';;
			'light red')				color_ret='\033[0m\033[1;31m';;
			'light green')				color_ret='\033[0m\033[1;32m';;
			'light blue')				color_ret='\033[0m\033[1;34m';;
			'light purple')				color_ret='\033[0m\033[1;35m';;
			'light cyan')				color_ret='\033[0m\033[1;36m';;
			'light grey'|'light gray')	color_ret='\033[0m\033[37m';;
			# Some 256 colors
			'orange')					color_ret="$(colorize '202')";; #DarkOrange
			'light orange') 			color_ret="$(colorize '214')";; #Orange1
			# HaikuOS
			'black_haiku') 				color_ret="$(colorize '7')";;
			#ROSA color
			'rosa_blue') 				color_ret='\033[01;38;05;25m';;
			# ArcoLinux
			'arco_blue') color_ret='\033[1;38;05;111m';;
		esac
		[[ -n "${color_ret}" ]] && echo "${color_ret}"
	fi
}
colorNumberToCode () {
	local number="$1"
	if [[ "${number}" == "na" ]]; then
		unset code
	elif [[ $(tput colors) -eq "256" ]]; then
		code=$(colorize "${number}")
	else
		case "$number" in
			0|00) code=$(getColor 'black');;
			1|01) code=$(getColor 'red');;
			2|02) code=$(getColor 'green');;
			3|03) code=$(getColor 'brown');;
			4|04) code=$(getColor 'blue');;
			5|05) code=$(getColor 'purple');;
			6|06) code=$(getColor 'cyan');;
			7|07) code=$(getColor 'light grey');;
			8|08) code=$(getColor 'dark grey');;
			9|09) code=$(getColor 'light red');;
			  10) code=$(getColor 'light green');;
			  11) code=$(getColor 'yellow');;
			  12) code=$(getColor 'light blue');;
			  13) code=$(getColor 'light purple');;
			  14) code=$(getColor 'light cyan');;
			  15) code=$(getColor 'white');;
			*) unset code;;
		esac
	fi
	echo -n "${code}"
}
detectColors () {
	my_colors=$(sed 's/^,/na,/;s/,$/,na/;s/,/ /' <<< "${OPTARG}")
	my_lcolor=$(awk -F' ' '{print $1}' <<< "${my_colors}")
	my_lcolor=$(colorNumberToCode "${my_lcolor}")
	my_hcolor=$(awk -F' ' '{print $2}' <<< "${my_colors}")
	my_hcolor=$(colorNumberToCode "${my_hcolor}")
}

	# Truncate lines based on terminal width.
	if [ "$truncateSet" == "Yes" ]; then
		missinglines=$((${#out_array[*]} + startline - ${#fulloutput[*]}))
		for ((i=0; i<missinglines; i++)); do
			fulloutput+=("${c1}$(printf '%*s' "$logowidth")%s")
		done
		for ((i=0; i<${#fulloutput[@]}; i++)); do
			my_out=$(printf "${fulloutput[i]}$c0\n" "${out_array}")
			my_out_full=$(echo "$my_out" | cat -v)
			termWidth=$(tput cols)
			SHOPT_EXTGLOB_STATE=$(shopt -p extglob)
			read SHOPT_CMD SHOPT_STATE SHOPT_OPT <<< "${SHOPT_EXTGLOB_STATE}"
			if [[ ${SHOPT_STATE} == "-u" ]]; then
				shopt -s extglob
			fi

			stringReal="${my_out_full//\^\[\[@([0-9]|[0-9];[0-9][0-9])m}"

			if [[ ${SHOPT_STATE} == "-u" ]]; then
				shopt -u extglob
			fi

			if [[ "${#stringReal}" -le "${termWidth}" ]]; then
				echo -e "${my_out}"$c0
			elif [[ "${#stringReal}" -gt "${termWidth}" ]]; then
				((NORMAL_CHAR_COUNT=0))
				for ((j=0; j<=${#my_out_full}; j++)); do
					if [[ "${my_out_full:${j}:3}" == '^[[' ]]; then
						if [[ "${my_out_full:${j}:5}" =~ ^\^\[\[[[:digit:]]m$ ]]; then
							if [[ ${j} -eq 0 ]]; then
								j=$((j + 5))
							else
								j=$((j + 4))
							fi
						elif [[ "${my_out_full:${j}:8}" =~ ^\^\[\[[[:digit:]]\;[[:digit:]][[:digit:]]m ]]; then
							if [[ ${j} -eq 0 ]]; then
								j=$((j + 8))
							else
								j=$((j + 7))
							fi
						fi
					else
						((NORMAL_CHAR_COUNT++))
						if [[ ${NORMAL_CHAR_COUNT} -ge ${termWidth} ]]; then
							echo -e "${my_out:0:$((j - 5))}"$c0
							break 1
						fi
					fi
				done
			fi

			if [[ "$i" -ge "$startline" ]]; then
				unset 'out_array[0]'
				out_array=( "${out_array[@]}" )
			fi
		done
	elif [[ "$portraitSet" = "Yes" ]]; then
		for i in "${!fulloutput[@]}"; do
			printf "${fulloutput[$i]}$c0\n"
		done

		printf "\n"

		for ((i=0; i<${#fulloutput[*]}; i++)); do
			[[ -z "$out_array[0]" ]] && continue
			printf "%s\n" "${out_array[0]}"
			unset 'out_array[0]'
			out_array=( "${out_array[@]}" )
		done

	elif [[ "$display_logo" == "Yes" ]]; then
		for i in "${!fulloutput[@]}"; do
			printf "${fulloutput[i]}$c0\n"
		done
	else
		if [[ "$lineWrap" = "Yes" ]]; then
			availablespace=$(($(tput cols) - logowidth + 16)) #I dont know why 16 but it works
			new_out_array=("${out_array[0]}")
			for ((i=1; i<${#out_array[@]}; i++)); do
				lines=$(echo "${out_array[i]}" | fmt -w $availablespace)
				IFS=$'\n' read -rd '' -a splitlines <<<"$lines"
				new_out_array+=("${splitlines[0]}")
				for ((j=1; j<${#splitlines[*]}; j++)); do
					line=$(echo -e "$labelcolor $textcolor  ${splitlines[j]}")
					new_out_array=( "${new_out_array[@]}" "$line" );
				done
			done
			out_array=("${new_out_array[@]}")
		fi
		missinglines=$((${#out_array[*]} + startline - ${#fulloutput[*]}))
		for ((i=0; i<missinglines; i++)); do
			fulloutput+=("${c1}$(printf '%*s' "$logowidth")%s")
		done
		#n=${#fulloutput[*]}
		for ((i=0; i<${#fulloutput[*]}; i++)); do
			# echo "${out_array[@]}"
			case $(awk 'BEGIN{srand();print int(rand()*(1000-1))+1 }') in
				411|188|15|166|609)
					f_size=${#fulloutput[*]}
					o_size=${#out_array[*]}
					f_max=$(( 32768 / f_size * f_size ))
					#o_max=$(( 32768 / o_size * o_size ))
					for ((a=f_size-1; a>0; a--)); do
						while (( (rand=RANDOM) >= f_max )); do :; done
						rand=$(( rand % (a+1) ))
						tmp=${fulloutput[a]} fulloutput[a]=${fulloutput[rand]} fulloutput[rand]=$tmp
					done
					for ((b=o_size-1; b>0; b--)); do
						rand=$(( rand % (b+1) ))
						tmp=${out_array[b]} out_array[b]=${out_array[rand]} out_array[rand]=$tmp
					done
				;;
			esac
			printf "${fulloutput[i]}$c0\n" "${out_array[0]}"
			if [[ "$i" -ge "$startline" ]]; then
				unset 'out_array[0]'
				out_array=( "${out_array[@]}" )
			fi
		done
	fi
	# Done with ASCII output

# Memory Detection - Begin
detectmem () {
	if [[ "$distro" == "Mac OS X" || "$distro" == "macOS" ]]; then
		totalmem=$(echo "$(sysctl -n hw.memsize)" / 1024^2 | bc)
		wiredmem=$(vm_stat | grep wired | awk '{ print $4 }' | sed 's/\.//')
		activemem=$(vm_stat | grep ' active' | awk '{ print $3 }' | sed 's/\.//')
		compressedmem=$(vm_stat | grep occupied | awk '{ print $5 }' | sed 's/\.//')
		if [[ ! -z "$compressedmem | tr -d" ]]; then  # FIXME: is this line correct?
			compressedmem=0
		fi
		usedmem=$(((wiredmem + activemem + compressedmem) * 4 / 1024))
	elif [[ "${distro}" == "Cygwin" || "${distro}" == "Msys" ]]; then
		total_mem=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
		totalmem=$((total_mem / 1024))
		free_mem=$(awk '/MemFree/ { print $2 }' /proc/meminfo)
		used_mem=$((total_mem - free_mem))
		usedmem=$((used_mem / 1024))
	elif [[ "$distro" == "FreeBSD"  || "$distro" == "DragonFlyBSD" ]]; then
		phys_mem=$(sysctl -n hw.physmem)
		size_mem=$phys_mem
		size_chip=1
		guess_chip=$(echo "$size_mem / 8 - 1" | bc)
		while [ "$guess_chip" != 0 ]; do
			guess_chip=$(echo "$guess_chip / 2" | bc)
			size_chip=$(echo "$size_chip * 2" | bc)
		done
		round_mem=$(echo "( $size_mem / $size_chip + 1 ) * $size_chip " | bc)
		totalmem=$((round_mem / 1024 / 1024))
		pagesize=$(sysctl -n hw.pagesize)
		inactive_count=$(sysctl -n vm.stats.vm.v_inactive_count)
		inactive_mem=$((inactive_count * pagesize))
		cache_count=$(sysctl -n vm.stats.vm.v_cache_count)
		cache_mem=$((cache_count * pagesize))
		free_count=$(sysctl -n vm.stats.vm.v_free_count)
		free_mem=$((free_count * pagesize))
		avail_mem=$((inactive_mem + cache_mem + free_mem))
		used_mem=$((round_mem - avail_mem))
		usedmem=$((used_mem / 1024 / 1024))
	elif [ "$distro" == "OpenBSD" ]; then
		totalmem=$(($(sysctl -n hw.physmem) / 1024 / 1024))
		usedmem=$(vmstat | awk '!/[a-z]/{gsub("M",""); print $3}')
	elif [ "$distro" == "NetBSD" ]; then
		phys_mem=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
		totalmem=$((phys_mem / 1024))
		if grep -q 'Cached' /proc/meminfo; then
			cache=$(awk '/Cached/ {print $2}' /proc/meminfo)
			usedmem=$((cache / 1024))
		else
			free_mem=$(awk '/MemFree/ { print $2 }' /proc/meminfo)
			used_mem=$((phys_mem - free_mem))
			usedmem=$((used_mem / 1024))
		fi
	elif [ "$distro" == "Haiku" ]; then
		totalmem=$(sysinfo -mem | awk 'NR == 1 {gsub(/[\(\)\/]/, ""); printf("%d", $6/1024**2)}')
		usedmem=$(sysinfo -mem | awk 'NR == 1 {gsub(/[\(\)\/]/, ""); printf("%d", $5/1024**2)}')
	else
		MemUsed = Memtotal + Shmem - MemFree - Buffers - Cached - SReclaimable
		Source: https://github.com/dylanaraps/neofetch/pull/391/files#diff-e863270127ca6116fd30e708cdc582fc
		mem_info=$(</proc/meminfo)
		mem_info=$(echo $(echo $(mem_info=${mem_info// /}; echo ${mem_info//kB/})))
		for m in $mem_info; do
			case ${m//:*} in
				"MemTotal") usedmem=$((usedmem+=${m//*:})); totalmem=${m//*:} ;;
				"Shmem") usedmem=$((usedmem+=${m//*:})) ;;
				"MemFree"|"Buffers"|"Cached"|"SReclaimable") usedmem=$((usedmem-=${m//*:})) ;;
			esac
		done
		usedmem=$((usedmem / 1024))
		totalmem=$((totalmem / 1024))
		mem=$(free -b | awk -F ':' 'NR==2{print $2}' | awk '{print $1"-"$6}')
		usedmem=$((mem / 1024 / 1024))
		totalmem=$((${mem//-*} / 1024 / 1024))
	fi
	mem="${usedmem}MiB / ${totalmem}MiB"
	verboseOut "Finding current RAM usage...found as '$mem'"
}
# Memory Detection - End

if [[ "$no_color" != "1" ]]; then
				c1=$(getColor 'white') # White
				c2=$(getColor 'light red') # Light Red
				c3=$(getColor 'yellow') # Bold Yellow
			fi
			if [ -n "${my_lcolor}" ]; then c1="${my_lcolor}"; c2="${my_lcolor}"; c3="${my_lcolor}"; fi
			startline="0"
			logowidth="38"
			fulloutput=(
"${c2}                %s"
"${c2}                %s"
"${c2}                %s"
"${c1}              %s"
"${c1}                   %s"
"${c3}           .++  %s"
"${c3}         .:++o:  %s"
"${c3}        o:+o+:++. %s"
"${c3}       .:+o:+o/. %s"
"${c1}  .++/+:${c3}+oo+o:\` %s"
"${c1} /+++//+:${c3}\`oo+o %s"
"${c1} \+/+o+++${c3}\`o++o %s"
"${c1}  .++.o+${c3}++oo+:\`${c2}             /dddhhh.  %s"
"${c3}       .+.o+oo:.${c2}          \`oddhhhh+   %s"
"${c3}        \+.++o+o\`${c2}\`-\`\`\`\`.:ohdhhhhh+    %s"
"${c3}         \`:o+++ ${c2}\`ohhhhhhhhyo++os:     %s"
"${c3}           .o:${c2}\`.syhhhhhhh/${c3}.oo++o\`     %s"
"${c2}               /osyyyyyyo${c3}++ooo+++/    %s"
"${c2}                   \`\`\`\`\` ${c3}+oo+++o\:    %s"
"${c3}                          \`oo++.      %s")

for i in "${!fulloutput[@]}"; do
			printf "${fulloutput[i]}$c0\n"
		done
detecthost () {
	myUser=${USER}
	myHost=${HOSTNAME}
	if [[ -z "$USER" ]]; then
		myUser=$(whoami)
	fi
	if [[ "${distro}" == "Mac OS X" || "${distro}" == "macOS" ]]; then
		myHost=${myHost/.local}
	fi
}
detectkernel () {
	if [[ "$distro" == "OpenBSD" ]]; then
		kernel=$(uname -a | cut -f 3- -d ' ')
	else
		kernel=$(uname -m && uname -sr)
		kernel=${kernel//$'\n'/ }
	fi
}
for each in "${ubuntu_codenames[@]}"; do
						if [[ "${each,,}" =~ "${distro_codename,,}" ]]; then
							distro_codename="$each"
						fi
					done

if [[ "$overrideDisplay" ]]; then
	verboseOut "Found 'd' flag in syntax. Overriding display..."
	OLDIFS=$IFS
	IFS=';'
	for i in ${overrideDisplay}; do
		modchar="${i:0:1}"
		if [[ "${modchar}" == "-" ]]; then
			i=${i/${modchar}}
			_OLDIFS=IFS
			IFS=,
			for n in $i; do
				if [[ ! "${display[@]}" =~ "$n" ]]; then
					echo "The var $n is not currently being displayed."
				else
					for e in "${!display[@]}"; do
						if [[ ${display[e]} = "$n" ]]; then
							unset 'display[e]'
						fi
					done
				fi
			done
			IFS=$_OLDIFS
		elif [[ "${modchar}" == "+" ]]; then
			i=${i/${modchar}}
			_OLDIFS=IFS
			IFS=,
			for n in $i; do
				if [[ "${valid_display[@]}" =~ "$n" ]]; then
					if [[ "${display[@]}" =~ "$n" ]]; then
						echo "The $n var is already being displayed."
					else
						display+=("$n")
					fi
				else
					echo "The var $n is not a valid display var."
				fi
			done
			IFS=$_OLDIFS
		else
			IFS=$OLDIFS
			i="${i//,/ }"
			display=( "$i" )
		fi
	done
	IFS=$OLDIFS
fi

for i in "${display[@]}"; do
	if [[ -n "$i" ]]; then
		if [[ $i =~ wm ]]; then
			test -z "$WM" && detectwm
			test -z "$Win_theme" && detectwmtheme
		else
			if [[ "${display[*]}" =~ "$i" ]]; then
				if [[ "$errorSuppress" == "1" ]]; then
					detect"${i}" 2>/dev/null
				else
					detect"${i}"
				fi
			fi
		fi
	fi
done



infoDisplay () {
	textcolor="\033[0m"
	[[ "$my_hcolor" ]] && textcolor="${my_hcolor}"
	#TODO: Centralize colors and use them across the board so we only change them one place.
	myascii="${distro}"
	[[ "${asc_distro}" ]] && myascii="${asc_distro}"
	case ${myascii} in
		"Alpine Linux"|"Arch Linux - Old"|"ArcoLinux"|"blackPanther OS"|"Fedora"|"Fedora - Old"|"Korora"|"Chapeau"|"Mandriva"|"Mandrake"| \
		"Chakra"|"ChromeOS"|"Sabayon"|"Slackware"|"Mac OS X"|"macOS"|"Trisquel"|"Kali Linux"|"Jiyuu Linux"|"Antergos"|"Alter Linux"| \
		"KaOS"|"Logos"|"gNewSense"|"Netrunner"|"NixOS"|"SailfishOS"|"Qubes OS"|"Kogaion"|"PCLinuxOS"| \
		"Obarun"|"Siduction"|"Solus"|"SwagArch"|"Parrot Security"|"Zorin OS"|"Uos"|"TeArch")
			labelcolor=$(getColor 'light blue')
		;;
		"Arch Linux"|"Arch Linux 32"|"Artix Linux"|"Frugalware"|"Mageia"|"Deepin"|"CRUX"|"OS Elbrus"|"EndeavourOS")
			labelcolor=$(getColor 'light cyan')
		;;
		"Mint"|"LMDE"|"KDE neon"|"openSUSE"|"SUSE Linux Enterprise"|"LinuxDeepin"|"DragonflyBSD"|"Manjaro"| \
		"Manjaro-tree"|"Android"|"Void Linux"|"DesaOS")
			labelcolor=$(getColor 'light green')
		;;
		"Ubuntu"|"FreeBSD"|"FreeBSD - Old"|"Debian"|"Raspbian"|"BSD"|"Red Hat Enterprise Linux"|"Oracle Linux"| \
		"Peppermint"|"Cygwin"|"Msys"|"Fuduntu"|"Scientific Linux"|"DragonFlyBSD"|"BackTrack Linux"|"Red Star OS"| \
		"SparkyLinux"|"OBRevenge"|"Source Mage GNU/Linux")
			labelcolor=$(getColor 'light red')
		;;
		"ROSA"|"januslinux")
			labelcolor=$(getColor 'white')
		;;
		"CrunchBang"|"Viperr"|"elementary"*)
			labelcolor=$(getColor 'dark grey')
		;;
		"Gentoo"|"Parabola GNU/Linux-libre"|"Funtoo"|"Funtoo-text"|"BLAG"|"SteamOS"|"Devuan")
			labelcolor=$(getColor 'light purple')
		;;
		"Haiku")
			labelcolor=$(getColor 'green')
		;;
		"NetBSD"|"Amazon Linux"|"Proxmox VE")
			labelcolor=$(getColor 'orange')
		;;
		"CentOS"|"CentOS Stream")
			labelcolor=$(getColor 'yellow')
		;;
		"Hyperbola GNU/Linux-libre"|"PureOS"|*)
			labelcolor=$(getColor 'light grey')
		;;
	esac
	[[ "$my_lcolor" ]] && labelcolor="${my_lcolor}"
	if [[ "$art" ]]; then
		source "$art"
	fi
	if [[ "$no_color" == "1" ]]; then
		labelcolor=""
		bold=""
		c0=""
		textcolor=""
	fi
	# Some verbosity stuff
	[[ "$screenshot" == "1" ]] && verboseOut "Screenshot will be taken after info is displayed."
	[[ "$upload" == "1" ]] && verboseOut "Screenshot will be transferred/uploaded to specified location."
	#########################
	# Info Variable Setting #
	#########################
	if [[ "${distro}" == "Android" ]]; then
		myhostname=$(echo -e "${labelcolor} ${hostname}"); out_array=( "${out_array[@]}" "$myhostname" )
		mydistro=$(echo -e "$labelcolor OS:$textcolor $distro $distro_ver"); out_array=( "${out_array[@]}" "$mydistro" )
		mydevice=$(echo -e "$labelcolor Device:$textcolor $device"); out_array=( "${out_array[@]}" "$mydevice" )
		myrom=$(echo -e "$labelcolor ROM:$textcolor $rom"); out_array=( "${out_array[@]}" "$myrom" )
		mybaseband=$(echo -e "$labelcolor Baseband:$textcolor $baseband"); out_array=( "${out_array[@]}" "$mybaseband" )
		mykernel=$(echo -e "$labelcolor Kernel:$textcolor $kernel"); out_array=( "${out_array[@]}" "$mykernel" )
		myuptime=$(echo -e "$labelcolor Uptime:$textcolor $uptime"); out_array=( "${out_array[@]}" "$myuptime" )
		mycpu=$(echo -e "$labelcolor CPU:$textcolor $cpu"); out_array=( "${out_array[@]}" "$mycpu" )
		mygpu=$(echo -e "$labelcolor GPU:$textcolor $cpu"); out_array=( "${out_array[@]}" "$mygpu" )
		mymem=$(echo -e "$labelcolor RAM:$textcolor $mem"); out_array=( "${out_array[@]}" "$mymem" )
	else
		if [[ "${display[@]}" =~ "host" ]]; then
			myinfo=$(echo -e "${labelcolor} ${myUser}$textcolor${bold}@${c0}${labelcolor}${myHost}")
			out_array=( "${out_array[@]}" "$myinfo" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "distro" ]]; then
			if [[ "$distro" == "Mac OS X" || "$distro" == "macOS" ]]; then
				sysArch="$(getconf LONG_BIT)bit"
				prodVers=$(sw_vers | grep 'ProductVersion')
				prodVers=${prodVers:16}
				buildVers=$(sw_vers |grep 'BuildVersion')
				buildVers=${buildVers:14}
				if [ -n "$distro_more" ]; then
					mydistro=$(echo -e "$labelcolor OS:$textcolor $distro_more $sysArch")
				else
					mydistro=$(echo -e "$labelcolor OS:$textcolor $sysArch $distro $prodVers $buildVers")
				fi
			elif [[ "$distro" == "Cygwin" || "$distro" == "Msys" ]]; then
				distro="$(wmic os get caption | sed 's/\r//g; s/[ \t]*$//g; 2!d')"
				if [[ "$(wmic os get version | grep -o '^10\.')" == "10." ]]; then
					distro="$distro (v$(wmic os get version | grep '^10\.' | tr -d ' '))"
				fi
				sysArch=$(wmic os get OSArchitecture | sed 's/\r//g; s/[ \t]*$//g; 2!d')
				mydistro=$(echo -e "$labelcolor OS:$textcolor $distro $sysArch")
			else
				if [ -n "$distro_more" ]; then
					mydistro=$(echo -e "$labelcolor OS:$textcolor $distro_more")
				else
					mydistro=$(echo -e "$labelcolor OS:$textcolor $distro $sysArch")
				fi
			fi
			out_array=( "${out_array[@]}" "$mydistro$wsl" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "kernel" ]]; then
			mykernel=$(echo -e "$labelcolor Kernel:$textcolor $kernel")
			out_array=( "${out_array[@]}" "$mykernel" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "uptime" ]]; then
			myuptime=$(echo -e "$labelcolor Uptime:$textcolor $uptime")
			out_array=( "${out_array[@]}" "$myuptime" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "pkgs" ]]; then
			mypkgs=$(echo -e "$labelcolor Packages:$textcolor $pkgs")
			out_array=( "${out_array[@]}" "$mypkgs" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "shell" ]]; then
			myshell=$(echo -e "$labelcolor Shell:$textcolor $myShell")
			out_array=( "${out_array[@]}" "$myshell" )
			((display_index++))
		fi
		if [[ -n "$DISPLAY" || "$distro" == "Mac OS X" || "$distro" == "macOS" ]]; then
			if [ -n "${xResolution}" ]; then
				if [[ "${display[@]}" =~ "res" ]]; then
					myres=$(echo -e "$labelcolor Resolution:${textcolor} $xResolution")
					out_array=( "${out_array[@]}" "$myres" )
					((display_index++))
				fi
			fi
			if [[ "${display[@]}" =~ "de" ]]; then
				if [[ "${DE}" != "Not Present" ]]; then
					myde=$(echo -e "$labelcolor DE:$textcolor $DE")
					out_array=( "${out_array[@]}" "$myde" )
					((display_index++))
				fi
			fi
			if [[ "${display[@]}" =~ "wm" ]]; then
				mywm=$(echo -e "$labelcolor WM:$textcolor $WM")
				out_array=( "${out_array[@]}" "$mywm" )
				((display_index++))
			fi
			if [[ "${display[@]}" =~ "wmtheme" ]]; then
				if [[ "${Win_theme}" != "Not Applicable" && "${Win_theme}" != "Not Found" ]]; then
					mywmtheme=$(echo -e "$labelcolor WM Theme:$textcolor $Win_theme")
					out_array=( "${out_array[@]}" "$mywmtheme" )
					((display_index++))
				fi
			fi
			if [[ "${display[@]}" =~ "gtk" ]]; then
				if [[ "$distro" == "Mac OS X" || "$distro" == "macOS" ]]; then
					if [[ "$gtkFont" != "Not Applicable" && "$gtkFont" != "Not Found" ]]; then
						if [ -n "$gtkFont" ]; then
							myfont=$(echo -e "$labelcolor Font:$textcolor $gtkFont")
							out_array=( "${out_array[@]}" "$myfont" )
							((display_index++))
						fi
					fi
				else
					if [[ "$gtk2Theme" != "Not Applicable" && "$gtk2Theme" != "Not Found" ]]; then
						if [ -n "$gtk2Theme" ]; then
							mygtk2="${gtk2Theme} [GTK2]"
						fi
					fi
					if [[ "$gtk3Theme" != "Not Applicable" && "$gtk3Theme" != "Not Found" ]]; then
						if [ -n "$mygtk2" ]; then
							mygtk3=", ${gtk3Theme} [GTK3]"
						else
							mygtk3="${gtk3Theme} [GTK3]"
						fi
					fi
					if [[ "$gtk_2line" == "yes" ]]; then
						mygtk2=$(echo -e "$labelcolor GTK2 Theme:$textcolor $gtk2Theme")
						out_array=( "${out_array[@]}" "$mygtk2" )
						((display_index++))
						mygtk3=$(echo -e "$labelcolor GTK3 Theme:$textcolor $gtk3Theme")
						out_array=( "${out_array[@]}" "$mygtk3" )
						((display_index++))
					else
						if [[ "$gtk2Theme" == "$gtk3Theme" ]]; then
							if [[ "$gtk2Theme" != "Not Applicable" && "$gtk2Theme" != "Not Found" ]]; then
								mygtk=$(echo -e "$labelcolor GTK Theme:$textcolor ${gtk2Theme} [GTK2/3]")
								out_array=( "${out_array[@]}" "$mygtk" )
								((display_index++))
							fi
						else
							mygtk=$(echo -e "$labelcolor GTK Theme:$textcolor ${mygtk2}${mygtk3}")
							out_array=( "${out_array[@]}" "$mygtk" )
							((display_index++))
						fi
					fi
					if [[ "$gtkIcons" != "Not Applicable" && "$gtkIcons" != "Not Found" ]]; then
						if [ -n "$gtkIcons" ]; then
							myicons=$(echo -e "$labelcolor Icon Theme:$textcolor $gtkIcons")
							out_array=( "${out_array[@]}" "$myicons" )
							((display_index++))
						fi
					fi
					if [[ "$gtkFont" != "Not Applicable" && "$gtkFont" != "Not Found" ]]; then
						if [ -n "$gtkFont" ]; then
							myfont=$(echo -e "$labelcolor Font:$textcolor $gtkFont")
							out_array=( "${out_array[@]}" "$myfont" )
							((display_index++))
						fi
					fi
				fi
			fi
		elif [[ "$fake_distro" == "Cygwin" || "$fake_distro" == "Msys" || "$fake_distro" == "Windows - Modern" ]]; then
			if [[ "${display[@]}" =~ "res" && -n "$xResolution" ]]; then
				myres=$(echo -e "$labelcolor Resolution:${textcolor} $xResolution")
				out_array=( "${out_array[@]}" "$myres" )
				((display_index++))
			fi
			if [[ "${display[@]}" =~ "de" ]]; then
				if [[ "${DE}" != "Not Present" ]]; then
					myde=$(echo -e "$labelcolor DE:$textcolor $DE")
					out_array=( "${out_array[@]}" "$myde" )
					((display_index++))
				fi
			fi
			if [[ "${display[@]}" =~ "wm" ]]; then
				mywm=$(echo -e "$labelcolor WM:$textcolor $WM")
				out_array=( "${out_array[@]}" "$mywm" )
				((display_index++))
			fi
			if [[ "${display[@]}" =~ "wmtheme" ]]; then
				if [[ "${Win_theme}" != "Not Applicable" && "${Win_theme}" != "Not Found" ]]; then
					mywmtheme=$(echo -e "$labelcolor WM Theme:$textcolor $Win_theme")
					out_array=( "${out_array[@]}" "$mywmtheme" )
					((display_index++))
				fi
			fi
		elif [[ "$distro" == "Haiku" && -n "${xResolution}" && "${display[@]}" =~ "res" ]]; then
			myres=$(echo -e "$labelcolor Resolution:${textcolor} $xResolution")
			out_array=( "${out_array[@]}" "$myres" )
			((display_index++))
		fi
		if [[ "${fake_distro}" != "Cygwin" && "${fake_distro}" != "Msys" && "${fake_distro}" != "Windows - Modern" && "${display[@]}" =~ "disk" ]]; then
			mydisk=$(echo -e "$labelcolor Disk:$textcolor $diskusage")
			out_array=( "${out_array[@]}" "$mydisk" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "cpu" ]]; then
			mycpu=$(echo -e "$labelcolor CPU:$textcolor $cpu")
			out_array=( "${out_array[@]}" "$mycpu" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "gpu" ]] && [[ "$gpu" != "Not Found" ]]; then
			mygpu=$(echo -e "$labelcolor GPU:$textcolor $gpu")
			out_array=( "${out_array[@]}" "$mygpu" )
			((display_index++))
		fi
		if [[ "${display[@]}" =~ "mem" ]]; then
			mymem=$(echo -e "$labelcolor RAM:$textcolor $mem")
			out_array=( "${out_array[@]}" "$mymem" )
			((display_index++))
		fi
		if [[ -n "$custom_lines_string" ]]; then
			customlines
		fi
	fi
	if [[ "$display_type" == "ASCII" ]]; then
		asciiText
	else
		if [[ "${display[@]}" =~ "host" ]]; then echo -e "$myinfo"; fi
		if [[ "${display[@]}" =~ "distro" ]]; then echo -e "$mydistro"; fi
		if [[ "${display[@]}" =~ "kernel" ]]; then echo -e "$mykernel"; fi
		if [[ "${distro}" == "Android" ]]; then
			echo -e "$mydevice"
			echo -e "$myrom"
			echo -e "$mybaseband"
			echo -e "$mykernel"
			echo -e "$myuptime"
			echo -e "$mycpu"
			echo -e "$mymem"
		else
			if [[ "${display[@]}" =~ "uptime" ]]; then echo -e "$myuptime"; fi
			if [[ "${display[@]}" =~ "pkgs" && "$mypkgs" != "Unknown" ]]; then echo -e "$mypkgs"; fi
			if [[ "${display[@]}" =~ "shell" ]]; then echo -e "$myshell"; fi
			if [[ "${display[@]}" =~ "res" ]]; then
				test -z "$myres" || echo -e "$myres"
			fi
			if [[ "${display[@]}" =~ "de" ]]; then
				if [[ "${DE}" != "Not Present" ]]; then echo -e "$myde"; fi
			fi
			if [[ "${display[@]}" =~ "wm" ]]; then
				test -z "$mywm" || echo -e "$mywm"
				if [[ "${Win_theme}" != "Not Applicable" && "${Win_theme}" != "Not Found" ]]; then
					test -z "$mywmtheme" || echo -e "$mywmtheme"
				fi
			fi
			if [[ "${display[@]}" =~ "gtk" ]]; then
				if [[ "$gtk_2line" == "yes" ]]; then
					test -z "$mygtk2" || echo -e "$mygtk2"
					test -z "$mygtk3" || echo -e "$mygtk3"
				else
					test -z "$mygtk" || echo -e "$mygtk"
				fi
				test -z "$myicons" || echo -e "$myicons"
				test -z "$myfont" || echo -e "$myfont"
			fi
			if [[ "${display[@]}" =~ "disk" ]]; then echo -e "$mydisk"; fi
			if [[ "${display[@]}" =~ "cpu" ]]; then echo -e "$mycpu"; fi
			if [[ "${display[@]}" =~ "gpu" ]]; then echo -e "$mygpu"; fi
			if [[ "${display[@]}" =~ "mem" ]]; then echo -e "$mymem"; fi
		fi
	fi
}
detecthost;detectkernel;

x=19
y=2
tput cup $y $x
echo -e " ${Color_RED}USER:  ${Color_Blue} $myUser"; 
y=$((y+1))
tput cup $y $x
echo -e " ${Color_RED}HOSTNAME:  ${Color_Blue} $myHost"; 
y=$((y+1))
tput cup $y $x
echo -e " ${Color_RED}kernel:  ${Color_Blue} $kernel"; 
y=$((y+1))
tput cup $y $x
echo -e " ${Color_RED}TODAY:  ${Color_Blue} $day";
y=$((y+1))
tput cup $y $x
echo -e " ${Color_RED}DATE:  ${Color_Blue} $NOW";
y=$((y+1))
tput cup $y $x
printf " ${Color_RED}CPU:  ${Color_Blue} ";
cat /proc/cpuinfo  | grep process| wc -l;
y=$((y+1))
tput cup $y $x
printf " ${Color_RED}CPU:  ${Color_Blue} ";
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' ;
y=$((y+1))
tput cup $y $x
printf " ${Color_RED}IPs:  ${Color_Blue} ";
hostname -I;
y=$((y+1))
tput cup $y $x
echo -e " ${Color_RED}Screen:  ${Color_Blue} $(tput cols) X $(tput lines)";
y=$((y+10))
x=0
tput cup $y $x


sleep 0
# sleep 5