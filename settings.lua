-- settings.lua
-- Defines configuration settings for the mod.


data:extend({
  -- What the shells target.
  {
    type = "string-setting",
    name = "smart-cannon-shells-target-force-condition",
    setting_type = "startup",
    default_value = "not-same",
    allowed_values = {
      "not-same",
      "not-friend",
      "enemy",
      "ally",
      "friend",
      "same",
      "all",
    },
  },
});


-- EOF
