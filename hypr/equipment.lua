-- ============================================================
-- equipment.lua — Hyprland 0.55+ Lua config
-- Monitors, input devices
-- ============================================================

-- ── Monitors ─────────────────────────────────────────────────
-- Internal display (commented out, use HDMI instead)
-- hl.monitor({
--     output   = "eDP-1",
--     mode     = "1920x1080@60.00200",
--     position = "0x0",
--     scale    = "1",
-- })

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@74.97",
    position = "0x0",
    scale    = "1",
    -- mirror = "eDP-1",  -- uncomment to mirror eDP-1
})

-- ── Input ─────────────────────────────────────────────────────
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        -- kb_options = "grp:alt_shift_toggle",
        kb_rules   = "",

        follow_mouse  = 1,
        accel_profile = "flat",
        sensitivity   = 1.0,

        touchpad = {
            natural_scroll = false,
        },
    },
})