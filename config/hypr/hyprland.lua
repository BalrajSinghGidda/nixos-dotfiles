-- Hyprland Lua configuration (ported from hyprland.conf)
-- See https://wiki.hypr.land/Configuring/Start/ for Lua config docs.

------------------
---- MONITORS ----
------------------

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target")
  hl.exec_cmd("dms run")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- change to qt6ct if you have that

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout = "us",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = false,
    },
  },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = "rgba(00ff99ee)",
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
  },
})

hl.config({
  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },
})

---------------
-- ANIMATIONS --
---------------

hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

--------------
---- MASTER ---
--------------

hl.config({
  master = {
    new_status = "master",
  },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces / move window
for i = 1, 5 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Special keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d spi::kbd_backlight set +10%"))
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d spi::kbd_backlight set 10%-"))

hl.bind(
  "Print",
  hl.dsp.exec_cmd([[sh -c 'DIR="$HOME/Pictures/Screenshots"; mkdir -p "$DIR"; FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"; grim "$FILE" && cat "$FILE" | wl-copy && notify-send "Screenshot saved" "$FILE"']])
)
hl.bind(
  mainMod .. " + S",
  hl.dsp.exec_cmd([[sh -c 'DIR="$HOME/Pictures/Screenshots"; mkdir -p "$DIR"; FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"; grim -g "$(slurp)" "$FILE" && cat "$FILE" | wl-copy && notify-send "Screenshot saved" "$FILE"']])
)

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------
---- DMS THEME ----
-------------------

require("dms.colors")
require("dms.layout")
require("dms.windowrules")

require("dms.outputs")

require("dms.cursor")
