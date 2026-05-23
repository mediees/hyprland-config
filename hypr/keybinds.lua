-- ============================================================
-- keybinds.lua — Hyprland 0.55+ Lua config
-- ============================================================

local mainMod = "SUPER"

-- ── Applications ─────────────────────────────────────────────
hl.bind(mainMod .. " + T",            hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd("nautilus"))
-- hl.bind("SHIFT + T",               hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + B",            hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + C",    hl.dsp.exec_cmd("code"))
-- hl.bind("SHIFT + O",               hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + O",            hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + A",            hl.dsp.exec_cmd("AmneziaVPN"))

-- ── Power menu ───────────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd("wlogout -C ~/.config/wlogout/style.css -l ~/.config/wlogout/layout -b 5"))

-- ── Lock screen ──────────────────────────────────────────────
hl.bind("F8", hl.dsp.exec_cmd("hyprlock"))

-- ── Workspaces — switch ──────────────────────────────────────
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- ── Workspaces — move window ─────────────────────────────────
for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- ── Special (scratchpad) workspace ───────────────────────────
hl.bind(mainMod .. " + S",          hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + SHIFT + S",  hl.dsp.window.move({ workspace = "special" }))

-- ── Focus movement ───────────────────────────────────────────
hl.bind(mainMod .. " + left",   hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right",  hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",     hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",   hl.dsp.focus({ direction = "d" }))

-- ── Window movement ──────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",     hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",   hl.dsp.window.move({ direction = "d" }))

-- ── Main window actions ──────────────────────────────────────
hl.bind(mainMod .. " + Q",  hl.dsp.window.close())
hl.bind(mainMod .. " + F",  hl.dsp.window.fullscreen())
hl.bind("ALT + SPACE",      hl.dsp.window.float({ action = "toggle" }))

-- ── Window switching ─────────────────────────────────────────
hl.bind(mainMod .. " + Tab",         hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- ── Mouse — drag / resize ────────────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Screenshots ──────────────────────────────────────────────
hl.bind("Print",         hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/png/screenshots"))

-- ── Volume ───────────────────────────────────────────────────
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("F2", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("F4", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))