-- Hyprland bind configuration
-- by @arsnm

local mainMod = "SUPER"
local uwsm = "uwsm app -- "

-- Programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "fuzzel"
local browser = "google-chrome"

hl.bind(
    mainMod .. " + SHIFT + Q",
    hl.dsp.window.close()
)
hl.bind(
    mainMod .. " + SHIFT + M",
    hl.dsp.exit()
)
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd(uwsm .. "hyprlock")
)

hl.bind(
    mainMod .. " + Return",
    hl.dsp.exec_cmd(uwsm .. terminal)
)
hl.bind(
    mainMod .. " + G",
    hl.dsp.exec_cmd(uwsm .. browser)
)
hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(uwsm .. fileManager)
)
hl.bind(
    "ALT + space",
    hl.dsp.exec_cmd(uwsm .. menu)
)
hl.bind(
    mainMod .. " + V",
    hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
)

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen()
)
hl.bind(
    mainMod .. " + I",
    hl.dsp.window.float({ action = "toogle" })
)
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo()
)
hl.bind(
    mainMod .. " + O",
    hl.dsp.layout("togglesplit")
)

hl.bind(
    mainMod .. " + J",
    hl.dsp.focus({ direction = "down" })
)
hl.bind(
    mainMod .. " + K",
    hl.dsp.focus({ direction = "up" })
)
hl.bind(
    mainMod .. " + H",
    hl.dsp.focus({ direction = "left" })
)
hl.bind(
    mainMod .. " + L",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    mainMod .. " + SHIFT + J",
    hl.dsp.window.move({ direction = "down" })
)
hl.bind(
    mainMod .. " + SHIFT + K",
    hl.dsp.window.move({ direction = "up" })
)
hl.bind(
    mainMod .. " + SHIFT + H",
    hl.dsp.window.move({ direction = "left" })
)
hl.bind(
    mainMod .. " + SHIFT + L",
    hl.dsp.window.move({ direction = "right" })
)

for i = 1, 10 do
    local key = i % 10 -- 10 maps to 0
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

hl.bind(
    mainMod .. " + period",
    hl.dsp.focus({ workspace = "e+1" })
)
hl.bind(
    mainMod .. " + comma",
    hl.dsp.focus({ workspace = "e-1" })
)
hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e+1" })
)
hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e-1" })
)

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)
hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- Screen mode

local screenshot_dir = "/home/arsnm/Pictures/screenshots/"

hl.on("keybinds.submap", function(submap)
    submap = (not submap or submap == "") and "default" or submap
    local cmd = string.format(
        "notify-send -t 1500 -h string:x-dunst-stack-tag:submap 'Hyprland' 'SUBMAP: %s'",
        submap
    )
    os.execute(cmd)
end)

hl.bind(
    mainMod .. " + S",
    hl.dsp.submap("screen_mode")
)

hl.define_submap("screen_mode", function()
    hl.bind(
        "C",
        hl.dsp.exec_cmd(uwsm .. "hyprpicker")
    )
    hl.bind(
        "R",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m region --clipboard-only")
    )
    hl.bind(
        "SHIFT + R",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m region -o " .. screenshot_dir)
    )
    hl.bind(
        "W",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m window --clipboard-only")
    )
    hl.bind(
        "SHIFT + W",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m window -o " .. screenshot_dir)
    )
    hl.bind(
        "S",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m active -m output --clipboard-only")
    )
    hl.bind(
        "SHIFT + S",
        hl.dsp.exec_cmd(uwsm .. "hyprshot -m active -m output -o " .. screenshot_dir)
    )

    hl.bind(
        "M",
        function()
            hl.dispatch(hl.dsp.workspaceopt({ layout = "master" }))
            hl.dispatch(hl.dsp.submap({ name = "reset" }))
        end
    )
    hl.bind(
        "D",
        function()
            hl.dispatch(hl.dsp.workspaceopt({ layout = "dwindle" }))
            hl.dispatch(hl.dsp.submap({ name = "reset" }))
        end
    )

    hl.bind(
        "Escape",
        hl.dsp.submap("reset")
    )
end)

-- Window mode

hl.bind(
    mainMod .. " + W",
    hl.dsp.submap("window_mode"),
    { release = true }
)

hl.define_submap("window_mode", function()
    hl.bind(
        "J",
        hl.dsp.focus({ direction = "down" })
    )
    hl.bind(
        "K",
        hl.dsp.focus({ direction = "up" })
    )
    hl.bind(
        "H",
        hl.dsp.focus({ direction = "left" })
    )
    hl.bind(
        "L",
        hl.dsp.focus({ direction = "right" })
    )

    hl.bind(
        "SHIFT + J",
        hl.dsp.window.move({ direction = "down" })
    )
    hl.bind(
        "SHIFT + K",
        hl.dsp.window.move({ direction = "up" })
    )
    hl.bind(
        "SHIFT + H",
        hl.dsp.window.move({ direction = "left" })
    )
    hl.bind(
        "SHIFT + L",
        hl.dsp.window.move({ direction = "right" })
    )

    hl.bind(
        "U",
        hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
        { repeating = true }
    )
    hl.bind(
        "P",
        hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
        { repeating = true }
    )
    hl.bind(
        "I",
        hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
        { repeating = true }
    )
    hl.bind(
        "O",
        hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
        { repeating = true }
    )

    hl.bind(
        "Escape",
        hl.dsp.submap("reset")
    )
end)
