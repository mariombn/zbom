local map = ...
local game = map:get_game()

-----------------------------------------------
-- Outside World B6 (Snowpeak) - Snow drifts --
-----------------------------------------------

local function random_walk(npc)
  local m = sol.movement.create("random_path")
  m:set_speed(32)
  m:start(npc)
  npc:get_sprite():set_animation("walking")
end

function map:on_started(destination)
  random_walk(npc_anouki_1)
end

function npc_anouki_1:on_interaction()
  game:start_dialog("anouki_1.0.snowpeak")
end

function sensor_snow_drift_1:on_activated()
  x, y, l = map:get_hero():get_position()
  map:get_hero():set_position(x, y, 1)
end

function sensor_snow_drift_2:on_activated()
  x, y, l = map:get_hero():get_position()
  map:get_hero():set_position(x, y, 0)
end