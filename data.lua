local beacon = data.raw["beacon"]["beacon"]
beacon.TFMG_thermal = {
  heat_ratio = 1,--being machines that don't actually do any work, they output all their heat back out.
  max_working_temperature = 180,
  max_safe_temperature = 185,--beacons are fragile
  
  connections = { --Y shape, this will make rows possible, but require slightly more consideration.
    { position = {-1, -1}, direction = defines.direction.north },
    { position = {1, -1}, direction = defines.direction.north },
    { position = {0, 1}, direction = defines.direction.south },
  }
}
--beacons cant be rotated, and man i dont wanna deal with that right now, but its practically mandatory for this library.

local electric_furnace = data.raw["furnace"]["electric-furnace"]
electric_furnace.TFMG_thermal = {
  heat_ratio = 0.8, --electric furnaces are inneficient
  max_working_temperature = 700,
  max_safe_temperature = 900,--electric furnaces are very resilliant. but are a risk towards their neighbours
}
electric_furnace.energy_usage = "500kW" --because furnaces can send 80% of their heat back out, their energy usage has to be much higher

local ground_radiator = data.raw["assembling-machine"]["ground-radiator"]
ground_radiator.hidden = false

local ground_radiator_item = data.raw.item["ground-radiator"]
ground_radiator_item.hidden = false

table.insert(data.raw.technology["advanced-material-processing-2"].effects,{type = "unlock-recipe",recipe = "heat-pipe"})
table.insert(data.raw.technology["advanced-material-processing-2"].effects,{type = "unlock-recipe",recipe = "ground-radiator"})

data:extend({
  {--ground radiator
    type = "recipe",
    name = "ground-radiator",
    energy_required = 5,
    enabled = false,
    ingredients = {
      { type = "item", name = "steel-plate", amount = 10 },
      { type = "item", name = "heat-pipe", amount = 5 },
    },
    results = { 
      { type = "item", name = "ground-radiator", amount = 1 }
    },
  },
})