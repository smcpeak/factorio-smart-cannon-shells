-- SmartCannonShells data.lua
-- Extend the global data table to describe the mod elements.

-- Technology to make smart cannon shells.
local smart_cannon_shell_technology = {
  type = "technology",
  name = "smart-cannon-shell",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-cannon-shell",
    },
    {
      type = "unlock-recipe",
      recipe = "smart-explosive-cannon-shell",
    },
  },
  icon = "__SmartCannonShells__/graphics/technology/smart-cannon-shell-technology.png",
  icon_size = 64,
  order = "e-c-c-3",                   -- After Tank, and RoboTanks too if that is installed.
  prerequisites = {
    "tank"                             -- Ordinary tank, which implies red circuit.
  },
  unit = data.raw["technology"].tank.unit,   -- Same cost as Tank.
};

local smart_uranium_cannon_shell_technology = {
  type = "technology",
  name = "smart-uranium-cannon-shell",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-uranium-cannon-shell",
    },
    {
      type = "unlock-recipe",
      recipe = "smart-explosive-uranium-cannon-shell",
    },
  },
  icon = "__SmartCannonShells__/graphics/technology/smart-uranium-cannon-shell-technology.png",
  icon_size = 64,
  order = "e-a-b-2",                   -- After Uranium Ammunition.
  prerequisites = {
    "uranium-ammo"
  },

  -- In versions before 0.3.0, the research cost was the same as uranium
  -- shells, but that is a pretty steep cost, especially as the main
  -- balance mechanism is the per-item cost, not the research.  Also I
  -- think some people might install the mod just to see what it does
  -- and be dissuaded by the long research wait before even seeing it in
  -- action.  So, in 0.3.0 I made this nearly the same as above, just
  -- the fairly minor cost of Tank, although with the added requirement
  -- of yellow science, mainly just to ensure this technology appears
  -- after the non-uranium smart shells in the tech tree.
  unit = {
    count = 250,
    ingredients = {
      {
        "automation-science-pack",
        1
      },
      {
        "logistic-science-pack",
        1
      },
      {
        "chemical-science-pack",
        1
      },
      {
        "military-science-pack",
        1
      },
      {
        "utility-science-pack",
        1
      }
    },
    time = 30
  }
};


-- Extend the data table with a recipe, item, and projectile for a
-- smart shell based on 'base_prefix'.
local function add_smart_shell(base_prefix)
  local base_shell_name      = base_prefix .. "-shell";
  local base_projectile_name = base_prefix .. "-projectile";

  local recipe_name     = "smart-" .. base_shell_name;
  local item_name       = "smart-" .. base_shell_name;
  local projectile_name = "smart-" .. base_shell_name .. "-projectile";

  -- The recipe is one base shell and one red circuit.
  local recipe = {
    type = "recipe",
    name = recipe_name,
    enabled = false,
    energy_required = 2,               -- 2 seconds to build.
    ingredients = {
      {
        amount = 1,
        name = base_shell_name,
        type = "item",
      },
      {
        amount = 1,
        name = "advanced-circuit",
        type = "item",
      },
    },
    results = {
      {
        amount = 1,
        name = item_name,
        type = "item",
      },
    },
  };

  -- Smart shell is basically the same as an ordinary shell
  -- except we override the projectile.
  local base_item = data.raw.ammo[base_shell_name];
  local item = {
    type = "ammo",
    name = item_name,
    description = item_name,
    icon = "__SmartCannonShells__/graphics/icons/" .. item_name .. "-item.png",
    icon_size = 32,
    ammo_type = table.deepcopy(base_item.ammo_type),
    ammo_category = table.deepcopy(base_item.ammo_category),
    magazine_size = base_item.magazine_size,
    subgroup = "ammo",
    order = base_item.order .. "-s[smart]",
    stack_size = base_item.stack_size,
  };
  item.ammo_type.action.action_delivery.projectile = projectile_name;

  -- The smart projectile is the same except we eliminate friendly fire.
  local projectile = table.deepcopy(data.raw.projectile[base_projectile_name]);
  projectile.name = projectile_name;

  -- https://lua-api.factorio.com/latest/prototypes/ProjectilePrototype.html
  -- https://lua-api.factorio.com/latest/types/ForceCondition.html
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
