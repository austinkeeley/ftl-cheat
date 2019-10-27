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


# Amount of resources to set
set $scrap = 9999999
set $fuel = 999
set $drones = 999
set $missiles = 999

# Game state address and offsets
set $game_state_addr = 0x8e3500
set $scrap_offset = 0x760
set $drone_offset = 0x290
set $fuel_offset = 0x700

set $other_offset = 0x88
set $missile_offset = 0x2b8

set $drone_offset_1 = 0x90
set $drone_offset_2 = 0x290

# Set scrap and fuel
set *(*($game_state_addr) + $scrap_offset) = $scrap
set *(*($game_state_addr) + $fuel_offset) = $fuel
set *(*(*($game_state_addr) + $other_offset) + $missile_offset) = $missiles
set *(*(*($game_state_addr) + $drone_offset_1) + $drone_offset_2) = $drones

# Quit the debugger
detach
quit
