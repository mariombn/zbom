local map = ...
local game = map:get_game()
local poe_guided
local position_step = 1
local positions = {
  { x = 176, y = 1040 },
  { x = 520, y = 1016 },
  { x = 600, y = 896 },
  { x = 264, y = 776 },
  { x = 104, y = 600 },
  { x = 208, y = 440 },
  { x = 400, y = 600 },
  { x = 624, y = 624 },
  { x = 696, y = 432 },
  { x = 640, y = 248 },
  { x = 528, y = 168 },
  { x = 376, y = 256 },
  { x = 192, y = 176 },
  { x = 176, y = 16 }
}

--------------------------------------------
-- Outside World B4 (Forest of Deception) --
--------------------------------------------

if game.deception_fog_overlay == nil then
  if game:get_item("bottle_1"):get_variant() == 8 or -- If hero has a Poe Soul,
   game:get_item("bottle_2"):get_variant() == 8 or -- then it's easier to see.
   game:get_item("bottle_3"):get_variant() == 8 or
   game:get_item("bottle_4"):get_variant() == 8 then
    game.deception_fog_overlay = sol.surface.create("effects/fog.png")
    game.deception_fog_overlay:set_opacity(168)
    poe_guided = true
  else
    game.deception_fog_overlay = sol.surface.create("effects/fog.png")
    game.deception_fog_overlay:set_opacity(216)
    poe_guided = false
    poe_guide:remove()
  end
end

function map:on_started(destination)
  local hero_x, hero_y = map:get_hero():get_position()
  if hero_y < 1104 then  -- If coming from the south end of the map, fog is already present.
    if game.deception_fog_overlay then game.deception_fog_overlay:fade_in(150, function()
      if poe_guided then game.deception_fog_overlay:set_opacity(168) else game.deception_fog_overlay:set_opacity(216) end
    end) end
  end
end

local function next_poe_step()
  position_step = position_step + 1
  if position_step <= 14 then
    local position = (positions[position_step])
    local m = sol.movement.create("target")
    m:set_speed(40)
    m:set_smooth(true)
    m:set_target(position.x, position.y)
    poe_guide:get_sprite():set_animation("walking")
    m:start(poe_guide)
    sol.timer.start(map, 8000, function() next_poe_step() end)
  end
end

function sensor_poe_guide:on_activated()
  if hero:get_direction() == 1 then -- Only start if hero is facing up (coming from other Forest map).
    local position = (positions[position_step])
    local m = sol.movement.create("target")
    m:set_speed(48)
    m:set_smooth(true)
    m:set_target(position.x, position.y)
    poe_guide:get_sprite():set_animation("walking")
    m:start(poe_guide)
    sol.timer.start(map, 5000, function() next_poe_step() end)
  end
end

function to_A3:on_activated()
  game.deception_fog_overlay:fade_out()
  sol.timer.start(game, 5000, function() game.deception_fog_overlay = nil end)
end

function to_B2:on_activated()
  game.deception_fog_overlay:fade_out()
  sol.timer.start(game, 5000, function() game.deception_fog_overlay = nil end)
end

function to_C3:on_activated()
  game.deception_fog_overlay:fade_out()
  sol.timer.start(game, 5000, function() game.deception_fog_overlay = nil end)
end

function map:on_draw(dst_surface)
  if game.deception_fog_overlay ~= nil then game.deception_fog_overlay:draw(dst_surface) end
end