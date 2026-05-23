-- ============================================================
-- hyprland.lua — Hyprland 0.55+ main config entry point
-- ~/.config/hypr/hyprland.lua
--
-- Hierarchy mirrors the original hyprlang setup:
--   autostart.lua  — exec-once / startup apps
--   keybinds.lua   — all keybindings
--   equipment.lua  — monitors + input
--   animations.lua — animation curves & configs
--   rules.lua      — decoration, layer rules, window rules
-- ============================================================

local config = os.getenv("HOME") .. "/.config/hypr"

require("autostart")
require("keybinds")
require("equipment")
require("animations")
-- require("window")  -- uncomment if you add window.lua
require("rules")