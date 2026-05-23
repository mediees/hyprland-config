-- ============================================================
-- autostart.lua — Hyprland 0.55+ Lua config
-- ============================================================

hl.on("hyprland.start", function()
    -- Notification daemon
    hl.exec_cmd("awww-daemon")

    -- Status bar
    hl.exec_cmd("waybar")

    -- Wallpaper (with a 1-second delay to let the compositor settle)
    hl.timer(function()
        local userConfigs = os.getenv("HOME") .. "/.config"
        hl.exec_cmd("hyprpaper " .. userConfigs .. "/hypr/wallpapers/wallpaper.jpg")
    end, { timeout = 1000, type = "oneshot" })

    -- Fix sound (uncomment if needed)
    -- hl.exec_cmd("sudo " .. os.getenv("HOME") .. "/.config/hypr/fix_sound.sh")
end)