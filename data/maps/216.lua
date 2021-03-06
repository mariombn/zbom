local map = ...
local game = map:get_game()
local door_timer = nil

---------------------------------------------
-- Dungeon 7: Tower of the Winds (Floor 7) --
---------------------------------------------

function map:on_started(destination)
  map:set_doors_open("door_statues")
end

function switch_door:on_activated()
  map:open_doors("door_shutter")
end

function sensor_door_close:on_activated()
  map:close_doors("door_statues")
  if not door_timer then
    door_timer = sol.timer.start(5000, function()
      map:open_doors("door_statues")
    end)
  end
end

function sensor_door_open:on_activated()
  map:open_doors("door_statues")
end