#!/bin/bash

gdb -p $(ps -ef|grep FTL.amd64 | head -n 1 | awk '{print $2}') --command=ftl-cheat.gdb

