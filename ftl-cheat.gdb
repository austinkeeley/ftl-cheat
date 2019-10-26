#
# ftl-cheat.gdb
#
# How to use:
#  1. Launch FTL
#  2. Start a new game or continue an existing one
#  3. Run the following command to attach to the FTL process and run this file
#
#      sudo gdb -p $(ps -ef|grep FTL.amd64 | head -n 1 | awk '{print $2}') --command=ftl-cheat.gdb
#


# Amount of scrap to set
set $scrap = 9999999

# Number of drones
set $drone = 99


set $game_state_addr = 0x8e3500
set $scrap_offset = 0x760
set $drone_offset = 0x290

#set *(*(0x8e3500) + 0x760) = $scrap
set *(*($game_state_addr) + $scrap_offset) = $scrap
#set *(*($game_state_addr) + $drone_offset) = $drone

# Quit the debugger
quit
