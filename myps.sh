#!/bin/bash


printf '%-8s%-8s%-15s%-35s%-20s\n'  "PID" "PPID" "State" "Name" "Path"
Var1="$(ls -dv /proc/*[0-9]*)"

for i in $Var1
do

f1="$(grep -w 'Pid' $i/status | tr -d '\t')";
f2="$(grep -w 'PPid' $i/status | tr -d '\t')";
f3="$(grep -w 'State' $i/status | tr -d '\t')";
f4="$(grep -w 'Name' $i/status | tr -d '\t')";

if [ "$f1" = "Pid:2" ]
    then
    f4="[""$f4""]";
    f5="stream"
elif [ "$f2" = "PPid:2" ]
   then
   f4="[""$f4""]";
   f5="stream"
else
   f5="$(file $i/exe)";
fi

printf '%-8s%-8s%-15s%-35s%-20s\n'  "${f1/Pid:}" "${f2/PPid:}" "${f3/State:}" "${f4/Name:}" "${f5/$i\/exe: symbolic link to }"
done
