-- ============================================================
-- rules.lua — Hyprland 0.55+ Lua config
-- Window rules, layer rules, decoration
-- ============================================================

-- ── Decoration & blur ────────────────────────────────────────
hl.config({
    decoration = {
        blur = {
            enabled           = true,
            size              = 5,
            passes            = 2,
            new_optimizations = true,
            xray              = false,
            noise             = 0.05,
        },
    },
})

-- ── Layer rules ──────────────────────────────────────────────

-- wlogout
hl.layer_rule({
    name  = "logout_dialog",
    match = { namespace = "logout_dialog" },
    no_anim = true,
    blur    = true,
})

-- rofi
hl.layer_rule({
    name  = "rofi",
    match = { namespace = "rofi" },
    no_anim = true,
    blur    = true,
})

-- hyprshot — color picker
hl.layer_rule({
    name  = "hyprpicker",
    match = { namespace = "hyprpicker" },
    no_anim = true,
    blur    = false,
})

-- hyprshot — selection overlay
hl.layer_rule({
    name  = "selection",
    match = { namespace = "selection" },
    no_anim = true,
    blur    = false,
})