local item = ...

function item:on_created()
  self:set_shadow("big")
  self:set_can_disappear(true)
  self:set_brandish_when_picked(false)
end

function item:on_obtaining(variant, savegame_variable)
  local meat_counter = self:get_game():get_item("meat_counter")
  if meat_counter:get_variant() == 0 then
    meat_counter:set_variant(1)
  end
  meat_counter:add_amount(1)
end