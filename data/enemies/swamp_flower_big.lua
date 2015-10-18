local enemy = ...

-- Swamp Flower, Big: a swamp flower that can shoot fire.

local can_shoot = true

function enemy:on_created()
  self:set_life(1); self:set_damage(8)
  self:create_sprite("enemies/swamp_flower_big")
  self:set_size(32, 32); self:set_origin(16, 27)
  self:set_pushed_back_when_hurt(false)
  self:set_invincible(true)
end

local function shoot_fire()
  local sprite = enemy:get_sprite()
  local x, y, layer = enemy:get_position()

  sprite:set_animation("shooting")
  sol.timer.start(enemy, 500, function()
    sol.audio.play_sound("lamp")
    local flame = enemy:create_enemy({ breed = "projectiles/fireball_simple", x = x, y = y })
  end)
end

function enemy:on_restarted()
  can_shoot = true
  sol.timer.start(enemy, 200, function()
    if can_shoot then
      shoot_fire()
      can_shoot = false
      sol.timer.start(enemy, 1500, function() can_shoot = true end)
    end
    return true  -- Repeat the timer.
  end)
end