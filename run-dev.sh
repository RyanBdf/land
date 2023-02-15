#!/bin/bash
. ./shell/source/func.sh
. ./shell/source/color.sh

folder=./projects/
projects=()

for project in $(ls ./projects); do
  if [ -d $folder${project%.*} ]; then
    projects+=(${project%.*})
  fi
done

project_list=(${projects[@]})

if [ ${#project_list[@]} -eq 0 ]; then
  fail "No projects detected"
  exit
fi

while [ -z $project_key ] || [ -z "${project_list[$project_key]}" ] || [[ ! $project_key =~ ^[0-9]+$ ]]; do
  for key in ${!project_list[@]}; do
    choice "[$key]${project_list[$key]}"
  done | xargs -L4 | column -t

  read -p "What project would you want to run ? " project_key
done

project_name=${project_list[$project_key]}

clear
echo "------------------------------"
echo -e "Project : $(format "Green" "${project_name}")"
echo -e "Branch : $(format "Green" "$(git -C $folder$project_name branch | grep \* | cut -d ' ' -f2)")"
echo -e "Project path : $(format "Green" "$folder$project_name")"
echo "------------------------------"
read -p "Confirm ? (y/n)" confirm

if [ "$confirm" == "n" ]; then
  fail "Run canceled"
  exit 1
else
  clear
  project_shell=./shell/run/${project_name}.sh
  if [ -f "$project_shell" ]; then
    . $project_shell
  else
    fail "Cannot found file : $project_shell"
  fi
fi
