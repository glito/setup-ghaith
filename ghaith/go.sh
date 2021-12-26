display_center(){
    columns="$(tput cols)"
    printf "%*s\n" $(( (${#1} + columns) / 2)) "$1"
}
clear
FILEf=$HOME/ghaith/go.sh
tempd=$HOME/ghaith/temp


myfile="ghaith"
mytemp=$myfile/temp/log-last-one.g
mytemp2=$myfile/temp/results2.g



sleep 0
cd
cd
cd
cd

source ./$myfile/headers.sh



START_TIME=$SECONDS

{
    sleep 0.1
	if [ -d "$tempd" ] ; then  echo -e "XXX\n10\n temp good.\nXXX";else mkdir $tempd;echo -e "XXX\n10\n temp maked.\nXXX";fi
	if [ -d "$tempd" ] ; then  echo -e "XXX\n20\n temp good.\nXXX";else mkdir $tempd;echo -e "XXX\n20\n temp maked.\nXXX";fi
	if [ -f "$FILEf" ] ; then  echo -e "XXX\n30\n FILEf good.\nXXX";else echo -e "XXX\n30\n FILEf maked.\nXXX";fi
	echo -e "XXX\n30\n installing update \nXXX";
	#sudo apt-get update 
	echo -e "XXX\n40\n\nXXX";
	echo -e "XXX\n50\n\nXXX";
	echo -e "XXX\n60\n\nXXX";
	echo -e "XXX\n70\n\nXXX";
	echo -e "XXX\n80\n\nXXX";
	echo -e "XXX\n90\n\nXXX";
	echo -e "XXX\n100\n\nXXX";

} |whiptail --title "Please wait LOADING ..." --gauge "LOADING" 6 60 0


whiptail --title " Welcome $USERNAME to setup of ghaith server " --checklist --separate-output --notags  "Choose:" 20 78 15 \
"update" "do update  " off \
"upgrade" "do upgrade  " off \
"root_password" "root password  " off \
"kvm" "install kvm  " off \
"snap-store" "install snap store    " off \
"nano" "install nano  " off \
"tasksel" "install tasksel  " off \
"snap-changes" "snap changes  " off \
"snap-watch" "snap watch  " off \
"next-menu" "NEXT MENU  " off \
"exit" "exit  " off 2>$mytemp

# while read choice
# do
# 	case $choice in
# 		update) 
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo apt-get update 
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		upgrade) 
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo apt-get upgrade -y
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		root_password)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo passwd root
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		kvm)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo apt install -y qemu qemu-kvm libvirt-daemon bridge-utils virt-manager virtinst;
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		snap-store)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo snap install snap-store;
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		nano)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo apt-get -y install nano;
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		tasksel)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		sudo apt-get -y install tasksel;
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		snap-changes)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		snap changes;
# 		snap watch $nnsnap
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		snap-watch)
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		nnsnap=$(whiptail --inputbox "Enter snap watch number" 10 78 3>&1 1>&2 2>&3)
# 		whiptail --ok-button Done --msgbox "snap watch number : |$nnsnap| started watching" 10 78
# 		snap watch $nnsnap
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		exit) 
#         echo -e "${Yellow}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}";
# 		echo "You chose exit"
#         echo -e "${Color_Green}▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇${Color_Off}"
# 		;;
# 		*)
# 		;;
# 	esac
# done < $mytemp

{
while read choice
do
	case $choice in
		update) 
		# 3427216
		echo -e "XXX\n10\n update \nXXX";
		sudo apt-get update 
		echo -e "XXX\n15\n update done \nXXX";
		sleep 0.1
		;;
		upgrade) 
		echo -e "XXX\n20\n upgrade \nXXX";
		sudo apt-get upgrade -y
		echo -e "XXX\n25\n upgrade done \nXXX";
		sleep 0.1
		;;
		root_password)
		echo -e "XXX\n30\n root_password \nXXX";
		sudo passwd root
		echo -e "XXX\n35\n root_password done \nXXX";
		sleep 0.1
		;;
		kvm)
		echo -e "XXX\n40\n kvm \nXXX";
		sudo apt install -y qemu qemu-kvm libvirt-daemon bridge-utils virt-manager virtinst;
		echo -e "XXX\n45\n kvm done \nXXX";
		sleep 0.1
		;;
		snap-store)
		echo -e "XXX\n50\n kvm \nXXX";
		sudo snap install snap-store;
		echo -e "XXX\n55\n kvm done \nXXX";
		sleep 0.1
		;;
		nano)
		echo -e "XXX\n60\n kvm \nXXX";
		sudo apt-get -y install nano;
		echo -e "XXX\n65\n kvm done \nXXX";
		sleep 0.1
		;;
		tasksel)
		echo -e "XXX\n70\n tasksel \nXXX";
		sudo apt-get -y install tasksel;
		echo -e "XXX\n75\n tasksel done \nXXX";
		sleep 0.1
		;;
		snap-changes)
		echo -e "XXX\n80\n snap changes \nXXX";
		snap changes;
		echo -e "XXX\n85\n snap changes done \nXXX";
		sleep 0.1
		;;
		snap-watch)
		echo -e "XXX\n90\n snap watch \nXXX";
		nnsnap=$(whiptail --inputbox "Enter snap watch number" 10 78 3>&1 1>&2 2>&3)
		whiptail --ok-button Done --msgbox "snap watch number : |$nnsnap| started watching" 10 78
		snap watch $nnsnap
		echo -e "XXX\n95\n snap watch done \nXXX";
		sleep 0.1
		;;
		exit) 
		echo "You chose exit"
		sleep 0.1
		;;
		*)
		;;
	esac
done < $mytemp
		ELAPSED_TIME=$(($SECONDS - $START_TIME))
		echo -e "XXX\n100\n THE END TOTAL TIME = $ELAPSED_TIME s \nXXX";
display_center "test"
		sleep 1
} |whiptail --title "Please wait LOADING ..." --gauge "LOADING" 6 60 0


ELAPSED_TIME=$(($SECONDS - $START_TIME))

display_center "THE END TOTAL TIME = $ELAPSED_TIME s"