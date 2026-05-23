-- ============================================================
-- animations.lua — Hyprland 0.55+ Lua config
-- ============================================================

-- Animation bezier curves
hl.curve("md3_decel",   { type = "bezier", points = { {0.05, 0.7}, {0.1, 1}    } })
hl.curve("md3_accel",  { type = "bezier", points = { {0.3, 0},   {0.8, 0.15} } })
hl.curve("menu_decel", { type = "bezier", points = { {0.1, 1},   {0, 1}      } })
hl.curve("menu_accel", { type = "bezier", points = { {0.38, 0.04}, {1, 0.07} } })

-- Windows
hl.animation({ leaf = "windows",    enabled = true,  speed = 3,   bezier = "md3_decel" })
hl.animation({ leaf = "windowsIn",  enabled = true,  speed = 3,   bezier = "md3_decel",  style = "gnomed" })
hl.animation({ leaf = "windowsOut", enabled = true,  speed = 3,   bezier = "md3_accel",  style = "popin 60%" })

-- Border
hl.animation({ leaf = "border",      enabled = false })
hl.animation({ leaf = "borderangle", enabled = false })

-- Fade
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "fadePopups", enabled = true, speed = 1, bezier = "md3_decel" })

-- Zoom
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "md3_decel" })

-- Layers
hl.animation({ leaf = "layersIn",     enabled = true,  speed = 3,   bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut",    enabled = true,  speed = 1.6, bezier = "menu_accel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true,  speed = 2,   bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut",enabled = true,  speed = 1.6, bezier = "menu_accel" })

-- Workspaces
hl.animation({ leaf = "workspaces",       enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel",  style = "slidefadevert 15%" })