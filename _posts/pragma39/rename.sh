#!/bin/bash

oldname=$1
newname=$2

echo "Renaming $oldname files to $newname..."
for file in `ls *.md`; do
  newfile=`echo $file | sed "s/$oldname/$newname/"`
  mv $file $newfile
done
