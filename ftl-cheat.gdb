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
set $scrap    = 9999999
set $fuel     = 999
set $drones   = 999
set $missiles = 999

# Game state address and offsets
set $game_state_addr = 0x8e3500
set $scrap_offset = 0x760
set $drone_offset = 0xbf0
set $fuel_offset = 0x700

set $drone_system_installed_offset_1 = 0x748
set $drone_system_installed_offset_2 = 0x10

set $missile_offset_1 = 0x88
set $missile_offset_2 = 0x2b8

# There are two different locations for drones depending on if a system is installed
set $drone_offset_1 = 0x90
set $drone_offset_2 = 0x290

# Print the game state addr (useful for more debugging)
printf "-------------------------------------------------\n"
printf "Game state address: 0x%08x\n", *$game_state_addr
printf "-------------------------------------------------\n"

# Set resources
set $scrap_addr = *($game_state_addr) + $scrap_offset
printf "Scrap value (0x%08x) is currently:   %d\n", $scrap_addr, *$scrap_addr
set *$scrap_addr = $scrap

set $fuel_addr = *($game_state_addr) + $fuel_offset
printf "Fuel value (0x%08x) is currently:    %d\n", $fuel_addr, *$fuel_addr
set *$fuel_addr = $fuel

set $missiles_addr = *(*$game_state_addr + $missile_offset_1) + $missile_offset_2
printf "Missile value (0x%08x) is currently: %d\n", $missiles_addr, *$missiles_addr
set *$missiles_addr = $missiles

set $drone_system_installed_addr = *(*$game_state_addr + $drone_system_installed_offset_1) + $drone_system_installed_offset_2
if *$drone_system_installed_addr == 0xffffffff
  printf "Drone system NOT installed\n"
  set $drone_addr = *($game_state_addr) + $drone_offset
else
  printf "Drone system installed\n"
  set $drone_addr = *(*($game_state_addr) + $drone_offset_1) + $drone_offset_2
end
printf "Drones value (0x%08x) is currently:  %d\n", $drone_addr, *$drone_addr
set *$drone_addr = $drones



# Quit the debugger
detach
quit
