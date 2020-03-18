-- SmartCannonShells data.lua
-- Extend the global data table to describe the mod elements.

-- Technology to make smart cannon shells.
local smart_cannon_shell_technology = {
  type = "technology",
  name = "smart-cannon-shell-technology",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-cannon-shell-recipe",
    },
    {
      type = "unlock-recipe",
      recipe = "smart-explosive-cannon-shell-recipe",
    },
  },
  icon = "__SmartCannonShells__/graphics/technology/smart-cannon-shell-technology.png",
  icon_size = 64,
  order = "e-c-c-3",                   -- After Tanks, and RoboTanks too if that is installed.
  prerequisites = {
    "tanks"                            -- Ordinary tank, which implies red circuit.
  },
  unit = data.raw["technology"].tanks.unit,   -- Same cost as Tanks.
};

local smart_uranium_cannon_shell_technology = {
  type = "technology",
  name = "smart-uranium-cannon-shell-technology",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-uranium-cannon-shell-recipe",
    },
    {
      type = "unlock-recipe",
      recipe = "smart-explosive-uranium-cannon-shell-recipe",
    },
  },
  icon = "__SmartCannonShells__/graphics/technology/smart-uranium-cannon-shell-technology.png",
  icon_size = 64,
  order = "e-a-b-2",                   -- After Uranium Ammunition.
  prerequisites = {
    "uranium-ammo"
  },
  unit = data.raw["technology"]["uranium-ammo"].unit,
};


-- Extend the data table with a recipe, item, and projectile for a
-- smart shell based on 'base_prefix'.
local function add_smart_shell(base_prefix)
  local base_shell_name      = base_prefix .. "-shell";
  local base_projectile_name = base_prefix .. "-projectile";

  local recipe_name     = "smart-" .. base_shell_name .. "-recipe";
  local item_name       = "smart-" .. base_shell_name .. "-item";
  local projectile_name = "smart-" .. base_shell_name .. "-projectile";

  -- The recipe is one base shell and one red circuit.
  local recipe = {
    type = "recipe",
    name = recipe_name,
    enabled = false,
    energy_required = 2,               -- 2 seconds to build.
    ingredients = {
      {base_shell_name, 1},
      {"advanced-circuit", 1},
    },
    result = item_name,
  };

  -- Smart shell is basically the same as an ordinary shell
  -- except we override the projectile.
  local base_item = data.raw.ammo[base_shell_name];
  local item = {
    type = "ammo",
    name = item_name,
    description = item_name,
    icon = "__SmartCannonShells__/graphics/icons/" .. item_name .. ".png",
    icon_size = 32,
    ammo_type = table.deepcopy(base_item.ammo_type),
    magazine_size = base_item.magazine_size,
    subgroup = "ammo",
    order = base_item.order .. "-s[smart]",
    stack_size = base_item.stack_size,
  };
  item.ammo_type.action.action_delivery.projectile = projectile_name;

  -- The smart projectile is the same except we eliminate friendly fire.
  local projectile = table.deepcopy(data.raw.projectile[base_projectile_name]);
  projectile.name = projectile_name;

  -- https://wiki.factorio.com/Prototype/Projectile
  -- https://wiki.factorio.com/Types/ForceCondition
  --
  -- There is a bug here: with "not-friend", I cannot shoot rocks and
  -- trees.  With "not-same", rocks and trees can be shot, but so can
  -- allies.
  projectile.force_condition = "not-friend";

  -- Remove friendly fire on splash damage.
  --
  -- The idea is to dig around in the projectile effects to find an area
  -- effect, which should be the explosive splash damage, and set it to
  -- only affect non-friend forces.  The force_condition on the
  -- projectile itself does not accomplish that.
  --
  -- This code tries to be defensive at each step in case other mods
  -- have altered the projectile effects.
  local fa = projectile.final_action;
  if (fa ~= nil) then
    local ad = fa.action_delivery;
    if (ad ~= nil) then
      local te = ad.target_effects;
      if (te ~= nil) then
        for i, effect in ipairs(te) do
          local ea = effect.action;
          if (ea ~= nil and ea.type == "area") then
            log(projectile_name .. ": found action to modify: " ..
                serpent.line(ea));
            ea.force = "not-friend";
          end;
        end;
      end;
    end;
  end;

  data:extend{recipe, item, projectile};
end;

add_smart_shell("cannon");
add_smart_shell("explosive-cannon");
add_smart_shell("uranium-cannon");
add_smart_shell("explosive-uranium-cannon");

data:extend{
  smart_cannon_shell_technology,
  smart_uranium_cannon_shell_technology,
};


-- EOF
