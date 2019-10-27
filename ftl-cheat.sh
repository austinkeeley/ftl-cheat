#!/bin/bash

echo "[*] ftl-cheat"

CURRENT_USER=$(whoami)

if [[ $CURRENT_USER != "root" ]]
then
    echo "[!] Warning: not running as root. May not be able to connect to process"
fi

FTL_PID="$(ps -ef| grep FTL.amd64 | grep -v grep | head -n 1 | awk '{print $2}')"

if [[ $FTL_PID == "" ]]
then
    echo "[!] Could not find PID for FTL.amd64. Is the game running?"
    exit 1
fi

echo "[*] FTL game PID is $FTL_PID"

echo "[*] Attaching to process"
gdb -p $FTL_PID --command=ftl-cheat.gdb -q

echo "[*] Done"
