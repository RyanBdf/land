#!/bin/bash

########################################################################################
# functins                                                                             #
########################################################################################
title() {
  string="         $1         "
  echo -e "\e[${Cyan}m"
  echo $(printf '=%.0s' $(seq 1 ${#string}))
  echo "${string}"
  echo $(printf '=%.0s' $(seq 1 ${#string}))
  echo -e "\e[${Color_Off}m"
}

warning() {
  string="         $1         "
  echo -e "\e[${Yellow}m"
  echo "${string}"
  echo $(printf '=%.0s' $(seq 1 ${#string}))
  echo -e "\e[${Color_Off}m"
}

choice() {
  string=" $1"
  echo -e "\e[${Yellow}m${string}\e[${Color_Off}m"
}

success() {
  string="   $1   "
  echo -e "\e[${On_Green}m"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo "${string}"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo -e "\e[${Color_Off}m"
}

fail() {
  string="   $1   "
  echo -e "\e[${On_Red}m"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo "${string}"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo -e "\e[${Color_Off}m"
}

etape() {
  string=" $1 "
  echo -e "\e[${Cyan}m"
  echo "${string}"
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
  echo -e "\e[${Color_Off}m"
}

format() {
  styles=($1)
  codes=''

  pos=$((${#styles[*]} - 1))
  last=${styles[$pos]}

  for value in ${styles[@]}; do
    if [[ $value == $last ]]; then
      string="${!value}"
      codes+=$string
    else
      string="${!value};"
      codes+=$string
    fi
  done

  echo -e "\e[${codes}m$2\e[${Color_Off}m"
}

########################################################################################
# alert                                                                                #
########################################################################################
err_report() {
  string="         Error on line $1 (┛°Д°)┛ ┻━┻         "
  echo -e "\e[${On_Red}m"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo "${string}"
  echo $(printf '—%.0s' $(seq 1 ${#string}))
  echo -e "\e[${Color_Off}m"
}
