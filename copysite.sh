#!/bin/bash 

# Default value
dryrun=true

# Parse command-line options
while getopts "n" flag; do
  case "${flag}" in
    n)
      dryrun=false
      ;;
    *) # Handle invalid options
      echo "Usage: $0 [-n] <oldsite> <olddate> <newsite> <newdate>"
      econ "Date format = yyyy-mm-dd"
      exit 1
      ;;
  esac
done


# Shift parsed options away
shift $((OPTIND - 1))

# Check for required arguments
if [ $# -ne 4 ]; then
  echo "Missing arguments"
  echo "Usage: $0 [-n] <oldsite> <olddate> <newsite> <newdate>"
  exit 1
fi

oldsite=$1
olddate=$2
newsite=$3
newdate=$4


echo $oldsite $newsite

if [[ "${oldsite}" =~ [^0-9] || "${newsite}" =~ [^0-9] ]]; then
  echo "Error: Both oldsite and newsite must be numeric."
  echo "Usage: $0 [-n] <oldsite> <newsite>"
  exit 1
fi

# Dry run output
if [ "$dryrun" = true ]; then
  echo "Dry run mode is ON"
  echo "Pretend copying PRAGMA site: $oldsite to $newsite"
else
  echo "Dry run mode is OFF"
  echo "Preparing to copy PRAGMA site: $oldsite to $newsite"
  read -p "Are you sure you want to proceed? (y/N): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
  fi
fi

# find all files for old site and update text 
files=$(find . \( -path "./images" -o -path "./_site" -o -path "./.git" -o -path "./.jekyll-cache" \) -prune -o -type f -name "*$oldsite*" -print)
for file in $files; do
  newfile=`echo $file | sed -e "s/$oldsite/$newsite/g" -e "s/${olddate}/${newdate}/g"`
  if [ "$dryrun" = true ]; then
    echo "Would copy $file to $newfile"
    LC_ALL=C sed -e "s/pragma${oldsite}/pragma${newsite}/g" \
                 -e "s/PRAGMA${oldsite}/PRAGMA${newsite}/g" \
                 -e "s/PRAGMA ${oldsite}/PRAGMA ${newsite}/g" \
                 -e "s/\r//g" -e "s/${olddate}/${newdate}/g" \
                 -e "s/^date: [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}/date: ${newdate}/" "$file" 
    echo
    echo
  else
    mkdir -p _posts/pragma${newsite}
    echo "Copying $file to $newfile"
    LC_ALL=C sed -e "s/pragma${oldsite}/pragma${newsite}/g" \
                 -e "s/PRAGMA${oldsite}/PRAGMA${newsite}/g" \
                 -e "s/PRAGMA ${oldsite}/PRAGMA ${newsite}/g" \
                 -e "s/\r//g" -e "s/${olddate}/${newdate}/g" \
                 -e "s/^date: [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}/date: ${newdate}/" "$file" > "${newfile}"
    echo
    echo
  fi
done

# copy over images
if [ "$dryrun" = true ]; then
  echo "Would copy over ./images/pragma${oldsite}"
else
  echo "Copying ./images/pragma${oldsite}"
  cp -r ./images/pragma${oldsite} ./images/pragma${newsite}
fi

echo "Please manually add $newsite to css/main.scss"
