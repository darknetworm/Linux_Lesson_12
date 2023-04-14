#!/bin/bash

Pid="$(pgrep bash)"

nice -n 5 time gzip -c huge_file > huge5.gz &
nice -n 20 time gzip -c huge_file > huge20.gz &
Pid="$(pgrep gzip)"
for proc in $Pid
do
taskset -p -c 3 $proc
done

ps fo pid,pcpu,pri,ni,cmd

wait
