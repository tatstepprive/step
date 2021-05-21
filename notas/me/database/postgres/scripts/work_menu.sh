#!/bin/bash

menu()
{
  tput clear
  echo "                            ${bold}WORK ON THE DATABASES${offbold}"
  echo "                            ${bold}---------------------${offbold}"
  echo " "
  echo "${bold}- 1-${offbold} Check filesystem space             ${bold}-13-${offbold} TODO"
  echo "${bold}- 2-${offbold} Check if databases are running     ${bold}-14-${offbold} TODO"
  echo "${bold}- 3-${offbold} Add DB sigle schema                ${bold}-15-${offbold} TODO"
  echo "${bold}- 4-${offbold} Add DB multi schemas               ${bold}-16-${offbold} TODO"
  echo "${bold}- 5-${offbold} TODO"
  echo "${bold}- 6-${offbold} TODO"
  echo "${bold}- 7-${offbold} TODO"
  echo "${bold}- 8-${offbold} TODO"
  echo "${bold}- 9-${offbold} TODO"
  echo "${bold}-10-${offbold} TODO"
  echo "${bold}-11-${offbold} TODO"
  echo "${bold}-12-${offbold} TODO"
  echo " "
  echo "                                    ${bold}-0- EXIT${offbold}"
  echo " "
  echo -e "                                ${bold}Your choice : ${offbold}\c"
  read answer
}
#-----------------------------------------------------------
# check the filesystems that are filled to more than 60%
#-----------------------------------------------------------
check_filesystem()
{
  echo
  echo -e "Checking the filesystem:\n"
  ./work_scripts/check_filesystem.sh
  echo -e "${bold}\n\nPress RETURN to continue${offbold}"
  read tmp
}

#-----------------------------------------------------------
# add new db with single schema
#-----------------------------------------------------------
add_db_single_schema()
{
  echo
  echo "Adding DB with single schema"
#  ./work_scripts/add_db_single_schema.sh
  echo -e "${bold}\n\nPress RETURN to continue${offbold}"
  read tmp
}

#-----------------------------------------------------------
# to implement
#-----------------------------------------------------------
to_do()
{
  echo
  echo "[INFO] this item is in TODO list. "
#  ./work_scripts/add_db_single_schema.sh
  echo -e "${bold}\n\nPress RETURN to continue${offbold}"
  read tmp
}


main()
{
DATABASE_LIST=/tmp/database_list

#  retrieve_db

  answer=9
  while [ ${answer} != "0" ]
  do
    menu

    case $answer in
       1) check_filesystem
          ;;
       2) check_db
          ;;
       3) add_db_single_schema
          ;;
       4) to_do
          ;;
       5) to_do
          ;;
       6) to_do
          ;;
       7) to_do
          ;;
       8) to_do
          ;;
       9) to_do
          ;;
       10) to_do
           ;;
       11) to_do
           ;;
       12) to_do
           ;;
       13) to_do
           ;;
       14) to_do
           ;;
       15) to_do
           ;;
       16) to_do
           ;;
       0) echo -e '\nBYE-BYE! Have a nice day :)\n\n'; exit 0
          ;;
       *) echo -e "\n\n                              ${bold}INVALID CHOICE !!!!!${offbold}"
          sleep 3
          menu
          ;;
    esac
  done
}

bold=`tput smso`
offbold=`tput rmso`
main

